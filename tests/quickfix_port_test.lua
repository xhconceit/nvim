local QuickfixPort = require("nvi.ports.quickfix")

local method_names = {
  "open",
  "close",
  "next_item",
  "previous_item",
}

local valid_adapter = {}

for _, name in ipairs(method_names) do
  valid_adapter[name] = function() end
end

assert(
  QuickfixPort.validate(valid_adapter) == valid_adapter,
  "有效 Quickfix adapter 应该通过验证"
)

for _, missing_name in ipairs(method_names) do
  local incomplete_adapter = {}

  for _, name in ipairs(method_names) do
    if name ~= missing_name then
      incomplete_adapter[name] = function() end
    end
  end

  local ok, error_message = pcall(
    QuickfixPort.validate,
    incomplete_adapter
  )

  assert(
    not ok,
    "缺少 " .. missing_name .. " 时应该验证失败"
  )

  assert(
    error_message:match(missing_name),
    "错误信息应该指出缺少 " .. missing_name
  )
end

print("quickfix_port_test: OK")
