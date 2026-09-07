local M = {}

local required_methods = {
  "show_current",
  "jump_next",
  "jump_previous",
  "open_list",
  "open_workspace_list",
  "toggle",
}

function M.validate(adapter)
  assert(type(adapter) == "table", "diagnostics adapter 必须是 table")

  for _, method in ipairs(required_methods) do
    assert(
      type(adapter[method]) == "function",
      string.format("diagnostics adapter 缺少方法：%s", method)
    )
  end

  return adapter
end

return M
