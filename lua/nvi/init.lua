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
  "git.feature.setup",
  "buffer.feature.setup",
  "terminal.feature.setup",
  "quickfix.feature.setup",
  "window.feature.setup",
  "tab.feature.setup",
  "session.feature.setup",
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
    dependencies.window.adapter ~= nil,
    "nvi composition 缺少依赖：window.adapter"
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
    "nvi composition 缺少依赖：git.adapter"
  )

  assert(
    dependencies.buffer.adapter ~= nil,
    "nvi composition 缺少依赖：buffer.adapter"
  )

  assert(
    dependencies.terminal.adapter ~= nil,
    "nvi composition 缺少依赖：terminal.adapter"
  )

  assert(
    dependencies.quickfix.adapter ~= nil,
    "nvi composition 缺少依赖：quickfix.adapter"
  )

  assert(
    dependencies.tab.adapter ~= nil,
    "nvi composition 缺少依赖：tab.adapter"
  )
  assert(dependencies.session.adapter ~= nil, "nvi composition 缺少依赖：session.adapter")

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

    buffer = {
      feature = require("nvi.features.buffer"),
      adapter = require("nvi.adapters.native_buffer")
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

    terminal = {
      feature = require("nvi.features.terminal"),
      adapter = require("nvi.adapters.native_terminal")
    },

    quickfix = {
      feature = require("nvi.features.quickfix"),
      adapter = require("nvi.adapters.native_quickfix")
    },

    window = {
      feature = require("nvi.features.window"),
      adapter = require("nvi.adapters.native_window")
    },

    tab = {
      feature = require("nvi.features.tab"),
      adapter = require("nvi.adapters.native_tab")
    },
    session = {
      feature = require("nvi.features.session"),
      adapter = require("nvi.adapters.native_session"),
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

  dependencies.buffer.feature.setup(
    dependencies.buffer.adapter
  )
  dependencies.terminal.feature.setup(
    dependencies.terminal.adapter
  )

  dependencies.window.feature.setup(
    dependencies.window.adapter
  )

  dependencies.tab.feature.setup(
    dependencies.tab.adapter
  )

  dependencies.session.feature.setup(
    dependencies.session.adapter
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

  dependencies.quickfix.feature.setup(
    dependencies.quickfix.adapter
  )

  dependencies.lsp.composition.setup(
    dependencies.lsp.dependencies
  )
end

return M
