local calls = {
  new_buffer = 0,
  next_buffer = 0,
  prev_buffer = 0,
  alternate_buffer = 0,
  close_buffer = 0,
}

local adapter = {}

for method in pairs(calls) do
  adapter[method] = function()
    calls[method] = calls[method] + 1
  end
end

require("nvi.features.buffer").setup(adapter)

local function find_mapping(lhs)
  for _, mapping in ipairs(vim.api.nvim_get_keymap("n")) do
    if mapping.lhs == lhs then
      return mapping
    end
  end

  error("找不到快捷键：" .. lhs)
end

local expectations = {
  {
    lhs = " bn",
    method = "new_buffer",
    description = "新建空 Buffer",
  },
  {
    lhs = " bj",
    method = "next_buffer",
    description = "下一个 Buffer",
  },
  {
    lhs = " bk",
    method = "prev_buffer",
    description = "上一个 Buffer",
  },
  {
    lhs = " bq",
    method = "close_buffer",
    description = "关闭当前 Buffer",
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

print("buffer_test: OK")
