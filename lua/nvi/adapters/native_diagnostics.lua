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

return M
