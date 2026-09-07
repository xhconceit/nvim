local original = {
  open_float = vim.diagnostic.open_float,
  jump = vim.diagnostic.jump,
  setloclist = vim.diagnostic.setloclist,
  setqflist = vim.diagnostic.setqflist,
  is_enabled = vim.diagnostic.is_enabled,
  enable = vim.diagnostic.enable,
  config = vim.diagnostic.config,
}

local calls = {
  open_float = nil,
  jumps = {},
  setloclist = nil,
  setqflist = nil,
  enable = nil,
  config = nil,
}

local enabled = true
local enable_call
vim.diagnostic.is_enabled = function(options)
  assert(options.bufnr == 0)
  return enabled
end
vim.diagnostic.enable = function(value, options)
  enabled = value
  enable_call = { value = value, options = options }
end
vim.diagnostic.config = function(options)
  calls.config = options
end

vim.diagnostic.open_float = function(options)
  calls.open_float = options
end

vim.diagnostic.jump = function(options)
  table.insert(calls.jumps, options)
end

vim.diagnostic.setloclist = function(options)
  calls.setloclist = options
end

vim.diagnostic.setqflist = function(options)
  calls.setqflist = options
end

local NativeDiagnostics = require("nvi.adapters.native_diagnostics")

local ok, error_message = xpcall(function()
  NativeDiagnostics.setup()
  NativeDiagnostics.show_current()
  NativeDiagnostics.jump_next()
  NativeDiagnostics.jump_previous()
  NativeDiagnostics.open_list()
  NativeDiagnostics.open_workspace_list()
  NativeDiagnostics.toggle()

  assert(
    calls.config.severity_sort == true,
    "诊断应该按严重级别排序"
  )
  assert(
    calls.config.update_in_insert == false,
    "输入时不应该更新诊断"
  )
  assert(
    calls.config.signs.text[vim.diagnostic.severity.ERROR] == " ",
    "错误图标配置错误"
  )
  assert(
    calls.config.float.border == "rounded",
    "诊断浮窗应该使用圆角边框"
  )

  assert(
    calls.open_float.scope == "cursor",
    "诊断浮窗应该显示光标位置的诊断"
  )

  assert(
    calls.open_float.border == "rounded",
    "诊断浮窗应该使用圆角边框"
  )

  assert(
    calls.open_float.source == true,
    "诊断浮窗应该显示诊断来源"
  )

  assert(#calls.jumps == 2, "应该执行两次诊断跳转")

  assert(calls.jumps[1].count == 1, "jump_next 应该向后跳一个诊断")

  assert(calls.jumps[1].wrap == true, "jump_next 应该允许循环跳转")

  assert(
    calls.jumps[2].count == -1,
    "jump_previous 应该向前跳一个诊断"
  )

  assert(calls.jumps[2].wrap == true, "jump_previous 应该允许循环跳转")

  assert(calls.setloclist.open == true, "诊断列表应该自动打开")

  assert(
    calls.setloclist.title == "Buffer Diagnostics",
    "诊断列表标题错误"
  )

  assert(
    calls.setqflist.open == true,
    "工作区诊断应该自动打开 Quickfix"
  )

  assert(
    enable_call.value == false,
    "toggle 应该关闭当前 Buffer 的诊断"
  )
  assert(enable_call.options.bufnr == 0, "toggle 应该作用于当前 Buffer")

  assert(
    calls.setqflist.title == "Workspace Diagnostics",
    "工作区诊断列表标题错误"
  )
end, debug.traceback)

vim.diagnostic.open_float = original.open_float

vim.diagnostic.jump = original.jump

vim.diagnostic.setloclist = original.setloclist

vim.diagnostic.setqflist = original.setqflist
vim.diagnostic.is_enabled = original.is_enabled
vim.diagnostic.enable = original.enable
vim.diagnostic.config = original.config

assert(ok, error_message)

print("native_diagnostics_test: OK")
