
local M = {}

function M.next_hunk()
  require("gitsigns").nav_hunk("next")
end


function M.prev_hunk()
  require("gitsigns").nav_hunk("prev")
end

function M.stage_hunk()
  require("gitsigns").stage_hunk()
end

function M.reset_hunk()
  require("gitsigns").reset_hunk()
end

function M.preview_hunk()
  require("gitsigns").preview_hunk()
end

function M.blame_line()
  require("gitsigns").blame_line()
end

function M.toggle_line_blame()
  require("gitsigns").toggle_current_line_blame()
end

return M
