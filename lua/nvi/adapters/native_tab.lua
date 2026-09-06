local M = {}

function M.new()
  vim.cmd.tabnew()
end

function M.close() vim.cmd.tabclose() end

function M.next() vim.cmd.tabnext() end

function M.previous() vim.cmd.tabprevious() end

function M.only() vim.cmd.tabonly() end

return M
