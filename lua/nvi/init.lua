local M = {}

function M.setup()
  -- 核心层
  require("nvi.core.commands").setup()
  require("nvi.core.options").setup()
  require("nvi.core.keymaps").setup()
  require("nvi.core.autocmds").setup()

  -- 基础设施
  require("nvi.infrastructure.lazy").setup()

  -- 选择具体适配器
  local search_adapter =
      require("nvi.adapters.mini_pick")

  local formatter_adapter =
      require("nvi.adapters.lsp_formatter")

  local code_intelligence_adapter = require("nvi.adapters.native_lsp")

  local completion_adapter =
      require("nvi.adapters.native_completion")

  -- 注入功能层
  require("nvi.features.search").setup(
    search_adapter
  )

  require("nvi.features.formatting").setup(
    formatter_adapter
  )

  local completion =
      require("nvi.features.completion")

  -- 语言服务器连接后，给对应 Buffer 附加代码智能功能
  local code_intelligence = require("nvi.features.code_intelligence")

  require("nvi.infrastructure.lsp").setup({
    on_attach = function(context)
      code_intelligence.attach(
        code_intelligence_adapter,
        context.bufnr
      )

      completion.attach(
        completion_adapter,
        context
      )
    end,

    servers = {
      lua_ls = require(
        "nvi.infrastructure.lsp.servers.lua_ls"
      ),
    }
  })
end

return M
