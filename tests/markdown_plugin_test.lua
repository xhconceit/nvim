local plugin = require("nvi.infrastructure.plugins.markdown")[1]

assert(
  plugin[1] == "MeanderingProgrammer/render-markdown.nvim",
  "Markdown 插件声明错误"
)
assert(
  vim.deep_equal(plugin.ft, { "markdown" }),
  "Markdown 插件文件类型错误"
)
assert(
  vim.tbl_contains(plugin.dependencies, "nvim-treesitter/nvim-treesitter"),
  "Markdown 插件缺少 Treesitter"
)
assert(
  vim.tbl_contains(plugin.dependencies, "nvim-mini/mini.icons"),
  "Markdown 插件缺少图标依赖"
)
assert(
  vim.deep_equal(plugin.opts.render_modes, { "n", "c" }),
  "Markdown 渲染模式错误"
)
assert(plugin.opts.code.width == "block", "Markdown 代码块宽度错误")
assert(
  plugin.opts.completions.lsp.enabled == true,
  "应该启用 Markdown 补全"
)

print("markdown_plugin_test: OK")
