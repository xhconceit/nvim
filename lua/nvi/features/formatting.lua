local FormatterPort = require("nvi.ports.formatter")
local Keymap = require("nvi.ui.keymap")

local M = {}

function M.setup(adapter)
  local formatter = FormatterPort.validate(adapter)

  Keymap.nmap("<leader>cf", function()
    formatter.format_buffer({
      bufnr = vim.api.nvim_get_current_buf(),
    })
  end, "格式化当前文件")

  Keymap.vmap("<leader>cf", function()
    local start_row = vim.fn.line("v")
    local end_row = vim.fn.line(".")

    if start_row > end_row then
      start_row, end_row = end_row, start_row
    end

    formatter.format_range({
      bufnr = vim.api.nvim_get_current_buf(),
      range = {
        start = { start_row - 1, 0 },
        ["end"] = { end_row, 0 },
      },
    })
  end, "格式化选中代码")
end

return M
