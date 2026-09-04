
local GitPort = require("nvi.ports.git")
local Keymap = require("nvi.ui.keymap")

local M = {}

function M.setup(adapter)
  local git = GitPort.validate(adapter)

  Keymap.nmap("]h", git.next_hunk, "跳到下一个 Git 变更块")
  Keymap.nmap("[h", git.prev_hunk, "跳到上一个 Git 变更块")
  Keymap.nmap("<leader>hs", git.stage_hunk, "暂存 Git 变更块")
  Keymap.nmap("<leader>hr", git.reset_hunk, "撤销 Git 变更块")
  Keymap.nmap("<leader>hp", git.preview_hunk, "预览 Git 变更块")
end

return M
