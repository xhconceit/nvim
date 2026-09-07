local Project = require("nvi.core.project")
local M = {}

local function session_path()
  local directory = vim.fn.stdpath("state") .. "/nvi/sessions"
  local project_id = vim.fn.sha256(Project.root())

  return directory, directory .. "/" .. project_id .. ".vim"
end

local function execute(command, failure_message)
  local ok = pcall(vim.cmd, command)

  if not ok then
    vim.notify(
      failure_message,
      vim.log.levels.ERROR
    )
    return false
  end

  return true
end

function M.save_current()
  local directory, path = session_path()
  local created = vim.fn.mkdir(
    directory,
    "p",
    tonumber("700", 8)
  )

  if created == 0 then
    vim.notify(
      "无法创建会话目录",
      vim.log.levels.ERROR
    )
    return
  end

  local saved = execute(
    "mksession! " .. vim.fn.fnameescape(path),
    "无法保存当前项目会话"
  )

  if not saved then
    return
  end

  vim.notify("已保存当前项目会话")
end

function M.restore_current()
  local _, path = session_path()
  if vim.fn.filereadable(path) == 0 then
    vim.notify("当前项目没有已保存的会话")
    return
  end
  local restored = execute(
    "source " .. vim.fn.fnameescape(path),
    "无法恢复当前项目会话"
  )

  if not restored then
    return
  end

  vim.notify("已恢复当前项目会话")
end

function M.delete_current()
  local _, path = session_path()

  if vim.fn.filereadable(path) == 0 then
    vim.notify("当前项目没有已保存的会话")
    return
  end

  local result = vim.fn.delete(path)

  if result ~= 0 then
    vim.notify(
      "无法删除当前项目会话",
      vim.log.levels.ERROR
    )
    return
  end

  vim.notify("已删除当前项目会话")
end

return M
