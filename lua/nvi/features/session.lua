
local SessionPort = require("nvi.ports.session")
local Keymap = require("nvi.ui.keymap")

local M = {}

function M.setup(adapter)
  local session = SessionPort.validate(adapter)

  Keymap.nmap(
    "<leader>ss",
    session.save_current,
    "保存当前项目会话"
  )

  Keymap.nmap(
    "<leader>sl",
    session.restore_current,
    "恢复当前项目会话"
  )

  Keymap.nmap(
    "<leader>sd",
    session.delete_current,
    "删除当前项目会话"
  )

end

return M
