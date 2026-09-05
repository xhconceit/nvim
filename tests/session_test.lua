local calls = {
  save_current = 0,
  restore_current = 0,
  delete_current = 0,
}

local adapter = {}

for method in pairs(calls) do
  adapter[method] = function()
    calls[method] = calls[method] + 1
  end
end

require("nvi.features.session").setup(adapter)

local function find_mapping(lhs)
  for _, mapping in ipairs(
    vim.api.nvim_get_keymap("n")
  ) do
    if mapping.lhs == lhs then
      return mapping
    end
  end

  error("找不到快捷键：" .. lhs)
end

local expectations = {
  {
    lhs = " ss",
    method = "save_current",
    description = "保存当前项目会话",
  },
  {
    lhs = " sl",
    method = "restore_current",
    description = "恢复当前项目会话",
  },
  {
    lhs = " sd",
    method = "delete_current",
    description = "删除当前项目会话",
  },
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

print("session_test: OK")
