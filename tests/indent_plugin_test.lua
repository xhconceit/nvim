local plugin = require("nvi.infrastructure.plugins.indent")[1]

assert(
  plugin[1] == "lukas-reineke/indent-blankline.nvim",
  "缩进线插件声明错误"
)
assert(plugin.main == "ibl", "缩进线插件入口错误")
assert(plugin.opts.indent.char == "┊", "缩进线字符错误")
assert(plugin.opts.scope.enabled == true, "应该显示当前作用域")
assert(
  plugin.opts.scope.show_start == false,
  "不应该显示作用域起始横线"
)
assert(
  vim.tbl_contains(plugin.opts.exclude.buftypes, "terminal"),
  "终端不应该显示缩进线"
)

print("indent_plugin_test: OK")
