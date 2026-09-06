local original = {
  stdpath = vim.fn.stdpath,
  getcwd = vim.fn.getcwd,
  sha256 = vim.fn.sha256,
  mkdir = vim.fn.mkdir,
  filereadable = vim.fn.filereadable,
  delete = vim.fn.delete,
  fnameescape = vim.fn.fnameescape,
  cmd = vim.cmd,
  notify = vim.notify,
}

local module_name = "nvi.adapters.native_session"
local original_project = package.loaded["nvi.core.project"]
local calls = {
  mkdir = {},
  commands = {},
  deleted = {},
  notifications = {},
  project_root = 0,
}
local readable = 1

vim.fn.stdpath = function(kind)
  assert(kind == "state", "会话应该存放在 state 目录")
  return "/tmp/nvi-state"
end
vim.fn.getcwd = function()
  error("会话路径不应该直接依赖 getcwd")
end
vim.fn.sha256 = function(value)
  assert(value == "/projects/demo", "应该散列项目根目录")
  return "project-hash"
end
vim.fn.mkdir = function(path, flags)
  table.insert(calls.mkdir, { path = path, flags = flags })
end
vim.fn.filereadable = function(path)
  assert(
    path == "/tmp/nvi-state/nvi/sessions/project-hash.vim",
    "检查了错误的会话文件"
  )
  return readable
end
vim.fn.delete = function(path)
  table.insert(calls.deleted, path)
  return 0
end
vim.fn.fnameescape = function(path)
  return "escaped:" .. path
end
vim.cmd = function(command)
  table.insert(calls.commands, command)
end
vim.notify = function(message)
  table.insert(calls.notifications, message)
end

package.loaded["nvi.core.project"] = {
  root = function()
    calls.project_root = calls.project_root + 1
    return "/projects/demo"
  end,
}

package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local adapter = require(module_name)
  local session_file =
    "/tmp/nvi-state/nvi/sessions/project-hash.vim"

  adapter.save_current()

  assert(
    vim.deep_equal(calls.mkdir[1], {
      path = "/tmp/nvi-state/nvi/sessions",
      flags = "p",
    }),
    "保存前应该创建会话目录"
  )
  assert(
    calls.commands[1]
      == "mksession! escaped:" .. session_file,
    "应该保存当前项目会话"
  )

  adapter.restore_current()
  assert(
    calls.commands[2] == "source escaped:" .. session_file,
    "应该恢复当前项目会话"
  )

  adapter.delete_current()

  assert(
    calls.project_root == 3,
    "每次会话操作都应该基于项目根目录"
  )
  assert(
    calls.deleted[1] == session_file,
    "应该删除当前项目会话"
  )

  readable = 0
  adapter.restore_current()
  adapter.delete_current()

  assert(
    #calls.commands == 2,
    "会话不存在时不应该执行 source"
  )
  assert(
    #calls.deleted == 1,
    "会话不存在时不应该执行 delete"
  )
  assert(
    #calls.notifications >= 2,
    "会话不存在时应该通知用户"
  )
end, debug.traceback)

for name, value in pairs(original) do
  if name == "cmd" then
    vim.cmd = value
  elseif name == "notify" then
    vim.notify = value
  else
    vim.fn[name] = value
  end
end
package.loaded[module_name] = nil
package.loaded["nvi.core.project"] = original_project

assert(ok, error_message)

print("native_session_test: OK")
