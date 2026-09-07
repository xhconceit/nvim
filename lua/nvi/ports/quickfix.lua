local M = {}

local required_methods = {
  "open",
  "close",
  "next_item",
  "previous_item",
}

function M.validate(adapter)
  assert(type(adapter) == "table", "quickfix adapter 必须是 table")

  for _, method in ipairs(required_methods) do
    assert(
      type(adapter[method]) == "function",
      string.format("quickfix adapter 缺少方法：%s", method)
    )
  end

  return adapter
end

return M
