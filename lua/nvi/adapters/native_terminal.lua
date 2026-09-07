local Project = require("nvi.core.project")
local M = {}

local function open(split_command)
  local root = vim.fn.fnameescape(Project.root())

  vim.cmd(split_command .. " | lcd " .. root .. " | terminal")
  vim.cmd("startinsert")
end

function M.open_horizontal()
  open("botright 12split")
end

function M.open_vertical()
  open("botright vsplit")
end

return M
