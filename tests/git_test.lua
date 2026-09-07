local calls = {
  next_hunk = 0,
  prev_hunk = 0,
  stage_hunk = 0,
  reset_hunk = 0,
  preview_hunk = 0,
  blame_line = 0,
  toggle_line_blame = 0,
}

local adapter = {}

for method in pairs(calls) do
  adapter[method] = function()
    calls[method] = calls[method] + 1
  end
end

require("nvi.features.git").setup(adapter)

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
    lhs = "]h",
    method = "next_hunk",
    description = "跳到下一个 Git 变更块",
  },
  {
    lhs = "[h",
    method = "prev_hunk",
    description = "跳到上一个 Git 变更块",
  },
  {
    lhs = " hs",
    method = "stage_hunk",
    description = "暂存 Git 变更块",
  },
  {
    lhs = " hr",
    method = "reset_hunk",
    description = "撤销 Git 变更块",
  },
  {
    lhs = " hp",
    method = "preview_hunk",
    description = "预览 Git 变更块",
  },
  {
    lhs = " hb",
    method = "blame_line",
    description = "查看当前行提交信息",
  },
  {
    lhs = " ht",
    method = "toggle_line_blame",
    description = "切换行级 Git blame",
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

print("git_test: OK")
