local M = {}

local function navigate(command, failure_message)
  local ok = pcall(vim.cmd, command)

  if not ok then
    vim.notify(failure_message, vim.log.levels.WARN)
  end
end

function M.open()
  vim.cmd("copen")
end

function M.close()
  vim.cmd("cclose")
end

function M.next_item()
  navigate("cnext", "没有下一个 Quickfix 项")
end

function M.previous_item()
  navigate("cprevious", "没有上一个 Quickfix 项")
end

return M
