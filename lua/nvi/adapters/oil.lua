local M = {}

function M.open_current()
  require("oil").open()
end

function M.open_cwd()
  require("oil").open(vim.fn.getcwd())
end

function M.close()
  require("oil").close()
end

return M
