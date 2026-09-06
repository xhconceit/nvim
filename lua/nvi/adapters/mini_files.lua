local M = {}

function M.open_current()
  local path = vim.api.nvim_buf_get_name(0)

  if path == "" then
    require("mini.files").open(nil, false)
    return
  end

  require("mini.files").open(path, false)
end

function M.open_cwd()
  require("mini.files").open(vim.fn.getcwd(), false)
end

function M.close()
  require("mini.files").close()
end

return M
