local original = package.loaded["mini.icons"]
local module_name = "nvi.infrastructure.plugins.icons"
local setup_options
local mock_calls = 0

package.loaded["mini.icons"] = {
  setup = function(options)
    setup_options = options
  end,
  mock_nvim_web_devicons = function()
    mock_calls = mock_calls + 1
  end,
}
package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local plugin = require(module_name)[1]
  assert(plugin[1] == "nvim-mini/mini.icons", "图标插件声明错误")
  assert(plugin.lazy == false, "图标插件应该立即加载")
  assert(plugin.opts.style == "glyph", "应该使用 Nerd Font 图标")

  plugin.config(nil, plugin.opts)

  assert(setup_options == plugin.opts, "应该传递图标配置")
  assert(mock_calls == 1, "应该兼容 nvim-web-devicons 接口")
end, debug.traceback)

package.loaded["mini.icons"] = original
package.loaded[module_name] = nil
assert(ok, error_message)
print("icons_plugin_test: OK")
