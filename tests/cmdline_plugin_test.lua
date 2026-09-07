local plugin = require("nvi.infrastructure.plugins.cmdline")[1]

assert(plugin[1] == "nvim-mini/mini.cmdline", "命令行插件声明错误")
assert(plugin.version == false, "mini.cmdline 应该跟随最新版")
assert(plugin.event == "VeryLazy", "命令行插件加载时机错误")
assert(plugin.opts.autocomplete.enable == true, "应该启用命令行补全")
assert(plugin.opts.autocomplete.delay == 80, "命令行补全延迟错误")
assert(plugin.opts.autocorrect.enable == true, "应该启用命令纠正")
assert(plugin.opts.autopeek.enable == true, "应该启用命令范围预览")
assert(plugin.opts.autopeek.n_context == 2, "命令范围上下文错误")
assert(
  plugin.opts.autopeek.window.config.border == "rounded",
  "命令预览应该使用圆角边框"
)

print("cmdline_plugin_test: OK")
