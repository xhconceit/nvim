local SearchPort = require("nvi.ports.search")
local Keymap = require("nvi.ui.keymap")
local M = {}

function M.setup(adapter)
  local search = SearchPort.validate(adapter)

  Keymap.nmap(
    "<leader>ff",
    search.find_files,
    "搜索文件"
  )

  Keymap.nmap(
    "<leader>fg",
    search.search_text,
    "搜索文本"
  )

  Keymap.nmap(
    "<leader>fk",
    search.search_keymaps,
    "搜索快捷键"
  )

  Keymap.nmap(
    "<leader>fc",
    search.search_commands,
    "搜索命令"
  )

  Keymap.nmap(
    "<leader>fb",
    search.search_buffers,
    "搜索 Buffer"
  )

  Keymap.nmap(
    "<leader>fr",
    search.search_recent_files,
    "最近文件"
  )

  Keymap.nmap(
    "<leader>fh",
    search.search_help,
    "搜索帮助"
  )

  Keymap.nmap(
    "<leader>fw",
    search.search_word,
    "搜索当前单词"
  )

  Keymap.nmap(
    "<leader>fG",
    search.find_git_files,
    "搜索 Git 文件"
  )

end

return M
