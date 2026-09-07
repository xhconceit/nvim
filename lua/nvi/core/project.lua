local M = {}

local markers = {
  ".git",
  "Makefile",
  "package.json",
  "go.mod",
  "Cargo.toml",
  "pyproject.toml",
}

function M.root()
  return vim.fs.root(vim.api.nvim_get_current_buf(), markers) or vim.fn.getcwd()
end

return M
