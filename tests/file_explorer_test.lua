local calls = {
  open_current = 0,
  open_cwd = 0,
  close = 0,
}

local adapter = {
  open_current = function()
    calls.open_current =
      calls.open_current + 1
  end,
  open_cwd = function()
    calls.open_cwd = calls.open_cwd + 1
  end,
  close = function()
    calls.close = calls.close + 1
  end,
}

require("nvi.features.file_explorer")
  .setup(adapter)

local function find_mapping(description)
  for _, mapping in ipairs(
    vim.api.nvim_get_keymap("n")
  ) do
    if mapping.desc == description then
      return mapping
    end
  end

  error("找不到快捷键：" .. description)
end

local current_mapping = find_mapping(
  "打开当前文件所在位置"
)
local cwd_mapping = find_mapping(
  "打开当前工作目录"
)
local close_mapping = find_mapping("关闭文件浏览器")

assert(
  type(current_mapping.callback) == "function",
  "打开当前文件位置没有 Lua callback"
)
assert(
  type(cwd_mapping.callback) == "function",
  "打开工作目录没有 Lua callback"
)
assert(type(close_mapping.callback) == "function", "关闭文件浏览器没有 Lua callback")

current_mapping.callback()
cwd_mapping.callback()
close_mapping.callback()

assert(
  calls.open_current == 1,
  "open_current 应该被调用一次"
)
assert(
  calls.open_cwd == 1,
  "open_cwd 应该被调用一次"
)
assert(calls.close == 1, "close 应该被调用一次")

print("file_explorer_test: OK")
