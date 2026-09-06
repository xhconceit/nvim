local calls = {
  show_current = 0,
  jump_next = 0,
  jump_previous = 0,
  open_list = 0,
  open_workspace_list = 0,
}

local fake_diagnostics = {}

for method in pairs(calls) do
  fake_diagnostics[method] = function()
    calls[method] = calls[method] + 1
  end
end

local bufnr = vim.api.nvim_create_buf(
  false,
  true
)

require("nvi.features.diagnostics").attach(
  fake_diagnostics,
  bufnr
)

local expected_mappings = {
  ["显示当前位置诊断"] = "show_current",
  ["下一个诊断"] = "jump_next",
  ["上一个诊断"] = "jump_previous",
  ["打开诊断列表"] = "open_list",
  ["打开工作区诊断"] = "open_workspace_list",
}

for _, mapping in ipairs(
  vim.api.nvim_buf_get_keymap(bufnr, "n")
) do
  local method =
    expected_mappings[mapping.desc]

  if method then
    assert(
      type(mapping.callback) == "function",
      mapping.desc .. " 没有 Lua callback"
    )

    mapping.callback()

    assert(
      calls[method] == 1,
      mapping.desc .. " 没有调用正确的端口方法"
    )

    expected_mappings[mapping.desc] = nil
  end
end

assert(
  next(expected_mappings) == nil,
  "部分诊断快捷键没有注册"
)

vim.api.nvim_buf_delete(bufnr, {
  force = true,
})

print("diagnostics_test: OK")
