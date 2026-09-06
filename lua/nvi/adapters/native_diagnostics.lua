local M = {}

function M.show_current()
  vim.diagnostic.open_float({
    scope = 'cursor',
    border = 'rounded',
    source = true
  })
end

function M.jump_next()
  vim.diagnostic.jump(
    {
      count = 1,
      wrap = true
    }
  )
end

function M.jump_previous()
  vim.diagnostic.jump({
    count = -1,
    wrap = true,
  })
end

function M.open_list()
  vim.diagnostic.setloclist({
    open = true,
    title = "Buffer Diagnostics"
  })
end

function M.open_workspace_list()
  vim.diagnostic.setqflist({
    open = true,
    title = "Workspace Diagnostics"
  })
end

function M.toggle()
  local enabled = vim.diagnostic.is_enabled({ bufnr = 0 })
  vim.diagnostic.enable(not enabled, { bufnr = 0 })
end

return M
