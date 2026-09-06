local RecentFile = require("nvi.ui.recent_file")
local Project = require("nvi.core.project")
local Command = require("nvi.ui.command")
local Keymap = require("nvi.ui.keymap")

local M = {}

local function project_options()
  return {
    source = {
      cwd = Project.root()
    }
  }
end

function M.find_files()
  require("mini.pick").builtin.files(
    nil,
    project_options()
  )
end

function M.search_text()
  require("mini.pick").builtin.grep_live(
    nil,
    project_options()
  )
end

function M.search_keymaps()
  require("mini.pick").start({
    source = {
      name = "快捷键",
      items = Keymap.list("n"),
      choose = function(item)
        Keymap.execute(item.lhs)
      end,
    },
  })
end

function M.search_commands()
  require("mini.pick").start({
    source = {
      name = "命令",
      items = Command.list(),
      choose = function(item)
        Command.execute(item.name)
      end,
    },
  })
end

function M.search_buffers()
  require("mini.pick").builtin.buffers()
end

function M.search_recent_files()
  require("mini.pick").start({
    source = {
      name = "最近文件",
      items = RecentFile.list(),
      choose = function(item)
        RecentFile.open(item.path)
      end
    }
  })
end

function M.search_help()
  require("mini.pick").builtin.help()
end

function M.search_word()
  local word = vim.fn.expand("<cword>")

  if word == "" then
    return
  end

  require("mini.pick").builtin.grep(
    { pattern = word },
    project_options()
  )
end

function M.find_git_files()
  require("mini.pick").builtin.files(
    { tool = "git" },
    project_options()
  )
end

return M
