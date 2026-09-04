local M = {}

local required_methods = {
  "core.commands.setup",
  "core.options.setup",
  "core.keymaps.setup",
  "core.autocmds.setup",
  "lazy.setup",
  "search.feature.setup",
  "formatting.feature.setup",
  "lsp.composition.setup",
  "file_explorer.feature.setup",
  "git.feature.setup"
}

local function get_path(value, path)
  local current = value
  for part in path:gmatch("[^.]+") do
    if type(current) ~= "table" then
      return nil
    end
    current = current[part]
  end
  return current
end

local function validate(dependencies)
  assert(
    type(dependencies) == "table",
    "nvi composition 需要依赖"
  )

  for _, path in ipairs(required_methods) do
    assert(
      type(get_path(dependencies, path)) == "function",
      "nvi composition 缺少依赖：" .. path
    )
  end

  assert(
    dependencies.search.adapter ~= nil,
    "nvi composition 缺少依赖：search.adapter"
  )

  assert(
    dependencies.formatting.adapter ~= nil,
    "nvi composition 缺少依赖：formatting.adapter"
  )

  assert(
    type(dependencies.lsp.dependencies) == "table",
    "nvi composition 缺少依赖：lsp.dependencies"
  )

  assert(
    dependencies.file_explorer.adapter ~= nil,
    "nvi composition 缺少依赖：file_explorer.adapter"
  )

  assert(
    dependencies.git.adapter ~= nil,
    "nvi composition 缺少依赖： git.adapter"
  )

  return dependencies
end


local function production_dependencies()
  return {

    core = {
      commands = require("nvi.core.commands"),
      options = require("nvi.core.options"),
      keymaps = require("nvi.core.keymaps"),
      autocmds = require("nvi.core.autocmds"),
    },

    lazy = require("nvi.infrastructure.lazy"),

    git = {
      feature = require("nvi.features.git"),
      adapter = require("nvi.adapters.gitsigns")
    },

    search = {
      feature = require("nvi.features.search"),
      adapter = require("nvi.adapters.mini_pick"),
    },

    file_explorer = {
      feature = require("nvi.features.file_explorer"),
      adapter = require("nvi.adapters.mini_files")
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
  dependencies = validate(
    dependencies or production_dependencies()
  )

  dependencies.core.commands.setup()
  dependencies.core.options.setup()
  dependencies.core.keymaps.setup()
  dependencies.core.autocmds.setup()

  dependencies.lazy.setup()

  dependencies.search.feature.setup(
    dependencies.search.adapter
  )

  dependencies.file_explorer.feature.setup(
    dependencies.file_explorer.adapter
  )

  dependencies.git.feature.setup(
    dependencies.git.adapter
  )

  dependencies.formatting.feature.setup(
    dependencies.formatting.adapter
  )

  dependencies.lsp.composition.setup(
    dependencies.lsp.dependencies
  )
end

return M
