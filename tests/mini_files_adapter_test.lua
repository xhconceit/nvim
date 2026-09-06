local original = {
  get_name = vim.api.nvim_buf_get_name,
  getcwd = vim.fn.getcwd,
  mini_files = package.loaded["mini.files"],
}

local current_path =
  "/tmp/project/init.lua"
local cwd = "/tmp/project"
local calls = {}

vim.api.nvim_buf_get_name = function()
  return current_path
end

vim.fn.getcwd = function()
  return cwd
end

package.loaded["mini.files"] = {
  open = function(path, use_latest)
    table.insert(calls, {
      path = path,
      use_latest = use_latest,
    })
  end,
  close = function()
    table.insert(calls, { method = "close" })
  end,
}

local MiniFilesAdapter =
  require("nvi.adapters.mini_files")

local ok, error_message = xpcall(function()
  MiniFilesAdapter.open_current()

  current_path = ""
  MiniFilesAdapter.open_current()

  MiniFilesAdapter.open_cwd()
  MiniFilesAdapter.close()

  assert(
    #calls == 4,
    "mini.files 应该被调用四次"
  )
  assert(
    calls[1].path
      == "/tmp/project/init.lua",
    "应该使用当前文件路径"
  )
  assert(
    calls[1].use_latest == false,
    "打开当前文件时不应该复用历史"
  )
  assert(
    calls[2].path == nil,
    "未命名 Buffer 应该传入 nil"
  )
  assert(
    calls[2].use_latest == false,
    "未命名 Buffer 不应该复用历史"
  )
  assert(
    calls[3].path == cwd,
    "应该使用当前工作目录"
  )
  assert(
    calls[3].use_latest == false,
    "打开工作目录时不应该复用历史"
  )
  assert(calls[4].method == "close", "应该调用 mini.files.close")
end, debug.traceback)

vim.api.nvim_buf_get_name = original.get_name
vim.fn.getcwd = original.getcwd
package.loaded["mini.files"] =
  original.mini_files

assert(ok, error_message)

print("mini_files_adapter_test: OK")
