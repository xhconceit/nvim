local M = {}

function M.setup()
  local opt = vim.opt

  -- 编码 utf-8
  opt.encoding = "UTF-8"
  opt.fileencoding = "utf-8"

  -- 界面
  opt.number = true
  opt.relativenumber = true
  opt.cursorline = true
  opt.signcolumn = "yes"
  opt.scrolloff = 8
  opt.sidescrolloff = 8
  opt.termguicolors = true
  -- 自动补全不自动选中
  opt.completeopt = "menu,menuone,noselect,noinsert"
  opt.termguicolors = true -- 启用 24 位 RGB 颜色
  -- 显示左侧图标指示列
  opt.signcolumn = "yes"
  -- 右侧参考线，超过表示代码太长了，考虑换行
  opt.colorcolumn = "100"
  -- 不可见字符的显示，这里只把空格显示为一个点
  opt.list = true
  opt.listchars = "space:·,tab:.."
  -- 补全最多显示10行
  opt.pumheight = 10

  -- 编辑
  opt.expandtab = true
  opt.tabstop = 2
  opt.shiftwidth = 2
  opt.smartindent = true
  opt.wrap = false

  -- 搜索
  opt.ignorecase = true
  opt.smartcase = true

  -- 边输入边搜索
  opt.incsearch = true

  -- 当文件被外部程序修改时，自动加载
  opt.autoread = true

  -- 光标在行首尾时<Left><Right>可以跳到下一行
  opt.whichwrap = "<,>,[,]"

  -- 允许隐藏被修改过的buffer
  opt.hidden = true

  -- 禁止创建备份文件
  opt.backup = false
  opt.writebackup = false
  opt.swapfile = false

  -- 命令行高为 2
  opt.cmdheight = 2

  -- 窗口
  opt.splitright = true
  opt.splitbelow = true

  -- 系统交互
  opt.mouse = "a"
  -- 默认寄存器不与系统剪贴板同步
  opt.clipboard = ""
  opt.undofile = true
  opt.confirm = true

  -- 原生补全菜单
  opt.completeopt = {
    "menuone",
    "noselect",
    "popup",
  }
end

return M
