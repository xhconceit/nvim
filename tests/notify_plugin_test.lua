local original_module = package.loaded["mini.notify"]
local original_notify = vim.notify
local module_name = "nvi.infrastructure.plugins.notify"
local setup_options
local duration_options
local replacement = function() end

package.loaded["mini.notify"] = {
  setup = function(options)
    setup_options = options
  end,
  make_notify = function(options)
    duration_options = options
    return replacement
  end,
}
package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local plugin = require(module_name)[1]
  assert(plugin[1] == "nvim-mini/mini.notify", "通知插件声明错误")
  plugin.config()

  assert(
    setup_options.window.config.border == "rounded",
    "通知应该使用圆角边框"
  )
  assert(setup_options.lsp_progress.enable == true, "应该显示 LSP 进度")
  assert(duration_options.ERROR.duration == 7000, "错误通知时长错误")
  assert(duration_options.INFO.duration == 3000, "普通通知时长错误")
  assert(vim.notify == replacement, "应该替换 vim.notify")
end, debug.traceback)

package.loaded["mini.notify"] = original_module
package.loaded[module_name] = nil
vim.notify = original_notify
assert(ok, error_message)
print("notify_plugin_test: OK")
