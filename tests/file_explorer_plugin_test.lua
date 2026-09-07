local plugin = require("nvi.infrastructure.plugins.file_explorer")[1]

assert(plugin[1] == "stevearc/oil.nvim", "文件浏览器插件声明错误")
assert(plugin.lazy == true, "Oil 应该按需加载")
assert(
  vim.tbl_contains(plugin.dependencies, "nvim-mini/mini.icons"),
  "Oil 应该复用 mini.icons"
)
assert(plugin.opts.default_file_explorer == false)
assert(vim.deep_equal(plugin.opts.columns, { "icon" }))
assert(plugin.opts.skip_confirm_for_simple_edits == false)
assert(plugin.opts.view_options.show_hidden == true)
assert(plugin.opts.float.border == "rounded")

print("file_explorer_plugin_test: OK")
