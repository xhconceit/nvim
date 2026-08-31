local SearchPort = require("nvi.ports.search")
local M = {}

function M.setup(adapter)
  local search = SearchPort.validate(adapter)

  vim.keymap.set("n", "<leader>ff", search.find_files, {
    silent = true,
    desc = "搜索文件"
  })

  vim.keymap.set("n", "<leader>fg", search.search_text, {
    silent = true,
    desc = "搜索文本"
  })

end

return M
