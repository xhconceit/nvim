local M = {}

local required_methods = {
  "split_vertical",
  "split_horizontal",
  "close",
  "only",
  "focus_left",
  "focus_down",
  "focus_up",
  "focus_right",
  "focus_previous",
  "equalize",
  "increase_height",
  "decrease_height",
  "increase_width",
  "decrease_width",
}


function M.validate(adapter)
  assert(
    type(adapter) == "table",
    "window adapter 必须是 table"
  )

  for _, method in ipairs(required_methods) do
    assert(
      type(adapter[method]) == "function",
      "window adapter 缺少方法：" .. method
    )
  end

  return adapter
end

return M
