local keymap = require("core.keymap")
local M = {}

-- 终端实例缓存：name -> {buf, win, job}
local terms = {}

-- 默认窗口大小
local DEFAULT_WIDTH = 0.85
local DEFAULT_HEIGHT = 0.8

-- 计算浮动窗口几何
local function get_win_opts(opts)
  local editer_w = vim.o.columns
  local editer_h = vim.o.lines
  local win_w = math.floor(editer_w * (opts.width or DEFAULT_WIDTH))
  local win_h = math.floor(editer_h * (opts.height or DEFAULT_HEIGHT))
  local row = math.floor((editer_h - win_h) / 2) - 1
  local col = math.floor((editer_w - win_w) / 2)

  return {
    relative = "editor",
    row = row,
    col = col,
    width = win_w,
    height = win_h,
    style = "minimal",
    border = opts.border or "rounded",
    title = opts.title or " Terminal ",
    title_pos = "center",
  }
end

-- 终端是否可见
local function is_open(t) return t and t.win and vim.api.nvim_win_is_valid(t.win) end

-- 当前终端 buffer 是否还活着
local function is_alive() return t and t.buf and vim.api.nvim_buf_is_valid(t.buf) end

-- 隐藏 (不销毁，保留 job 与历史)
local function hide(t)
  if is_open(t) then vim.api.nvim_win_close(t.win, true) end
  t.win = nil
end

-- 销毁：彻底 buffer/window, job 由 on_exit 触发
local function destroy(t)
  if is_open(t) then pcall(vim.api.nvim_win_close, t.win, true) end
  if is_alive(t) then pcall(vim.api.nvim_buf_delete(t.buf), { force = true }) end
  t.win, t.buf, t.job = nil, nil, nil
end

-- 显示
local function show(t, opts)
  if not is_alive(t) then
    t.buf = vim.api.nvim_create_buf(false, true)
    vim.bo[t.buf].bufhidden = "hide"
  end

  t.win = vim.api.nvim_open_win(t.buf, true, get_win_opts(opts))
  vim.wo[t.win].winblend = 0
  vim.wo[t.win].cursorline = false
  vim.wo[t.win].number = false
  vim.wo[t.win].relativenumber = false
  vim.wo[t.win].signcolumn = "no"

  -- 第一次打开: 启动 shell
  if not t.job then
    local cmd = opts.cmd or vim.o.shell
    t.job = vim.fn.jobstart(cmd, {
      term = true,
      cmd = opts.cmd,
      env = opts.env,
      on_exit = function(_, _, _)
        -- 进程退出时清理，on_exit 在 fast-event 上下文, 必须 schedule
        vim.schedule(function() destroy(t) end)
      end,
    })
  end
  vim.cmd("startinsert")
end

-- 切换: name 区分多个实例(如 "shell" / "lazygit")
function M.toogle(name, opts)
  name = name or "default"
  opts = opts or {}
  terms[name] = terms[name] or {}
  local t = terms[name]

  if is_open(t) then
    hide(t)
  else
    show(t, opts)
  end
end

-- 强制关闭（杀进程）
function M.kill(name)
  local t = terms[name or "default"]
  if t and t.job then pcall(vim.fn.jobstop, t.job) end
end

-- 关闭所有可见浮窗（不杀进程）
function M.hide_all()
  for _, t in pairs(terms) do
    hide(t)
  end
end

-- 编辑区尺寸变化: 重排已打开的浮窗
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    for _, t in pairs(terms) do
      if is_open(terms) then vim.api.nvim_win_set_config(t.win, get_win_opts({})) end
    end
  end,
})

-- 终端 buffer 内的快捷键
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(args)
    local buf = args.buf

    -- 找到这个 buffer 属于那个 term 实例
    local function owner()
      for _, t in pairs(terms) do
        if t.buf == buf then return t end
      end
    end

    -- ESC 在终端模式下隐藏浮窗（不杀进程）
    vim.keymap.set("t", "<ESC>", function()
      local t = owner()
      if t then hide(t) end
    end, {
      buffer = buf,
      desc = "隐藏浮动窗口",
    })

    -- Crtl-Esc 退出 terminal 模式回到 normal
    vim.keymap.set("t", "<C-esc>", [[<C-\><C-n>]], {
      buffer = buf,
      desc = "退出终端模式",
    })

    -- normal 模式下 q 也能隐藏
    vim.keymap.set("n", "q", function()
      local t = owner()
      if t then hide(t) end
    end, {
      buffer = buf,
      desc = "隐藏浮动窗口",
    })
  end,
})

keymap.nmap("<leader>tt", function() M.toogle("shell") end, { desc = "浮动终端" })
keymap.nmap("<leader>tT", function()
  -- 在当前文件所在目录打开一个独立的终端
  M.toogle("shell-cmd", {
    cmd = vim.fn.expand("%:p:h"),
    title = " " .. vim.fn.expand("%:p:h:t") .. " ",
  })
end, { desc = "浮动终端（当前文件目录）" })

keymap.nmap("<leader>tg", function() M.toogle("lazygit", { cmd = "lazygit", title = "LazyGit" }) end, {
  desc = "浮动 LazyGit",
})

keymap.nmap("<leader>tk", function() M.hide_all() end, {
  desc = "隐藏全部浮动终端",
})

return M
