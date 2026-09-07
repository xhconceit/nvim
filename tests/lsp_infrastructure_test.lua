local attached_context = nil

local lsp = require("nvi.infrastructure.lsp")

-- 记录基础设施传出的完整 LSP 上下文
lsp.setup({
  on_attach = function(context)
    attached_context = context
  end,
})

-- 创建临时 Buffer
local bufnr = vim.api.nvim_create_buf(false, true)

-- 模拟客户端 42 附加到临时 Buffer
vim.api.nvim_exec_autocmds("LspAttach", {
  buffer = bufnr,
  data = {
    client_id = 42,
  },
})

-- 验证 Buffer 是否正确传递
assert(
  attached_context ~= nil and attached_context.bufnr == bufnr,
  "LspAttach 没有传递正确的 Buffer"
)

-- 验证客户端 ID 是否正确传递
assert(
  attached_context.client_id == 42,
  "LspAttach 没有传递正确的客户端"
)

-- 清理临时 Buffer
vim.api.nvim_buf_delete(bufnr, {
  force = true,
})

print("lsp_infrastructure_test: OK")
