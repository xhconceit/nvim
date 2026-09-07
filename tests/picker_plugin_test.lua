local original_mini_pick = package.loaded["mini.pick"]

local calls = {
  setup = 0,
  options = nil,
}

package.loaded["mini.pick"] = {
  setup = function(options)
    calls.setup = calls.setup + 1
    calls.options = options
  end,
}

local ok, error_message = xpcall(function()
  package.loaded["nvi.infrastructure.plugins.picker"] = nil

  local specs = require("nvi.infrastructure.plugins.picker")
  local picker = specs[1]

  assert(type(picker) == "table", "应该返回 mini.pick 插件声明")
  assert(
    picker[1] == "echasnovski/mini.pick",
    "声明了错误的 picker 插件"
  )
  assert(picker.version == false, "mini.pick 应该跟随最新版")
  assert(picker.lazy == true, "mini.pick 应该按需加载")
  assert(
    type(picker.config) == "function",
    "mini.pick 应该提供 config 函数"
  )

  picker.config()

  assert(calls.setup == 1, "config 应该调用一次 mini.pick.setup")
  assert(
    calls.options.window.config.border == "rounded",
    "mini.pick 应该使用圆角边框"
  )
  assert(
    calls.options.window.prompt_prefix == "   ",
    "mini.pick 应该显示搜索提示图标"
  )
end, debug.traceback)

package.loaded["mini.pick"] = original_mini_pick
package.loaded["nvi.infrastructure.plugins.picker"] = nil

assert(ok, error_message)

print("picker_plugin_test: OK")
