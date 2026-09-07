local M = {}

function M.setup()
  local opt = vim.opt

  -- 编码 utf-8
  opt.encoding = "UTF-8"
  opt.fileencoding = "utf-8"

  -- 界面
  opt.termguicolors = true
  opt.laststatus = 3
  opt.showmode = false

  -- 行号
  opt.number = true
  opt.relativenumber = true
  opt.cursorline = true
  opt.cursorlineopt = "number"

  -- 边距
  opt.signcolumn = "yes"
  opt.scrolloff = 8
  opt.sidescrolloff = 8

  -- 右侧参考线，超过表示代码太长了，考虑换行
  opt.colorcolumn = "100"

  -- 不可见字符
  opt.list = true
  opt.listchars = {
    tab = "» ",
    trail = "·",
    nbsp = "␣",
    extends = "…",
    precedes = "…",
  }

  -- 窗口分隔线和文件末尾
  opt.fillchars = {
    eob = " ",
    vert = "│",
    fold = " ",
    foldopen = "",
    foldclose = "",
    foldsep = " ",
    diff = "╱",
  }

  -- 使用 Tree-sitter 计算代码折叠，默认保持全部展开
  opt.foldmethod = "expr"
  opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
  opt.foldcolumn = "1"
  opt.foldlevel = 99
  opt.foldlevelstart = 99
  opt.foldenable = true

  -- 补全最多显示10行
  opt.pumheight = 10

  -- 为补全菜单和浮动窗口增加轻微透明效果
  opt.pumblend = 10
  opt.winblend = 10

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

  -- 命令行仅在输入命令或显示消息时出现
  opt.cmdheight = 0
  opt.winborder = "rounded"

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
