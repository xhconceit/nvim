

local M = {}

function M.open_horizontal()
  vim.cmd("botright 12split | terminal")
  vim.cmd("startinsert")
end

function M.open_vertical()
  vim.cmd("botright vsplit | terminal")
  vim.cmd("startinsert")
end

return M
