local RecentFile = require("nvi.ui.recent_file")

local original = {
  fnameescape = vim.fn.fnameescape,
  cmd = vim.cmd,
}

local escaped_path = nil
local opened_path = nil

vim.fn.fnameescape = function(path)
  escaped_path = path
  return "escaped:" .. path
end

vim.cmd = {
  edit = function(path)
    opened_path = path
  end,
}

local ok, error_message = xpcall(function()
  local items = RecentFile.list({
    "/projects/demo/init.lua",
    "",
    "/projects/demo/README.md",
    "/projects/demo/init.lua",
  })

  assert(
    #items == 2,
    "最近文件应该忽略空路径并去重"
  )

  assert(
    vim.deep_equal(items[1], {
      path = "/projects/demo/init.lua",
      text = "/projects/demo/init.lua",
    }),
    "最近文件应该保留原有顺序"
  )

  assert(
    items[2].path == "/projects/demo/README.md",
    "最近文件去重后不应丢失其他路径"
  )

  RecentFile.open(items[1].path)

  assert(
    escaped_path == "/projects/demo/init.lua",
    "打开前应该转义文件路径"
  )

  assert(
    opened_path == "escaped:/projects/demo/init.lua",
    "应该打开转义后的文件路径"
  )
end, debug.traceback)

vim.fn.fnameescape = original.fnameescape
vim.cmd = original.cmd

assert(ok, error_message)

print("recent_file_test: OK")
