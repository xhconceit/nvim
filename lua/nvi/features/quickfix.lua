local QuickfixPort = require("nvi.ports.quickfix")
local Keymap = require("nvi.ui.keymap")

local M = {}

function M.setup(adapter)
  local quickfix = QuickfixPort.validate(adapter)

  Keymap.nmap(
    "<leader>xo",
    quickfix.open,
    "打开 Quickfix 列表"
  )

  Keymap.nmap(
    "<leader>xc",
    quickfix.close,
    "关闭 Quickfix 列表"
  )

  Keymap.nmap(
    "]q",
    quickfix.next_item,
    "下一个 Quickfix 项"
  )

  Keymap.nmap(
    "[q",
    quickfix.previous_item,
    "上一个 Quickfix 项"
  )
end

return M
