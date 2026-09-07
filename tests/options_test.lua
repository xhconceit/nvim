require("nvi.core.options").setup()

assert(
  vim.o.clipboard == "",
  "默认寄存器不应该与系统剪贴板同步"
)

assert(vim.o.termguicolors, "应该启用真彩色")
assert(vim.o.laststatus == 3, "应该使用全局状态栏")
assert(vim.o.showmode == false, "不应该重复显示当前模式")
assert(vim.o.cmdheight == 0, "命令行应该按需显示")
assert(vim.o.cursorlineopt == "number", "应该只高亮当前行号")
assert(vim.o.winborder == "rounded", "浮窗应该使用圆角边框")
assert(vim.o.pumblend == 10, "补全菜单应该使用轻微透明效果")
assert(vim.o.winblend == 10, "浮动窗口应该使用轻微透明效果")
assert(vim.o.listchars:match("extends:…"), "应该显示标签栏截断符")
assert(vim.o.fillchars:match("eob: "), "应该隐藏文件末尾波浪线")
assert(vim.o.fillchars:match("vert:│"), "窗口应该使用细分隔线")
assert(vim.o.foldmethod == "expr", "应该使用表达式计算代码折叠")
assert(
  vim.o.foldexpr == "v:lua.vim.treesitter.foldexpr()",
  "应该使用 Tree-sitter 计算代码折叠"
)
assert(vim.o.foldcolumn == "1", "应该显示折叠栏")
assert(vim.o.foldlevel == 99, "代码应该默认全部展开")
assert(
  vim.o.foldlevelstart == 99,
  "新窗口中的代码应该默认全部展开"
)

print("options_test: OK")
