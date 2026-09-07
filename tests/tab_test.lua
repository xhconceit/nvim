local calls = {
  new = 0,
  close = 0,
  next = 0,
  previous = 0,
  only = 0,
}

local adapter = {}
for method in pairs(calls) do
  adapter[method] = function()
    calls[method] = calls[method] + 1
  end
end

require("nvi.features.tab").setup(adapter)

local function find_mapping(lhs)
  for _, mapping in ipairs(vim.api.nvim_get_keymap("n")) do
    if mapping.lhs == lhs then
      return mapping
    end
  end
  error("找不到快捷键：" .. lhs)
end

local expectations = {
  { lhs = " tn", method = "new", description = "新建 Tab" },
  { lhs = " tc", method = "close", description = "关闭当前 Tab" },
  { lhs = " tl", method = "next", description = "切换到下一个 Tab" },
  { lhs = " th", method = "previous", description = "切换到上一个 Tab" },
  { lhs = " to", method = "only", description = "只保留当前 Tab" },
}

for _, expectation in ipairs(expectations) do
  local mapping = find_mapping(expectation.lhs)
  assert(
    type(mapping.callback) == "function",
    expectation.lhs .. " 应该使用 Lua callback"
  )
  assert(
    mapping.desc == expectation.description,
    expectation.lhs .. " 的说明不正确"
  )
  mapping.callback()
  assert(
    calls[expectation.method] == 1,
    expectation.method .. " 应该被调用一次"
  )
end

print("tab_test: OK")
