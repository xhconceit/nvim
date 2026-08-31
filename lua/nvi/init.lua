local M = {}

function M.setup() -- 核心层
  require("nvi.core.commands").setup()
  require("nvi.core.options").setup()
  require("nvi.core.keymaps").setup()
  require("nvi.core.autocmds").setup()

  -- 基础实施
  require("nvi.infrastructure.lazy").setup()

  -- 适配器
  local picker = require("nvi.adapters.mini_pick")
  local formatter = require("nvi.adapters.lsp_formatter")

  -- 功能层
  require("nvi.features.search").setup({
    find_files = picker.find_files,
    search_text = picker.search_text
  })

  require("nvi.features.formatting").setup(formatter)

end

return M
