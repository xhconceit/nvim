local plugin = require("nvi.infrastructure.plugins.tabline")[1]

assert(plugin[1] == "nvim-mini/mini.tabline", "标签栏插件声明错误")
assert(plugin.version == false, "mini.tabline 应该跟随最新版")
assert(plugin.event == "VeryLazy", "标签栏加载时机错误")
assert(plugin.opts.show_icons == true, "标签栏应该显示图标")
assert(
  plugin.opts.tabpage_section == "right",
  "Tab 区域应该显示在右侧"
)

print("tabline_plugin_test: OK")
