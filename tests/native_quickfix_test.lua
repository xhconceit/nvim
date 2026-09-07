local original = {
  cmd = vim.cmd,
  notify = vim.notify,
}

local calls = {
  commands = {},
  notifications = {},
}

local failing_commands = {}

vim.cmd = function(command)
  table.insert(calls.commands, command)

  if failing_commands[command] then
    error("模拟 Quickfix 导航失败")
  end
end

vim.notify = function(message, level)
  table.insert(calls.notifications, {
    message = message,
    level = level,
  })
end

local ok, error_message = xpcall(function()
  local Quickfix = require("nvi.adapters.native_quickfix")

  Quickfix.open()
  Quickfix.close()
  Quickfix.next_item()
  Quickfix.previous_item()

  assert(
    vim.deep_equal(calls.commands, {
      "copen",
      "cclose",
      "cnext",
      "cprevious",
    }),
    "Quickfix adapter 执行了错误命令"
  )

  assert(#calls.notifications == 0, "导航成功时不应该发送通知")

  failing_commands.cnext = true
  failing_commands.cprevious = true

  Quickfix.next_item()
  Quickfix.previous_item()

  assert(
    vim.deep_equal(calls.notifications[1], {
      message = "没有下一个 Quickfix 项",
      level = vim.log.levels.WARN,
    }),
    "向后导航失败时通知错误"
  )

  assert(
    vim.deep_equal(calls.notifications[2], {
      message = "没有上一个 Quickfix 项",
      level = vim.log.levels.WARN,
    }),
    "向前导航失败时通知错误"
  )
end, debug.traceback)

vim.cmd = original.cmd
vim.notify = original.notify

assert(ok, error_message)

print("native_quickfix_test: OK")
