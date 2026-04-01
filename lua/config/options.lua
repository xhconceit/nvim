local o = vim.opt


-- 编码 utf-8
o.encoding = "UTF-8"
o.fileencoding = "utf-8"
o.number = true -- 显示行号
o.relativenumber = true -- 显示相对行号
o.cursorline = true -- 当前光标所在行高亮

--- 顶部底部保留 8 行空白
o.scrolloff = 8
o.sidescrolloff = 8

-- 缩进2个空格等于一个Tab
o.tabstop = 2 -- 2 个空格显示一个 tab 符
o.softtabstop = 2 --2 个空格显示一个 tab 符
o.shiftround = true
o.expandtab = true --- 使用空格代替 tab

-- >> << 时移动长度
o.shiftwidth = 2
o.shiftwidth = 2

o.smartindent = true -- 开始新行时自动对齐上一行的 tab
o.autoindent = true

-- 搜索大小写不敏感，除非包含大写
o.ignorecase = true
o.smartcase = true

-- 搜索高亮
o.hlsearch = true

-- 边输入边搜索
o.incsearch = true

-- 命令行高为 2
o.cmdheight = 2

-- 当文件被外部程序修改时，自动加载
o.autoread = true

-- 光标在行首尾时<Left><Right>可以跳到下一行
o.whichwrap = "<,>,[,]"

-- 允许隐藏被修改过的buffer
o.hidden = true

-- 禁止创建备份文件
o.backup = false
o.writebackup = false
o.swapfile = false

-- 自动补全不自动选中
o.completeopt = "menu,menuone,noselect,noinsert"

o.termguicolors = true -- 启用 24 位 RGB 颜色

-- 显示左侧图标指示列
o.signcolumn = "yes"

-- 右侧参考线，超过表示代码太长了，考虑换行
o.colorcolumn = "100"

-- 不可见字符的显示，这里只把空格显示为一个点
o.list = true
o.listchars = "space:·,tab:.."

-- 补全最多显示10行
o.pumheight = 10


local g = vim.g

g.mapleader = " " -- 设置leader键
g.maplocalleader = " " -- 设置本地leader键
