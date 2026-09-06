local M = {}

local required_methods = {
  "next_hunk",
  "prev_hunk",
  "stage_hunk",
  "reset_hunk",
  "preview_hunk",
  "blame_line",
  "toggle_line_blame"
}

function M.validate(adapter)
  assert(
    type(adapter) == "table",
    "git adapter 必须是 table"
  )
  for _, method in ipairs(required_methods) do
    assert(
      type(adapter[method]) == "function",
      "git adapter 缺少方法：" .. method
    )
  end
  return adapter
end

return M
