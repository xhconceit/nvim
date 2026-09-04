local original_cmd = vim.cmd
local module_name = "nvi.adapters.native_terminal"

local commands = {}

vim.cmd = function(command)
  table.insert(commands, command)
end

package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local adapter = require(module_name)

  adapter.open_horizontal()
  adapter.open_vertical()

  local expected_commands = {
    "botright 12split | terminal",
    "startinsert",
    "botright vsplit | terminal",
    "startinsert",
  }

  assert(
    vim.deep_equal(commands, expected_commands),
    "native terminal adapter 调用了错误的命令"
  )
end, debug.traceback)

vim.cmd = original_cmd
package.loaded[module_name] = nil

assert(ok, error_message)

print("native_terminal_test: OK")
