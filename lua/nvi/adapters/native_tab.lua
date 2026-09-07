local M = {}

function M.new()
  vim.cmd.tabnew()
end

function M.close()
  local ok = pcall(vim.cmd.tabclose)

  if not ok then
    vim.notify("无法关闭最后一个 Tab", vim.log.levels.WARN)
  end
end

function M.next()
  vim.cmd.tabnext()
end

function M.previous()
  vim.cmd.tabprevious()
end

function M.only()
  vim.cmd.tabonly()
end

return M
