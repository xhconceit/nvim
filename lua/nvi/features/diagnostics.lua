local DiagnosticsPort = require("nvi.ports.diagnostics")

local Keymap = require("nvi.ui.keymap")

local M = {}

local mappings = {
  {
    lhs = "<leader>dd",
    method = "show_current",
    desc = "显示当前位置诊断"
  },
  {
    lhs = "<leader>dn",
    method = "jump_next",
    desc = "下一个诊断"
  },
  {
    lhs = "<leader>dp",
    method = "jump_previous",
    desc = "上一个诊断"
  },
  {
    lhs = "<leader>dl",
    method = "open_list",
    desc = "打开诊断列表"
  },
  {
    lhs = "<leader>dq",
    method = "open_workspace_list",
    desc = "打开工作区诊断"
  }
}

function M.attach(adapter, bufnr)
  local diagnostics = DiagnosticsPort.validate(adapter)
  assert(
    type(bufnr) == "number" and vim.api.nvim_buf_is_valid(bufnr),
    "diagnostics 需要有效的 Buffer"
  )

  for _, mapping in ipairs(mappings) do
    Keymap.buffer(
      bufnr,
      "n",
      mapping.lhs,
      diagnostics[mapping.method],
      mapping.desc
    )
  end
end

return M
