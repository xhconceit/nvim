require("nvi.core.options").setup()

assert(
  vim.o.clipboard == "",
  "默认寄存器不应该与系统剪贴板同步"
)

print("options_test: OK")
