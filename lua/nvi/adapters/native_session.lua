local Project = require("nvi.core.project")
local M = {}

local function session_path()
  local directory = vim.fn.stdpath("state") .. "/nvi/sessions"
  local project_id = vim.fn.sha256(Project.root())

  return directory, directory .. "/" .. project_id .. ".vim"
end

function M.save_current()
  local directory, path = session_path()
  vim.fn.mkdir(directory, "p")
  vim.cmd("mksession! " .. vim.fn.fnameescape(path))
  vim.notify("已保存当前项目会话")
end

function M.restore_current()
  local _, path = session_path()
  if vim.fn.filereadable(path) == 0 then
    vim.notify("当前项目没有已保存的会话")
    return
  end
  vim.cmd("source " .. vim.fn.fnameescape(path))
end

function M.delete_current()
  local _, path = session_path()

  if vim.fn.filereadable(path) == 0 then
    vim.notify("当前项目没有已保存的会话")
    return
  end

  vim.fn.delete(path)
  vim.notify("已删除当前项目会话")
end

return M
