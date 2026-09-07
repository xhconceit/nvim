local original_statusline = package.loaded["mini.statusline"]
local module_name = "nvi.infrastructure.plugins.statusline"

local calls = {
  setup = 0,
  options = nil,
}

package.loaded["mini.statusline"] = {
  setup = function(options)
    calls.setup = calls.setup + 1
    calls.options = options
  end,
}
package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local specs = require(module_name)
  local plugin = specs[1]

  assert(type(plugin) == "table", "应该返回状态栏插件声明")
  assert(
    plugin[1] == "nvim-mini/mini.statusline",
    "声明了错误的状态栏插件"
  )
  assert(plugin.version == false, "mini.statusline 应该跟随最新版")
  assert(plugin.event == "VeryLazy", "状态栏应该在首屏后加载")
  assert(
    type(plugin.config) == "function",
    "状态栏插件应该提供 config 函数"
  )

  plugin.config()

  assert(calls.setup == 1, "config 应该调用一次 statusline.setup")
  assert(calls.options.use_icons == true, "状态栏应该启用图标")
  assert(
    calls.options.set_vim_settings == true,
    "状态栏应该自动设置相关选项"
  )
end, debug.traceback)

package.loaded["mini.statusline"] = original_statusline
package.loaded[module_name] = nil

assert(ok, error_message)

print("statusline_plugin_test: OK")
