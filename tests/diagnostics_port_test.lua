local DiagnosticsPort =
  require("nvi.ports.diagnostics")

local native_diagnostics =
  require("nvi.adapters.native_diagnostics")

assert(
  DiagnosticsPort.validate(
    native_diagnostics
  ) == native_diagnostics,
  "native_diagnostics 应该符合诊断端口"
)

local ok, error_message = pcall(function()
  DiagnosticsPort.validate({
    show_current = function() end,
    jump_next = function() end,
    jump_previous = function() end,
  })
end)

assert(
  not ok,
  "缺少 open_list 时应该验证失败"
)

assert(
  error_message:match("open_list"),
  "错误信息应该指出缺少 open_list"
)

print("diagnostics_port_test: OK")
