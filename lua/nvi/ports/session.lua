local M = {}

local required_methods = {
  "save_current",
  "restore_current",
  "delete_current",
}

function M.validate(adapter)
  assert(type(adapter) == "table", "session adapter 必须是 table")

  for _, method in ipairs(required_methods) do
    assert(
      type(adapter[method]) == "function",
      "session adapter 缺少方法：" .. method
    )
  end

  return adapter
end

return M
