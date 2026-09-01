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

end

return M
