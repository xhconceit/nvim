local keymap = require('core.keymap')
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
    ["q"] = "actions.close"
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

nmap("<leader>e", ":Oil<CR>", {desc = "文件管理"})

local img_exts = { "jpg", "jpeg", "png", "gif", "webp", "bmp", "avif" }

local function is_image(filename)
  local ext = filename:match("%.(%w+)$")
  if not ext then
    return false
  end

  ext = ext:lower()

  for _, e in ipairs(img_exts) do
    if ext == e then
      return true
    end
  end
  return false
end

local preview_winid = nil
local preview_bufer = nil

local function close_preview()
  if preview_winid and vim.api.nvim_win_is_valid(preview_winid) then
    vim.api.nvim_win_close(preview_winid, true)
  end
  preview_winid = nil
  preview_bufer = nil
end

local function open_preview()
  local oil = require('oil')
  local entry = oil.get_cursor_entry()
  if not entry or entry.type ~= "file" then
    close_preview()
    return
  end

  local dir = oil.get_current_dir()
  if not dir then
    return
  end
  local filepath = dir .. entry.name

  local ok, lines = pcall(vim.fn.readfile, filepath, "", 100)
  if not ok or #lines == 0 then
    close_preview()
    return
  end


  local editor_w = vim.o.columns
  local editor_h = vim.o.lines
  local win_w = math.floor(editor_w * 0.45)
  local win_h = math.floor(editor_h * 0.45)
  local row = editor_h - win_h - 3
  local col = editor_w - win_w - 1

  if not preview_bufer or not vim.api.nvim_buf_is_valid(preview_bufer) then
    preview_bufer = vim.api.nvim_create_buf(false, true)
  end
  vim.api.nvim_buf_set_lines(preview_bufer, 0, -1, false, lines)

  local ft = vim.filetype.match({ filename = filepath })
  if ft then
    vim.bo[preview_bufer].filetype = ft
  end

  local win_opts = {
    relative = "editor",
    row = row,
    col = col,
    width = win_w,
    height = win_h,
    style = "minimal",
    border = "rounded",
    title = " " .. entry.name .. " ",
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

end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function (args)
    local buf = args.buf

    vim.api.nvim_create_autocmd("CursorMoved", {
      buffer = buf,
      callback = function ()
        open_preview()
      end
    })

    vim.api.nvim_create_autocmd("BufLeave", {
      buffer = buf,
      callback = function ()
        close_preview()
      end
    })
  end
})



