local M = {}

local function validate(dependencies)
  assert(type(dependencies) == "table", "LSP composition 需要依赖")

  assert(
    type(dependencies.infrastructure) == "table"
      and type(dependencies.infrastructure.setup) == "function",
    "LSP composition 缺少 infrastructure.setup"
  )

  assert(
    type(dependencies.code_intelligence) == "table",
    "LSP composition 缺少 code_intelligence"
  )

  assert(
    type(dependencies.code_intelligence.feature) == "table"
      and type(dependencies.code_intelligence.feature.attach) == "function",
    "LSP composition 缺少 code_intelligence.feature.attach"
  )

  assert(
    type(dependencies.code_intelligence.adapter) == "table",
    "LSP composition 缺少 code_intelligence.adapter"
  )

  assert(
    dependencies.servers == nil or type(dependencies.servers) == "table",
    "LSP composition servers 必须是 table"
  )

  assert(
    type(dependencies.diagnostics) == "table",
    "LSP composition 缺少 diagnostics"
  )

  assert(
    type(dependencies.diagnostics.feature) == "table"
      and type(dependencies.diagnostics.feature.attach) == "function",
    "LSP composition 缺少 diagnostics.feature.attach"
  )

  assert(
    type(dependencies.diagnostics.adapter) == "table",
    "LSP composition 缺少 diagnostics.adapter"
  )
  assert(
    type(dependencies.diagnostics.adapter.setup) == "function",
    "LSP composition 缺少 diagnostics.adapter.setup"
  )

  return dependencies
end

function M.setup(dependencies)
  dependencies = validate(dependencies)

  local infrastructure = dependencies.infrastructure
  local code_intelligence = dependencies.code_intelligence
  local diagnostics = dependencies.diagnostics

  diagnostics.adapter.setup()

  infrastructure.setup({
    servers = dependencies.servers,
    on_attach = function(context)
      code_intelligence.feature.attach(code_intelligence.adapter, context.bufnr)

      diagnostics.feature.attach(diagnostics.adapter, context.bufnr)
    end,
  })
end

return M
