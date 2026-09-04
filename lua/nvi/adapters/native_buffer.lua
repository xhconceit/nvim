
local M = {}

function M.next_buffer()
  vim.cmd("bnext")
end

function M.prev_buffer()
  vim.cmd("bprevious")
end

function M.close_buffer()
  vim.cmd("bdelete")
end

return M
