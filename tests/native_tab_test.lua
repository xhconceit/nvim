local module_name = "nvi.adapters.native_tab"
local original_adapter = package.loaded[module_name]
local original_cmd = vim.cmd
local original_notify = vim.notify

local calls = {
  tabnew = 0,
  tabclose = 0,
  tabnext = 0,
  tabprevious = 0,
  tabonly = 0,
  notifications = {},
}
local fail_close = false

vim.cmd = {
  tabnew = function()
    calls.tabnew = calls.tabnew + 1
  end,
  tabclose = function()
    calls.tabclose = calls.tabclose + 1
    if fail_close then
      error("cannot close last tab")
    end
  end,
  tabnext = function()
    calls.tabnext = calls.tabnext + 1
  end,
  tabprevious = function()
    calls.tabprevious = calls.tabprevious + 1
  end,
  tabonly = function()
    calls.tabonly = calls.tabonly + 1
  end,
}

vim.notify = function(message, level)
  table.insert(calls.notifications, {
    message = message,
    level = level,
  })
end

package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local NativeTab = require(module_name)

  NativeTab.new()
  NativeTab.close()
  NativeTab.next()
  NativeTab.previous()
  NativeTab.only()

  for _, method in ipairs({
    "tabnew",
    "tabclose",
    "tabnext",
    "tabprevious",
    "tabonly",
  }) do
    assert(calls[method] == 1, method .. " 应该执行一次")
  end

  fail_close = true
  local close_ok = pcall(NativeTab.close)
  local notification = calls.notifications[#calls.notifications]

  assert(close_ok, "关闭最后一个 Tab 不应该抛出异常")
  assert(
    notification.message == "无法关闭最后一个 Tab",
    "关闭最后一个 Tab 时应该通知用户"
  )
  assert(
    notification.level == vim.log.levels.WARN,
    "关闭最后一个 Tab 应该使用 WARN 通知"
  )
end, debug.traceback)

vim.cmd = original_cmd
vim.notify = original_notify
package.loaded[module_name] = original_adapter

assert(ok, error_message)

print("native_tab_test: OK")
