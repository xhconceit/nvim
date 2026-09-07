local specs = require(
  "nvi.infrastructure.plugins.completion"
)
local plugin = specs[1]

assert(
  type(plugin) == "table",
  "应该返回 blink.cmp 插件声明"
)
assert(
  plugin[1] == "saghen/blink.cmp",
  "声明了错误的补全插件"
)
assert(
  plugin.version == "1.*",
  "blink.cmp 应该固定在稳定的 v1"
)
assert(
  vim.tbl_contains(
    plugin.dependencies,
    "rafamadriz/friendly-snippets"
  ),
  "blink.cmp 应该加载包含 Dart 模板的 snippets"
)
assert(
  plugin.opts.keymap.preset == "default",
  "blink.cmp 应该使用原生风格按键"
)
assert(
  vim.deep_equal(plugin.opts.sources.default, {
    "lsp",
    "path",
    "snippets",
    "buffer",
  }),
  "blink.cmp 应该启用约定的补全来源"
)
assert(
  plugin.opts.completion.documentation.auto_show == true,
  "blink.cmp 应该自动显示候选文档"
)
assert(
  plugin.opts.completion.list.selection.preselect == false,
  "blink.cmp 不应该自动选中第一个候选"
)
assert(
  plugin.opts.completion.list.selection.auto_insert == false,
  "blink.cmp 不应该在确认前预览插入候选"
)
assert(
  vim.deep_equal(
    plugin.opts.completion.menu.draw.columns,
    {
      {
        "label",
        "label_description",
        gap = 1,
      },
      {
        "kind",
        "source_name",
        gap = 1,
      },
    }
  ),
  "补全菜单应该显示候选类型和来源"
)
assert(
  plugin.opts.signature.enabled == true,
  "blink.cmp 应该启用函数签名提示"
)
assert(
  plugin.opts.fuzzy.implementation == "lua",
  "blink.cmp 应该使用无需额外下载的 Lua matcher"
)
assert(
  vim.deep_equal(plugin.opts_extend, {
    "sources.default",
  }),
  "补全来源应该允许被扩展"
)

print("completion_plugin_test: OK")
