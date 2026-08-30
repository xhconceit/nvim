local M = {}

function M.setup()
  require("nvi.core.commands").setup()
	require("nvi.core.options").setup()
  require("nvi.core.keymaps").setup()
  require("nvi.core.autocmds").setup()
end

return M
