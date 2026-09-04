local M = {}

local required_methods = {
  "next_buffer",
  "prev_buffer",
  "close_buffer"
}

function M.validate(adapter)
  assert(type(adapter) == "table", "buffer adapter 必须是 table")

  for _, method in ipairs(required_methods) do
    assert(
      type(adapter[method]) == "function",
      "buffer adapter 缺少方法：" .. method
    )
  end
  return adapter
end

return M
