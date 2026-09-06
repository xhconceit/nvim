
local M = {}

function M.format_buffer(request)
  vim.lsp.buf.format({
    bufnr = request.bufnr,
    async = true
  })
end

function M.format_range(request)
  vim.lsp.buf.format({
    bufnr = request.bufnr,
    async = true,
    range = request.range,
  })
end

return M
