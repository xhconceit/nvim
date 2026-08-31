
local M = {}

-- 将代码智能端口映射到 Neovim 内置 LSP API

-- 显示光标位置的类型或文档
function M.hover()
  vim.lsp.buf.hover()
end

-- 跳转到符号定义
function M.definition()
  vim.lsp.buf.definition()
end

-- 查找符号的所有引用
function M.references()
  vim.lsp.buf.references()
end

-- 重命名当前符号
function M.rename()
  vim.lsp.buf.rename()
end

--- 显示可用的代码操作
function M.code_action()
  vim.lsp.buf.code_action()
end

return M
