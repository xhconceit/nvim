local CompletionPort = require("nvi.ports.completion")

local M = {}

-- 给已连接 LSP 的 Buffer 附加补全功能
function M.attach(adapter, context)
  local completion = CompletionPort.validate(adapter)

  assert(
    type(context) == "table" and
    type(context.bufnr) == "number" and
    vim.api.nvim_buf_is_valid(context.bufnr) and
    type(context.client_id) == "number",
    "completion 需要有效的 LSP 上下文"
  )

  -- 为当前客户端和 Buffer 启用自动补全
  completion.enable(context)

  -- 手动触发补全
  vim.keymap.set(
    "i",
    "<C-Space>",
    completion.trigger,
    {
      buffer = context.bufnr,
      silent = true,
      desc = "触发代码补全"
    }
  )
end

return M
