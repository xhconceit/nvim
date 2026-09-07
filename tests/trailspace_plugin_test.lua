local original = package.loaded["mini.trailspace"]
local module_name = "nvi.infrastructure.plugins.trailspace"
local trim_calls = 0
local trim_last_lines_calls = 0

package.loaded["mini.trailspace"] = {
  trim = function()
    trim_calls = trim_calls + 1
  end,
  trim_last_lines = function()
    trim_last_lines_calls = trim_last_lines_calls + 1
  end,
}
package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local plugin = require(module_name)[1]
  assert(
    plugin[1] == "nvim-mini/mini.trailspace",
    "行尾空格插件声明错误"
  )
  assert(
    vim.deep_equal(plugin.event, { "BufReadPost", "BufNewFile" }),
    "行尾空格提示应该在打开文件后加载"
  )
  assert(
    plugin.opts.only_in_normal_buffers == true,
    "只应该处理普通 Buffer"
  )
  assert(plugin.keys[1][1] == "<leader>cw", "清理空格快捷键错误")

  plugin.keys[1][2]()

  assert(trim_calls == 1, "应该清理一次行尾空格")
  assert(trim_last_lines_calls == 1, "应该清理一次末尾空行")
end, debug.traceback)

package.loaded["mini.trailspace"] = original
package.loaded[module_name] = nil
assert(ok, error_message)
print("trailspace_plugin_test: OK")
