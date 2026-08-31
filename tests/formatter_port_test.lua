local FormatterPort = require("nvi.ports.formatter")

local valid_adapter = {
  format_buffer = function() end,
}

assert(
  FormatterPort.validate(valid_adapter) == valid_adapter,
  "有效格式化适配器应该通过验证"
)

local ok, error_message = pcall(function()
  FormatterPort.validate({})
end)

assert(
  not ok,
  "缺少 format_buffer 时应该验证失败"
)

assert(
  error_message:match("format_buffer"),
  "错误信息应该指出缺少 format_buffer"
)

local type_ok, type_error = pcall(function()
  FormatterPort.validate(nil)
end)

assert(
  not type_ok,
  "非 table 适配器应该验证失败"
)

assert(
  type_error:match("table"),
  "错误信息应该指出适配器必须是 table"
)

print("formatter_port_test: OK")
