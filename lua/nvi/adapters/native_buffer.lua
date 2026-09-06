
local M = {}

function M.new_buffer()
  vim.cmd("enew")
end

function M.next_buffer()
  vim.cmd("bnext")
end

function M.prev_buffer()
  vim.cmd("bprevious")
end

function M.alternate_buffer()
  vim.cmd("buffer #")
end

function M.close_buffer()
  vim.cmd("bdelete")
end

return M
