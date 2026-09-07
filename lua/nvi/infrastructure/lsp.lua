local M = {}

-- 注册并启用组合根传入的语言服务器
local function enable_servers(servers)
  for name, config in pairs(servers or {}) do
    vim.lsp.config(name, config)
    vim.lsp.enable(name)
  end
end

function M.setup(options)
  -- 基础设施通过回调连接功能层，不直接 require 功能模块
  assert(
    type(options) == "table" and type(options.on_attach) == "function",
    "LSP infrastructure 需要 on_attch 回调"
  )

  assert(
    options.servers == nil or type(options.servers) == "table",
    "LSP servers 必须是 table"
  )

  local group = vim.api.nvim_create_augroup("nvi_lsp", { clear = true })

  -- 语言服务器连接 Buffer 后，通知组合根
  vim.api.nvim_create_autocmd("LspAttach", {
    group = group,
    desc = "附加代码智能功能",
    callback = function(event)
      -- options.on_attach(event)
      -- 把 Neovim 原始事件转换成统一的 LSP 上下文
      options.on_attach({
        bufnr = event.buf,
        client_id = event.data.client_id,
      })
    end,
  })

  -- 统一配置诊断信息的显示方式
  vim.diagnostic.config({
    severity_sort = true,
    update_in_insert = false,
    underline = true,
    signs = true,
    virtual_text = {
      spacing = 2,
      prefix = "●",
    },
    float = {
      border = "rounded",
      source = true,
    },
  })

  -- 必须先监听 LspAttach 在启用服务器
  enable_servers(options.servers)
end

return M
