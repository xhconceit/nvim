
local FormatterPort = require("nvi.ports.formatter")

local M = {}

function M.setup(adapter)
  local formatter = FormatterPort.validate(adapter)

  vim.keymap.set("n", "<leader>cf", function ()
    formatter.format_buffer({
      bufnr = vim.api.nvim_get_current_buf()
    })
  end, {
  silent = true,
  desc = "格式化当前文件"
}
  )
end

return M

