local M = {}

-- 为指定 LSP 客户端和 Buffer 启用原生补全
function M.enable(context)
  vim.lsp.completion.enable(
    true,
    context.client_id,
    context.bufnr,
    {
      autotrigger = true
    }
  )
end

-- 手动请求一次补全
function M.trigger()
  vim.lsp.completion.get()
end

return M
