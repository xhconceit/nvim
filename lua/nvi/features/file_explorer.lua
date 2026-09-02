
local FileExplorerPort = require("nvi.ports.file_explorer")
local Keymap = require("nvi.ui.keymap")

local M  = {}

function M.setup(adapter)
  local explorer = FileExplorerPort.validate(adapter)

  Keymap.nmap("<leader>ef", explorer.open_current, "打开当前文件所在位置")
  Keymap.nmap("<leader>ew", explorer.open_cwd, "打开当前工作目录")
end

return M
