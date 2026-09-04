local original_cmd = vim.cmd
local module_name = "nvi.adapters.native_buffer"

local commands = {}

vim.cmd = function(command)
  table.insert(commands, command)
end

package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local adapter = require(module_name)

  adapter.next_buffer()
  adapter.prev_buffer()
  adapter.close_buffer()

  local expected_commands = {
    "bnext",
    "bprevious",
    "bdelete",
  }

  assert(
    vim.deep_equal(commands, expected_commands),
    "native buffer adapter 调用了错误的命令"
  )
end, debug.traceback)

vim.cmd = original_cmd
package.loaded[module_name] = nil

assert(ok, error_message)

print("native_buffer_test: OK")
