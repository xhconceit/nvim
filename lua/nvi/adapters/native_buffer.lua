
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
  local ok = pcall(vim.cmd, "bdelete")

  if not ok then
    vim.notify(
      "当前 Buffer 有未保存修改",
      vim.log.levels.WARN
    )
  end
end

return M
