local CodeIntelligencePort = require("nvi.ports.code_intelligence")
local Keymap = require("nvi.ui.keymap")

local M = {}

-- 用数据描述快捷键，避免重复调用 keymap.set
local mappings = {
  {
    lhs = "gh",
    method = "hover",
    desc = "显示符号文档",
  },
  {
    lhs = "gd",
    method = "definition",
    desc = "跳转到定义",
  },
  {
    lhs = "grr",
    method = "references",
    desc = "查找符号引用",
  },
  {
    lhs = "<leader>cr",
    method = "rename",
    desc = "重命名符号",
  },
  {
    lhs = "<leader>ca",
    method = "code_action",
    desc = "代码操作",
  },
  {
    lhs = "gD",
    method = "declaration",
    desc = "跳转到声明",
  },
  {
    lhs = "gI",
    method = "implementation",
    desc = "跳转到实现",
  },
  {
    lhs = "gy",
    method = "type_definition",
    desc = "跳转到类型定义",
  },
  {
    lhs = "gO",
    method = "document_symbol",
    desc = "查看文档符号",
  },
  {
    lhs = "<leader>cS",
    method = "workspace_symbol",
    desc = "搜索工作区符号",
  },
  {
    lhs = "<leader>ch",
    method = "signature_help",
    desc = "显示函数签名",
  },
}

-- 将代码智能快捷键附加到指定 Buffer
function M.attach(adapter, bufnr)
  local code = CodeIntelligencePort.validate(adapter)

  assert(
    type(bufnr) == "number" and vim.api.nvim_buf_is_valid(bufnr),
    "code intelligence 需要有效的 Buffer"
  )

  for _, mapping in ipairs(mappings) do
    Keymap.buffer(bufnr, "n", mapping.lhs, code[mapping.method], mapping.desc)
  end
end

return M
