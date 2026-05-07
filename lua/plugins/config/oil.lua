local keymap = require("core.keymap")
local nmap = keymap.nmap

function _G.get_oil_winbar()
  local dir = require("oil").get_current_dir()
  if dir then
    return vim.fn.fnamemodify(dir, ":~")
  else
    return vim.api.nvim_buf_get_name(0)
  end
end

require("oil").setup({
  default_file_explorer = true,
  win_options = {
    winbar = "%!v:lua.get_oil_winbar()",
  },
  keymaps = {
    ["<C-h>"] = false,
    ["<C-l>"] = false,
    ["<C-k>"] = false,
    ["<C-j>"] = false,
    ["<C-r>"] = "actions.refresh", -- 刷新
    ["<leader>y"] = "actions.yank_entry", -- 复制文件路径
    ["g."] = false, -- 显示帮助
    ["zh"] = "actions.toggle_hidden", -- 显示隐藏文件
    ["\\"] = { "actions.select", opts = { horizontal = true } }, -- 水平分屏
    ["|"] = { "actions.select", opts = { vertical = true } }, -- 垂直分屏
    ["-"] = "actions.close", -- 关闭 oil
    ["<leader>e"] = "actions.close", -- 关闭 oil
    ["<BS>"] = "actions.parent", -- 上一页
    ["<C-p>"] = "actions.preview",
    ["<ESC>"] = "actions.close",
    ["q"] = "actions.close",
  },
  preview = {
    max_width = 0.5, -- 宽度占比
    min_width = { 40, 0.4 },
    max_height = 0.5, -- 高度占比（控制在下半部分）
    min_height = { 5, 0.1 },
    border = "rounded",
    win_options = {
      winblend = 0,
    },
  },
})

nmap("<leader>e", ":Oil<CR>", { desc = "文件管理" })

local img_exts = { "jpg", "jpeg", "png", "gif", "webp", "bmp", "avif" }

-- 判断当前文件是否是图片
local function is_image(filename)
  -- 获取文件路径后缀名
  local ext = filename:match("%.(%w+)$")
  if not ext then return false end
  ext = ext:lower()
  for _, e in ipairs(img_exts) do
    if ext == e then return true end
  end
  return false
end

local has_image, image_api = pcall(require, "image")

local image_cache = {}

-- 清除图片缓存
local function cache_evict(filepath)
  local entry = image_cache[filepath]
  if entry and entry.image then pcall(function() entry.image:clear() end) end
  image_cache[filepath] = nil
end

-- 清除全部图片缓存
local function cache_clear_all()
  for k, _ in pairs(image_cache) do
    cache_evict(k)
  end
end

local function get_or_make_image(filepath, win, buf)
  if not has_image then return nil end

  local stat = vim.uv.fs_stat(filepath)
  local mtime = stat and stat.mtime and stat.mtime.sec or 0

  local entry = image_cache[filepath]
  if entry and entry.mtime == mtime and entry.image then
    -- 复用缓存：刷新一下绑定的 window/buffer
    entry.image.window = win
    entry.image.buffer = buf
    return entry.image
  end

  -- 失效或没有，重新生成
  if entry then cache_evict(filepath) end

  local ok, img = pcall(image_api.from_file, filepath, {
    window = win,
    buffer = buf,
    with_virtual_padding = true,
    inline = true,
  })
  if not ok or not img then return nil end

  image_cache[filepath] = { mtime = mtime, image = img }
  return img
end

local preview_winid = nil
local preview_bufer = nil
local preview_image = nil

-- 异步 / 竞态控制
local render_seq = 0
local debounce_timer = nil
local DEBOUNCE_MS = 80

-- 只把当前显示中的图从屏幕摘掉，不动缓存
local function hide_preview_image()
  if preview_image then
    pcall(function() preview_image:clear() end)
    preview_image = nil
  end
end

local function stop_debounce()
  if debounce_timer then
    pcall(function()
      if not debounce_timer:is_closing() then debounce_timer:stop() end
      debounce_timer:close()
    end)
    debounce_timer = nil
  end
end

-- 关闭预览
local function close_preview()
  stop_debounce()
  -- 让所有在飞的回调失效
  render_seq = render_seq + 1

  hide_preview_image()
  if preview_winid and vim.api.nvim_win_is_valid(preview_winid) then vim.api.nvim_win_close(preview_winid, true) end
  preview_winid = nil
  preview_bufer = nil

  -- preview_buffer 在这里被丢弃，缓存里 image 绑的旧 buffer 已无意义
  cache_clear_all()
