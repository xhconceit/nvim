local M = {}

local function production_dependencies()
  return {
    core = {
      commands = require("nvi.core.commands"),
      options = require("nvi.core.options"),
      keymaps = require("nvi.core.keymaps"),
      autocmds = require("nvi.core.autocmds"),
    },

    lazy = require("nvi.infrastructure.lazy"),

    search = {
      feature = require("nvi.features.search"),
      adapter = require("nvi.adapters.mini_pick"),
    },

    formatting = {
      feature = require("nvi.features.formatting"),
      adapter = require("nvi.adapters.lsp_formatter"),
    },

    lsp = {
      composition = require("nvi.composition.lsp"),
      dependencies = {
        infrastructure =
          require("nvi.infrastructure.lsp"),

        code_intelligence = {
          feature =
            require("nvi.features.code_intelligence"),
          adapter =
            require("nvi.adapters.native_lsp"),
        },

        completion = {
          feature =
            require("nvi.features.completion"),
          adapter =
            require("nvi.adapters.native_completion"),
        },

        diagnostics = {
          feature =
            require("nvi.features.diagnostics"),
          adapter =
            require("nvi.adapters.native_diagnostics"),
        },

        servers = {
          lua_ls = require(
            "nvi.infrastructure.lsp.servers.lua_ls"
          ),
        },
      },
    },
  }
end

function M.setup(dependencies)
  dependencies =
    dependencies or production_dependencies()

  dependencies.core.commands.setup()
  dependencies.core.options.setup()
  dependencies.core.keymaps.setup()
  dependencies.core.autocmds.setup()

  dependencies.lazy.setup()

  dependencies.search.feature.setup(
    dependencies.search.adapter
  )

  dependencies.formatting.feature.setup(
    dependencies.formatting.adapter
  )

  dependencies.lsp.composition.setup(
    dependencies.lsp.dependencies
  )
end

return M
