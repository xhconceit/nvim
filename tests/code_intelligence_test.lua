
local calls = {}

-- 创建一个不依赖真实 LSP 的测试适配器
local fake_adapter = {}

local methods = {
  "hover",
  "definition",
  "references",
  "rename",
  "code_action",
}

for _, method in ipairs(methods) do
  calls[method] = 0

  fake_adapter[method] = function()
    calls[method] = calls[method] + 1
  end
end

-- 创建临时 Buffer，避免污染其他测试
local bufnr = vim.api.nvim_create_buf(false, true)

require("nvi.features.code_intelligence")
  .attach(fake_adapter, bufnr)

local expected_mappings = {
  ["显示符号文档"] = "hover",
  ["跳转到定义"] = "definition",
  ["查找符号引用"] = "references",
  ["重命名符号"] = "rename",
  ["代码操作"] = "code_action",
}

-- 检查每个快捷键是否调用正确的端口方法
for _, mapping in ipairs(
  vim.api.nvim_buf_get_keymap(bufnr, "n")
) do
  local method = expected_mappings[mapping.desc]

  if method then
    assert(
      type(mapping.callback) == "function",
      mapping.desc .. " 没有 Lua callback"
    )

    mapping.callback()

    assert(
      calls[method] == 1,
      mapping.desc .. " 调用了错误的方法"
    )

    expected_mappings[mapping.desc] = nil
  end
end

-- 所有预期快捷键都应该被找到
assert(
  next(expected_mappings) == nil,
  "部分代码智能快捷键没有注册"
)

vim.api.nvim_buf_delete(bufnr, {
  force = true,
})

print("code_intelligence_test: OK")
