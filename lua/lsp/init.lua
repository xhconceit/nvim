local keymap = require("core.keymap")
local M = {}

--- 绑定快捷键
M.on_attach = function(client, bufnr)
  local map = function(key, func, desc) keymap.map("n", key, func, { buffer = bufnr, desc = desc }) end
  map("gd", vim.lsp.buf.definition, "跳转定义")
  map("gD", vim.lsp.buf.declaration, "跳转声明")
  map("gr", vim.lsp.buf.references, "查看引用")
  map("gi", vim.lsp.buf.implementation, "跳转实现")
  map("gh", vim.lsp.buf.hover, "悬停文档")
  map("<leader>lr", vim.lsp.buf.rename, "重命名")
  map("<leader>la", vim.lsp.buf.code_action, "代码操作")
  map("<leader>ld", vim.diagnostic.open_float, "行内诊断")
  map("[d", vim.diagnostic.goto_prev, "上一个诊断")
  map("]d", vim.diagnostic.goto_next, "下一个诊断")
end

--- 添加补全能力
M.capabilities = vim.lsp.protocol.make_client_capabilities()

return M
