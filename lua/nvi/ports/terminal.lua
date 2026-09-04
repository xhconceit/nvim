
local M = {}

local required_methods = {
  "open_horizontal",
  "open_vertical"
}

function M.validate(adapter)
  assert(
    type(adapter) == "table",
    "terminal adapter 必须是 table"
  )

  for _, method in ipairs(required_methods) do
    assert(
      type(adapter[method]) == "function",
      "terminal adapter 缺少方法：" .. method
    )
  end

  return adapter
end

return M
