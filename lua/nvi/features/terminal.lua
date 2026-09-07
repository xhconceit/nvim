local TerminalPort = require("nvi.ports.terminal")
local Keymap = require("nvi.ui.keymap")

local M = {}

function M.setup(adapter)
  local terminal = TerminalPort.validate(adapter)

  Keymap.nmap("<leader>ts", terminal.open_horizontal, "打开水平终端")

  Keymap.nmap("<leader>tv", terminal.open_vertical, "打开垂直终端")

  Keymap.nmap("<leader>tf", terminal.toggle_float, "切换浮动终端")
end

return M
