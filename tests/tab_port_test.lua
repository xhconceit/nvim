local TabPort = require("nvi.ports.tab")

local methods = { "new", "close", "next", "previous", "only" }
local adapter = {}
for _, method in ipairs(methods) do
  adapter[method] = function() end
end

assert(
  TabPort.validate(adapter) == adapter,
  "合法 tab adapter 应该原样返回"
)

for _, missing_method in ipairs(methods) do
  local incomplete = {}
  for _, method in ipairs(methods) do
    incomplete[method] = function() end
  end
  incomplete[missing_method] = nil

  local ok, err = pcall(function()
    TabPort.validate(incomplete)
  end)

  assert(not ok, "缺少 " .. missing_method .. " 时应该拒绝适配器")
  assert(
    tostring(err):find(missing_method, 1, true),
    "错误应该指出缺少 " .. missing_method
  )
end

local type_ok, type_err = pcall(function()
  TabPort.validate(nil)
end)

assert(not type_ok, "非 table 适配器应该被拒绝")
assert(tostring(type_err):find("table", 1, true))
