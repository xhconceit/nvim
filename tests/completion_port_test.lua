local CompletionPort =
  require("nvi.ports.completion")

local native_completion =
  require("nvi.adapters.native_completion")

-- 原生补全适配器应该符合端口
assert(
  CompletionPort.validate(native_completion)
    == native_completion,
  "native_completion 应该符合补全端口"
)

-- 构造一个缺少 trigger 的适配器
local ok, error_message = pcall(function()
  CompletionPort.validate({
    enable = function() end,
  })
end)

assert(
  not ok,
  "缺少 trigger 时应该验证失败"
)

assert(
  error_message:match("trigger"),
  "错误信息应该指出缺少 trigger"
)

print("completion_port_test: OK")
