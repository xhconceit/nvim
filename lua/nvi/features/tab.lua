local TabPort = require("nvi.ports.tab")
local Keymap = require("nvi.ui.keymap")

local M = {}

function M.setup(adapter)
  local tab = TabPort.validate(adapter)

  Keymap.nmap("<leader>tn", tab.new, "新建 Tab")
  Keymap.nmap("<leader>tc", tab.close, "关闭当前 Tab")
  Keymap.nmap("<leader>tl", tab.next, "切换到下一个 Tab")
  Keymap.nmap("<leader>th", tab.previous, "切换到上一个 Tab")
  Keymap.nmap("<leader>to", tab.only, "只保留当前 Tab")
end

return M
