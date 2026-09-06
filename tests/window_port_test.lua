local WindowPort = require("nvi.ports.window")

local adapter = {
  split_vertical = function() end,
  split_horizontal = function() end,
  close = function() end,
  only = function() end,
  focus_left = function() end,
  focus_down = function() end,
  focus_up = function() end,
  focus_right = function() end,
  focus_previous = function() end,
  equalize = function() end,
  increase_height = function() end,
  decrease_height = function() end,
  increase_width = function() end,
  decrease_width = function() end,
  swap_next = function() end,
  swap_previous = function() end,
}

assert(
  WindowPort.validate(adapter) == adapter,
  "合法 window adapter 应该原样返回"
)

local ok, error_message = pcall(function()
  WindowPort.validate({})
end)

assert(
  not ok,
  "缺少 split_vertical 时应该拒绝适配器"
)

assert(
  tostring(error_message):find(
    "split_vertical",
    1,
    true
  ),
  "错误应该指出缺少 split_vertical"
)

local horizontal_ok, horizontal_error = pcall(function()
  WindowPort.validate({
    split_vertical = function() end,
  })
end)

assert(
  not horizontal_ok,
  "缺少 split_horizontal 时应该拒绝适配器"
)

assert(
  tostring(horizontal_error):find(
    "split_horizontal",
    1,
    true
  ),
  "错误应该指出缺少 split_horizontal"
)

local close_ok, close_error = pcall(function()
  WindowPort.validate({
    split_vertical = function() end,
    split_horizontal = function() end,
  })
end)

assert(
  not close_ok,
  "缺少 close 时应该拒绝适配器"
)

assert(
  tostring(close_error):find("close", 1, true),
  "错误应该指出缺少 close"
)

local only_ok, only_error = pcall(function()
  WindowPort.validate({
    split_vertical = function() end,
    split_horizontal = function() end,
    close = function() end,
  })
end)

assert(
  not only_ok,
  "缺少 only 时应该拒绝适配器"
)

assert(
  tostring(only_error):find("only", 1, true),
  "错误应该指出缺少 only"
)

local focus_methods = {
  "focus_left",
  "focus_down",
  "focus_up",
  "focus_right",
  "focus_previous",
}

for _, missing_method in ipairs(focus_methods) do
  local incomplete_adapter = {
    split_vertical = function() end,
    split_horizontal = function() end,
    close = function() end,
    only = function() end,
    focus_left = function() end,
    focus_down = function() end,
    focus_up = function() end,
    focus_right = function() end,
    focus_previous = function() end,
    equalize = function() end,
  }

  incomplete_adapter[missing_method] = nil

  local focus_ok, focus_error = pcall(
    WindowPort.validate,
    incomplete_adapter
  )

  assert(
    not focus_ok,
    "缺少 " .. missing_method .. " 时应该拒绝适配器"
  )

  assert(
    tostring(focus_error):find(missing_method, 1, true),
    "错误应该指出缺少 " .. missing_method
  )
end


local equalize_ok, equalize_error = pcall(function()
  WindowPort.validate({
    split_vertical = function() end,
    split_horizontal = function() end,
    close = function() end,
    only = function() end,
    focus_left = function() end,
    focus_down = function() end,
    focus_up = function() end,
    focus_right = function() end,
    focus_previous = function() end,
  })
end)

assert(
  not equalize_ok,
  "缺少 equalize 时应该拒绝适配器"
)

assert(
  tostring(equalize_error):find("equalize", 1, true),
  "错误应该指出缺少 equalize"
)

local resize_methods = {
  "increase_height",
  "decrease_height",
  "increase_width",
  "decrease_width",
}

for _, missing_method in ipairs(resize_methods) do
  local incomplete_adapter = {
    split_vertical = function() end,
    split_horizontal = function() end,
    close = function() end,
    only = function() end,
    focus_left = function() end,
    focus_down = function() end,
    focus_up = function() end,
    focus_right = function() end,
    focus_previous = function() end,
    equalize = function() end,
    increase_height = function() end,
    decrease_height = function() end,
    increase_width = function() end,
    decrease_width = function() end,
  }

  incomplete_adapter[missing_method] = nil

  local resize_ok, resize_error = pcall(
    WindowPort.validate,
    incomplete_adapter
  )

  assert(
    not resize_ok,
    "缺少 " .. missing_method .. " 时应该拒绝适配器"
  )

  assert(
    tostring(resize_error):find(missing_method, 1, true),
    "错误应该指出缺少 " .. missing_method
  )
end

print("window_port_test: OK")