end

local function clear_preview_image()
  if preview_image then
    pcall(function() preview_image:clear() end)
    preview_image = nil
  end
end

local function ensure_preview_win(entry_name)
  local editor_w = vim.o.columns
  local editor_h = vim.o.lines
  local win_w = math.floor(editor_w * 0.45)
  local win_h = math.floor(editor_h * 0.45)
  local row = editor_h - win_h - 3
  local col = editor_w - win_w - 1

  if not preview_bufer or not vim.api.nvim_buf_is_valid(preview_bufer) then
    preview_bufer = vim.api.nvim_create_buf(false, true)
  end

  local win_opts = {
    relative = "editor",
    row = row,
    col = col,
    width = win_w,
    height = win_h,
    style = "minimal",
    border = "rounded",
    title = " " .. entry_name .. " ",
    title_pos = "center",
    focusable = false,
    noautocmd = true,
  }

  if preview_winid and vim.api.nvim_win_is_valid(preview_winid) then
    vim.api.nvim_win_set_config(preview_winid, win_opts)
  else
    preview_winid = vim.api.nvim_open_win(preview_bufer, false, win_opts)
    vim.api.nvim_set_option_value("winblend", 10, { win = preview_winid })
    vim.api.nvim_set_option_value("cursorline", false, { win = preview_winid })
  end

  return preview_bufer, preview_winid, win_w, win_h
end

local function show_image_fallback(entry_name, filepath)
  local buf = ensure_preview_win(entry_name)
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {
    "[image preview]",
    "需要安装并启用 image.nvim",
    "且终端需支持 Kitty/iTerm2 图像协议",
    "",
    filepath,
  })
end

local function preview_text(filepath, entry_name, seq)
  if seq ~= render_seq then return end
  hide_preview_image()

  local ok, lines = pcall(vim.fn.readfile, filepath, "", 100)
  if not ok or #lines == 0 then
    close_preview()
    return
  end

  local buf, _, _, _ = ensure_preview_win(entry_name)
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)

  local ft = vim.filetype.match({ filename = filepath })
  if ft then vim.bo[buf].filetype = ft end
end

local function preview_image_file(filepath, entry_name, seq)
  if seq ~= render_seq then return end
  if not has_image then
    show_image_fallback(entry_name, filepath)
    return
  end

  local buf, win, win_w, win_h = ensure_preview_win(entry_name)
  vim.bo[buf].modifiable = true
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})

  -- 只摘掉旧图，不清缓存
  hide_preview_image()

  vim.schedule(function()
    if seq ~= render_seq then return end
    if not (preview_winid and vim.api.nvim_win_is_valid(preview_winid)) then return end

    local img = get_or_make_image(filepath, win, buf)
    if not img then
      show_image_fallback(entry_name, filepath)
      return
    end

    if seq ~= render_seq then return end

    local ok = pcall(function() img:render({ width = win_w, height = win_h }) end)

    -- 渲染失败: evict 后重试一次
    if not ok then
      cache_evict(filepath)
      img = get_or_make_image(filepath, win, buf)
      if img then pcall(function() img:render({ windth = win_w, height = win_h }) end) end
    end
    preview_image = img
  end)
end

local function do_open_preview()
  local oil = require("oil")
  local entry = oil.get_cursor_entry()
  if not entry or entry.type ~= "file" then
    close_preview()
    return
  end

  local dir = oil.get_current_dir()
  if not dir then return end
  local filepath = dir .. entry.name

  -- 申请新一代渲染
  render_seq = render_seq + 1
  local seq = render_seq

  if is_image(entry.name) then
    preview_image_file(filepath, entry.name, seq)
  else
    preview_text(filepath, entry.name, seq)
  end
end

-- 防抖入口：用户停下来 80 ms 才真正预览
local function open_preview()
  stop_debounce()
  debounce_timer = vim.uv.new_timer()
  debounce_timer:start(DEBOUNCE_MS, 0, function()
    stop_debounce()
    vim.schedule(do_open_preview)
  end)
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function(args)
    local buf = args.buf

    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = buf,
      callback = function() open_preview() end,
    })

    vim.api.nvim_create_autocmd("BufLeave", {
      buffer = buf,
      callback = function() close_preview() end,
    })
  end,
})
