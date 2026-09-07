local original_module = package.loaded["tokyonight"]
local original_cmd = vim.cmd
local module_name = "nvi.infrastructure.plugins.theme"
local setup_options
local colorscheme

package.loaded["tokyonight"] = {
  setup = function(options)
    setup_options = options
  end,
}
vim.cmd = {
  colorscheme = function(name)
    colorscheme = name
  end,
}
package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local plugin = require(module_name)[1]
  assert(plugin[1] == "folke/tokyonight.nvim", "主题插件声明错误")
  assert(plugin.lazy == false, "主题插件应该立即加载")
  assert(plugin.priority == 1000, "主题插件优先级错误")
  assert(plugin.opts.style == "night", "主题风格错误")

  plugin.config(nil, plugin.opts)

  assert(setup_options == plugin.opts, "应该传递主题配置")
  assert(colorscheme == "tokyonight", "应该启用 Tokyo Night")
end, debug.traceback)

package.loaded["tokyonight"] = original_module
package.loaded[module_name] = nil
vim.cmd = original_cmd
assert(ok, error_message)
print("theme_plugin_test: OK")
