require("nvi.core.options").setup()

assert(
  vim.o.clipboard == "",
  "默认寄存器不应该与系统剪贴板同步"
)

assert(vim.o.termguicolors, "应该启用真彩色")
assert(vim.o.cursorlineopt == "number", "应该只高亮当前行号")
assert(vim.o.winborder == "rounded", "浮窗应该使用圆角边框")
assert(vim.o.listchars:match("extends:…"), "应该显示标签栏截断符")
assert(vim.o.fillchars:match("eob: "), "应该隐藏文件末尾波浪线")

print("options_test: OK")
