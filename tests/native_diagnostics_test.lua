local original = {
  open_float = vim.diagnostic.open_float,
  jump = vim.diagnostic.jump,
  setloclist = vim.diagnostic.setloclist,
}

local calls = {
  open_float = nil,
  jumps = {},
  setloclist = nil,
}

vim.diagnostic.open_float = function(options)
  calls.open_float = options
end

vim.diagnostic.jump = function(options)
  table.insert(calls.jumps, options)
end

vim.diagnostic.setloclist = function(options)
  calls.setloclist = options
end

local NativeDiagnostics =
  require("nvi.adapters.native_diagnostics")

local ok, error_message = xpcall(function()
  NativeDiagnostics.show_current()
  NativeDiagnostics.jump_next()
  NativeDiagnostics.jump_previous()
  NativeDiagnostics.open_list()

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

  assert(
    #calls.jumps == 2,
    "应该执行两次诊断跳转"
  )

  assert(
    calls.jumps[1].count == 1,
    "jump_next 应该向后跳一个诊断"
  )

  assert(
    calls.jumps[1].wrap == true,
    "jump_next 应该允许循环跳转"
  )

  assert(
    calls.jumps[2].count == -1,
    "jump_previous 应该向前跳一个诊断"
  )

  assert(
    calls.jumps[2].wrap == true,
    "jump_previous 应该允许循环跳转"
  )

  assert(
    calls.setloclist.open == true,
    "诊断列表应该自动打开"
  )

  assert(
    calls.setloclist.title
      == "Buffer Diagnostics",
    "诊断列表标题错误"
  )
end, debug.traceback)

vim.diagnostic.open_float =
  original.open_float

vim.diagnostic.jump =
  original.jump

vim.diagnostic.setloclist =
  original.setloclist

assert(ok, error_message)

print("native_diagnostics_test: OK")
