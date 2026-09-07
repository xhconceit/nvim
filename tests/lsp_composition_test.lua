local captured_lsp_options = nil
local LspComposition = require("nvi.composition.lsp")

local code_attach = nil
local diagnostics_attach = nil
local diagnostics_setup = 0

local fake_code_adapter = {
  name = "fake-code-adapter",
}

local fake_diagnostics_adapter = {
  name = "fake-diagnostics-adapter",
  setup = function()
    diagnostics_setup = diagnostics_setup + 1
  end,
}

local fake_dependencies = {
  infrastructure = {
    setup = function(options)
      captured_lsp_options = options
    end,
  },

  code_intelligence = {
    adapter = fake_code_adapter,

    feature = {
      attach = function(adapter, bufnr)
        code_attach = {
          adapter = adapter,
          bufnr = bufnr,
        }
      end,
    },
  },

  diagnostics = {
    adapter = fake_diagnostics_adapter,

    feature = {
      attach = function(adapter, bufnr)
        diagnostics_attach = {
          adapter = adapter,
          bufnr = bufnr,
        }
      end,
    },
  },

  servers = {
    lua_ls = {
      name = "fake-lua-ls",
    },
  },
}

LspComposition.setup(fake_dependencies)

assert(diagnostics_setup == 1, "组合根应该配置一次诊断适配器")

assert(
  type(captured_lsp_options) == "table",
  "组合根没有配置 LSP 基础设施"
)

assert(
  type(captured_lsp_options.on_attach) == "function",
  "组合根没有向 LSP 提供 on_attach"
)

assert(
  captured_lsp_options.servers == fake_dependencies.servers,
  "组合根没有传递语言服务器配置"
)

local context = {
  bufnr = 17,
  client_id = 42,
}

captured_lsp_options.on_attach(context)

assert(code_attach ~= nil, "LSP 连接后没有附加代码智能")

assert(
  code_attach.adapter == fake_code_adapter,
  "代码智能使用了错误的适配器"
)

assert(
  code_attach.bufnr == context.bufnr,
  "代码智能附加到了错误的 Buffer"
)

assert(diagnostics_attach ~= nil, "LSP 连接后没有附加诊断功能")

assert(
  diagnostics_attach.adapter == fake_diagnostics_adapter,
  "诊断功能使用了错误的适配器"
)

assert(
  diagnostics_attach.bufnr == context.bufnr,
  "诊断功能附加到了错误的 Buffer"
)

assert(
  diagnostics_attach.bufnr == code_attach.bufnr,
  "代码智能和诊断没有附加到同一个 Buffer"
)

local invalid_diagnostics = vim.deepcopy(fake_dependencies)

invalid_diagnostics.diagnostics.feature.attach = nil

local diagnostics_ok, diagnostics_error = pcall(function()
  LspComposition.setup(invalid_diagnostics)
end)

assert(not diagnostics_ok, "缺少 diagnostics.feature.attach 时应该失败")

assert(
  diagnostics_error:match("diagnostics%.feature%.attach"),
  "错误信息应该指出缺少 diagnostics.feature.attach"
)

local invalid_diagnostics_adapter = vim.deepcopy(fake_dependencies)

invalid_diagnostics_adapter.diagnostics.adapter.setup = nil

local adapter_ok, adapter_error = pcall(function()
  LspComposition.setup(invalid_diagnostics_adapter)
end)

assert(not adapter_ok, "缺少 diagnostics.adapter.setup 时应该失败")
assert(
  adapter_error:match("diagnostics%.adapter%.setup"),
  "错误信息应该指出缺少 diagnostics.adapter.setup"
)

print("lsp_composition_test: OK")
