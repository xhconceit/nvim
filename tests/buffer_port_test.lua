local Port = require("nvi.ports.buffer")

local required_methods = {
  "next_buffer",
  "prev_buffer",
  "close_buffer",
}

local adapter = {}

for _, method in ipairs(required_methods) do
  adapter[method] = function()
  end
end

assert(
  Port.validate(adapter) == adapter,
  "合法 buffer adapter 应该原样返回"
)

for _, missing_method in ipairs(required_methods) do
  local incomplete_adapter = {}

  for _, method in ipairs(required_methods) do
    if method ~= missing_method then
      incomplete_adapter[method] = function()
      end
    end
  end

  local ok, error_message = pcall(
    Port.validate,
    incomplete_adapter
  )

  assert(
    not ok,
    "缺少 " .. missing_method
      .. " 时应该拒绝适配器"
  )
  assert(
    tostring(error_message):find(
      missing_method,
      1,
      true
    ),
    "错误应该指出缺少 " .. missing_method
  )
end

print("buffer_port_test: OK")
