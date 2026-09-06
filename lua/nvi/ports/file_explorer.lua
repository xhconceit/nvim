local M = {}

local required_methods = {
  "open_current",
  "open_cwd",
  "close"
}

function M.validate(adapter)
  assert(
    type(adapter) == "table",
    "file explorer adapter 必须是 table"
  )

  for _, method in ipairs(required_methods) do
    assert(type(adapter[method]) == "function", "file explorer adapter 缺少方法：" .. method)
  end
  return adapter
end

return M
