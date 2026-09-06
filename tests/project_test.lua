local original = {
  root = vim.fs.root,
  get_current_buf = vim.api.nvim_get_current_buf,
  getcwd = vim.fn.getcwd,
}

local discovered_root = "/projects/demo"

vim.api.nvim_get_current_buf = function()
  return 42
end

vim.fs.root = function(source, markers)
  assert(source == 42, "应该从当前 Buffer 查找项目根目录")
  assert(
    vim.deep_equal(markers, {
      ".git",
      "Makefile",
      "package.json",
      "go.mod",
      "Cargo.toml",
      "pyproject.toml",
    }),
    "项目根目录标记配置错误"
  )

  return discovered_root
end

vim.fn.getcwd = function()
  return "/fallback"
end

local ok, error_message = xpcall(function()
  local Project = require("nvi.core.project")

  assert(
    Project.root() == "/projects/demo",
    "应该返回找到的项目根目录"
  )

  discovered_root = nil

  assert(
    Project.root() == "/fallback",
    "找不到项目标记时应该回退到工作目录"
  )
end, debug.traceback)

vim.fs.root = original.root
vim.api.nvim_get_current_buf = original.get_current_buf
vim.fn.getcwd = original.getcwd

assert(ok, error_message)

print("project_test: OK")
