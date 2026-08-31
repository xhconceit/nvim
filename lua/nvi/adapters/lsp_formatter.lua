
local M = {}

function M.format_buffer(request)
  vim.lsp.buf.format({
    bufnr = request.bufnr,
    async = true
  })
end

return M
