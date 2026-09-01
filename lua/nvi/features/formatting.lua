
local FormatterPort = require("nvi.ports.formatter")
local Keymap = require("nvi.ui.keymap")

local M = {}

function M.setup(adapter)
  local formatter = FormatterPort.validate(adapter)

  Keymap.nmap(
    "<leader>cf",
    function()
      formatter.format_buffer({
        bufnr = vim.api.nvim_get_current_buf()
      })
    end,
    "格式化当前文件"
  )
end

return M
