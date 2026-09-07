local original_cmd = vim.cmd
local original_notify = vim.notify
local module_name = "nvi.adapters.native_buffer"

local commands = {}
local notifications = {}
local fail_close = false

vim.cmd = function(command)
  table.insert(commands, command)

  if command == "bdelete" and fail_close then
    error("no write since last change")
  end
end

vim.notify = function(message, level)
  table.insert(notifications, {
    message = message,
    level = level,
  })
end

package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local adapter = require(module_name)

  adapter.new_buffer()
  adapter.next_buffer()
  adapter.prev_buffer()
  adapter.alternate_buffer()
  adapter.close_buffer()

  local expected_commands = {
    "enew",
    "bnext",
    "bprevious",
    "buffer #",
    "bdelete",
  }

  assert(
    vim.deep_equal(commands, expected_commands),
    "native buffer adapter 调用了错误的命令"
  )

  fail_close = true
  local close_ok = pcall(adapter.close_buffer)
  local notification = notifications[#notifications]

  assert(close_ok, "关闭未保存 Buffer 不应该抛出异常")
  assert(
    notification.message == "当前 Buffer 有未保存修改",
    "关闭未保存 Buffer 时应该通知用户"
  )
  assert(
    notification.level == vim.log.levels.WARN,
    "关闭未保存 Buffer 应该使用 WARN 通知"
  )
end, debug.traceback)

vim.cmd = original_cmd
vim.notify = original_notify
package.loaded[module_name] = nil

assert(ok, error_message)

print("native_buffer_test: OK")
