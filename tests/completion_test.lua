local attached_context = nil

local lsp =
  require("nvi.infrastructure.lsp")

-- 记录基础设施传出的完整上下文
lsp.setup({
  on_attach = function(context)
    attached_context = context
  end,
})

local bufnr = vim.api.nvim_create_buf(false, true)

-- 模拟客户端 42 附加到 Buffer
vim.api.nvim_exec_autocmds("LspAttach", {
  buffer = bufnr,
  data = {
    client_id = 42,
  },
})

assert(
  attached_context.bufnr == bufnr,
  "LspAttach 没有传递正确的 Buffer"
)

assert(
  attached_context.client_id == 42,
  "LspAttach 没有传递正确的客户端"
)

vim.api.nvim_buf_delete(bufnr, {
  force = true,
})

print("lsp_infrastructure_test: OK")
