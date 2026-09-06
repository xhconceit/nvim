local BufferPort = require("nvi.ports.buffer")
local Keymap = require("nvi.ui.keymap")

local M = {}

function M.setup(adapter)
  local buffer = BufferPort.validate(adapter)

  Keymap.nmap("<leader>bn", buffer.new_buffer, "新建空 Buffer")

  Keymap.nmap(
    "<leader>bb",
    buffer.alternate_buffer,
    "切回上一个 Buffer"
  )

  Keymap.nmap(
    "<leader>bj",
    buffer.next_buffer,
    "下一个 Buffer"
  )

  Keymap.nmap(
    "<leader>bk",
    buffer.prev_buffer,
    "上一个 Buffer"
  )

  Keymap.nmap(
    "<leader>bq",
    buffer.close_buffer,
    "关闭当前 Buffer"
  )

end

return M
