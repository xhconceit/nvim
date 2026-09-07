local original_mini_files = package.loaded["mini.files"]
local module_name = "nvi.infrastructure.plugins.file_explorer"

local calls = {
  setup = 0,
  options = nil,
}

package.loaded["mini.files"] = {
  setup = function(options)
    calls.setup = calls.setup + 1
    calls.options = options
  end,
}
package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local specs = require(module_name)
  local plugin = specs[1]

  assert(type(plugin) == "table", "应该返回 mini.files 插件声明")
  assert(
    plugin[1] == "nvim-mini/mini.files",
    "声明了错误的文件浏览器插件"
  )
  assert(plugin.version == false, "mini.files 应该跟随最新版")
  assert(plugin.lazy == true, "mini.files 应该按需加载")
  assert(
    type(plugin.config) == "function",
    "mini.files 应该提供 config 函数"
  )

  plugin.config()

  assert(calls.setup == 1, "config 应该调用一次 mini.files.setup")
  assert(
    calls.options.options.use_as_default_explorer == false,
    "mini.files 不应该接管默认目录浏览器"
  )
end, debug.traceback)

package.loaded["mini.files"] = original_mini_files
package.loaded[module_name] = nil

assert(ok, error_message)

print("file_explorer_plugin_test: OK")
