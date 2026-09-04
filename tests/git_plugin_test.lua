local original_gitsigns = package.loaded["gitsigns"]
local module_name = "nvi.infrastructure.plugins.git"

local calls = {
  setup = 0,
  options = nil,
}

package.loaded["gitsigns"] = {
  setup = function(options)
    calls.setup = calls.setup + 1
    calls.options = options
  end,
}
package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local specs = require(module_name)
  local plugin = specs[1]

  assert(
    type(plugin) == "table",
    "应该返回 Git 插件声明"
  )
  assert(
    plugin[1] == "lewis6991/gitsigns.nvim",
    "声明了错误的 Git 插件"
  )
  assert(
    plugin.event == "BufReadPre",
    "gitsigns 应该在读取文件前加载"
  )
  assert(
    type(plugin.config) == "function",
    "Git 插件应该提供 config 函数"
  )

  plugin.config()

  assert(
    calls.setup == 1,
    "config 应该调用一次 gitsigns.setup"
  )
  assert(
    calls.options.signcolumn == true,
    "应该启用 Git 符号列"
  )
  assert(
    calls.options.numhl == false,
    "不应该高亮 Git 变更行号"
  )
  assert(
    calls.options.current_line_blame == false,
    "不应该默认显示当前行 blame"
  )
end, debug.traceback)

package.loaded["gitsigns"] = original_gitsigns
package.loaded[module_name] = nil

assert(ok, error_message)

print("git_plugin_test: OK")
