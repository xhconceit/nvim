local plugin = require("nvi.infrastructure.plugins.pairs")[1]

assert(plugin[1] == "nvim-mini/mini.pairs", "自动闭合插件声明错误")
assert(plugin.version == false, "mini.pairs 应该跟随最新版")
assert(
  plugin.event == "InsertEnter",
  "自动闭合应该在进入插入模式时加载"
)
assert(vim.deep_equal(plugin.opts, {}), "自动闭合应该使用默认配置")

print("pairs_plugin_test: OK")
