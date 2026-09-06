local M = {}

local required_methods = {
  "new",
  "close",
  "next",
  "previous",
  "only",
}

function M.validate(adapter)
  assert(type(adapter) == "table", "tab adapter 必须是 table")

  for _, method in ipairs(required_methods) do
    assert(
      type(adapter[method]) == "function",
      "tab adapter 缺少方法：" .. method
    )
  end

  return adapter
end

return M
