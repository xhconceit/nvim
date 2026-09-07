local original = package.loaded["mini.animate"]
local module_name = "nvi.infrastructure.plugins.animate"
local captured
local timing_options
local subscroll_options

package.loaded["mini.animate"] = {
  setup = function(options)
    captured = options
  end,
  gen_timing = {
    linear = function(options)
      timing_options = options
      return "timing"
    end,
  },
  gen_subscroll = {
    equal = function(options)
      subscroll_options = options
      return "subscroll"
    end,
  },
}
package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local plugin = require(module_name)[1]
  assert(plugin[1] == "nvim-mini/mini.animate", "动画插件声明错误")
  assert(plugin.version == false, "mini.animate 应该跟随最新版")
  assert(plugin.event == "VeryLazy", "动画插件加载时机错误")

  plugin.config()

  assert(captured.scroll.enable == true, "应该启用滚动动画")
  assert(captured.cursor.enable == false, "不应该启用光标动画")
  assert(captured.resize.enable == false, "不应该启用窗口尺寸动画")
  assert(timing_options.duration == 120, "滚动动画时长错误")
  assert(timing_options.unit == "total", "滚动动画应该使用总时长")
  assert(subscroll_options.max_output_steps == 20, "滚动动画步数错误")
end, debug.traceback)

package.loaded["mini.animate"] = original
package.loaded[module_name] = nil
assert(ok, error_message)
print("animate_plugin_test: OK")
