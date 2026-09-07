local original_cmd = vim.cmd
local original_fnameescape = vim.fn.fnameescape
local original_termopen = vim.fn.termopen
local module_name = "nvi.adapters.native_terminal"
local original_project = package.loaded["nvi.core.project"]

local commands = {}
local project_root_calls = 0
local terminal_calls = {}

vim.cmd = function(command)
  table.insert(commands, command)
end

vim.fn.fnameescape = function(path)
  return "escaped:" .. path
end

vim.fn.termopen = function(command, options)
  table.insert(terminal_calls, {
    command = command,
    options = options,
  })
  return 1
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

  adapter.toggle_float()
  local float_buffer = vim.api.nvim_get_current_buf()
  local float_window = vim.api.nvim_get_current_win()

  local window_config = vim.api.nvim_win_get_config(float_window)
  assert(window_config.relative == "editor")
  assert(
    type(window_config.border) == "table" and #window_config.border > 0,
    "浮动终端应该显示边框"
  )
  assert(vim.bo[float_buffer].bufhidden == "hide")
  assert(#terminal_calls == 1, "首次打开应该创建一个终端进程")
  assert(terminal_calls[1].command == vim.o.shell, "应该使用默认 shell")
  assert(
    terminal_calls[1].options.cwd == "/projects/demo",
    "浮动终端应该使用项目根目录"
  )

  local terminal_mapping = vim.fn.maparg("<Esc>", "t", false, true)
  assert(
    terminal_mapping.buffer == 1,
    "退出输入模式的快捷键应该仅作用于终端"
  )
  assert(
    terminal_mapping.desc == "退出终端输入模式",
    "终端快捷键说明错误"
  )

  local hide_mapping = vim.fn.maparg("<Esc>", "n", false, true)
  assert(hide_mapping.buffer == 1, "隐藏快捷键应该仅作用于终端")
  assert(
    hide_mapping.desc == "隐藏浮动终端",
    "隐藏快捷键说明错误"
  )
  assert(type(hide_mapping.callback) == "function")

  hide_mapping.callback()
  assert(
    not vim.api.nvim_win_is_valid(float_window),
    "Esc Esc 应该隐藏浮窗"
  )

  adapter.toggle_float()
  assert(
    vim.api.nvim_get_current_buf() == float_buffer,
    "重新打开时应该复用终端 Buffer"
  )
  assert(#terminal_calls == 1, "重新打开时不应该创建新终端进程")

  adapter.toggle_float()
  vim.api.nvim_buf_delete(float_buffer, { force = true })

  local expected_commands = {
    "botright 12split | lcd escaped:/projects/demo | terminal",
    "startinsert",
    "botright vsplit | lcd escaped:/projects/demo | terminal",
    "startinsert",
    "startinsert",
    "startinsert",
  }

  assert(
    vim.deep_equal(commands, expected_commands),
    "native terminal adapter 调用了错误的命令"
  )

  assert(
    project_root_calls == 3,
    "创建每个终端时都应该解析项目根目录"
  )
end, debug.traceback)

vim.cmd = original_cmd
vim.fn.fnameescape = original_fnameescape
vim.fn.termopen = original_termopen
package.loaded[module_name] = nil
package.loaded["nvi.core.project"] = original_project

assert(ok, error_message)

print("native_terminal_test: OK")
