local M = {}

local required_methods = {
  "format_buffer",
  "format_range",
}

function M.validate(adapter)
  assert(
    type(adapter) == "table", "formatter adapter 必须是 table"
  )

  for _, method in ipairs(required_methods) do 
    assert(
      type(adapter[method]) == "function",
      string.format("formatter adapter 缺少方法：%s", method)
    )
  end

  return adapter
end

return M
