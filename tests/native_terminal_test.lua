local original_cmd = vim.cmd
local original_fnameescape = vim.fn.fnameescape
local module_name = "nvi.adapters.native_terminal"
local original_project = package.loaded["nvi.core.project"]

local commands = {}
local project_root_calls = 0

vim.cmd = function(command)
  table.insert(commands, command)
end

vim.fn.fnameescape = function(path)
  return "escaped:" .. path
end

package.loaded["nvi.core.project"] = {
  root = function()
    project_root_calls = project_root_calls + 1
    return "/projects/demo"
  end,
}

package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local adapter = require(module_name)

  adapter.open_horizontal()
  adapter.open_vertical()

  local expected_commands = {
    "botright 12split | lcd escaped:/projects/demo | terminal",
    "startinsert",
    "botright vsplit | lcd escaped:/projects/demo | terminal",
    "startinsert",
  }

  assert(
    vim.deep_equal(commands, expected_commands),
    "native terminal adapter 调用了错误的命令"
  )

  assert(
    project_root_calls == 2,
    "每次打开终端都应该解析项目根目录"
  )
end, debug.traceback)

vim.cmd = original_cmd
vim.fn.fnameescape = original_fnameescape
package.loaded[module_name] = nil
package.loaded["nvi.core.project"] = original_project

assert(ok, error_message)

print("native_terminal_test: OK")
