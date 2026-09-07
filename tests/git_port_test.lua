local Port = require("nvi.ports.git")

local adapter = {
  next_hunk = function() end,
  prev_hunk = function() end,
  stage_hunk = function() end,
  reset_hunk = function() end,
  preview_hunk = function() end,
  blame_line = function() end,
  toggle_line_blame = function() end,
}

assert(Port.validate(adapter) == adapter, "合法适配器应该原样返回")

local required_methods = {
  "next_hunk",
  "prev_hunk",
  "stage_hunk",
  "reset_hunk",
  "preview_hunk",
  "blame_line",
  "toggle_line_blame",
}

for _, missing_method in ipairs(required_methods) do
  local incomplete_adapter = {}

  for _, method in ipairs(required_methods) do
    if method ~= missing_method then
      incomplete_adapter[method] = function() end
    end
  end

  local ok, error_message = pcall(Port.validate, incomplete_adapter)

  assert(not ok, "缺少 " .. missing_method .. " 时应该拒绝适配器")

  assert(
    tostring(error_message):find(missing_method, 1, true),
    "错误应该指出缺少 " .. missing_method
  )
end

print("git_port_test: OK")
