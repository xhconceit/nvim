local lsp = require("lsp")

-- brew install lua-language-server
vim.lsp.config("lua_ls", {
  on_attach = lsp.on_attach,
  capabilities = lsp.capabilities,
  settings = {
    Lua = {
      workspace = { checkThirdParty = false }, -- 不检查第三方库
      telemetry = { enable = false }, -- 不发送 telemetry 数据
    },
  },
})

vim.lsp.enable("lua_ls")
