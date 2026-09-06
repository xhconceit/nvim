local M = {}

function M.split_vertical()
  vim.cmd.vsplit()
end

function M.split_horizontal()
  vim.cmd.split()
end

function M.close()
  vim.cmd.close()
end

function M.only()
  vim.cmd.only()
end

function M.focus_left()
  vim.cmd.wincmd("h")
end

function M.focus_down()
  vim.cmd.wincmd("j")
end

function M.focus_up()
  vim.cmd.wincmd("k")
end

function M.focus_right()
  vim.cmd.wincmd("l")
end

function M.focus_previous()
  vim.cmd.wincmd("W")
end

function M.equalize()
  vim.cmd.wincmd("=")
end

function M.increase_height()
  vim.cmd.resize("+5")
end

function M.decrease_height()
  vim.cmd.resize("-5")
end

function M.increase_width()
  vim.cmd.vertical("resize +5")
end

function M.decrease_width()
  vim.cmd.vertical("resize -5")
end

return M
