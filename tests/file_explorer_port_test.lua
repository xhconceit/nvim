
local Port =
  require("nvi.ports.file_explorer")

local adapter = {
  open_current = function()
  end,
  open_cwd = function()
  end,
  close = function()
  end,
}

assert(
  Port.validate(adapter) == adapter,
  "合法适配器应该原样返回"
)

local missing_current_ok,
  missing_current_error = pcall(
    Port.validate,
    {
      open_cwd = function()
      end,
    }
  )

assert(
  not missing_current_ok,
  "缺少 open_current 时应该拒绝适配器"
)
assert(
  tostring(missing_current_error):find(
    "open_current",
    1,
    true
  ),
  "错误应该指出缺少 open_current"
)

local missing_cwd_ok,
  missing_cwd_error = pcall(
    Port.validate,
    {
      open_current = function()
      end,
    }
  )

assert(
  not missing_cwd_ok,
  "缺少 open_cwd 时应该拒绝适配器"
)
assert(
  tostring(missing_cwd_error):find(
    "open_cwd",
    1,
    true
  ),
  "错误应该指出缺少 open_cwd"
)

print("file_explorer_port_test: OK")
