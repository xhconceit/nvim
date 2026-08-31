local M = {}

-- 补全适配器必须提供的能力
local required_methods = {
  "enable",
  "trigger"
}

-- 验证具体适配器是否符合补全契约
function M.validate(adapter)
  assert(
    type(adapter) == "table",
    "completion adapter 必须是 table"
  )

  for _, method in ipairs(required_methods) do
    assert(
      type(adapter[method]) == "function",
      string.format("completion adapter 缺少方法：%s", method)
    )
  end
  return adapter
end

return M
