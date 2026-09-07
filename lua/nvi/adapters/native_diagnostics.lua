local M = {}

function M.setup()
  local severity = vim.diagnostic.severity

  vim.diagnostic.config({
    severity_sort = true, -- 错误显示在警告和提示之前
    update_in_insert = false, -- 输入期间不反复刷新诊断，减少视觉抖动
    underline = true,

    signs = {
      text = { --- 左侧标志列显示不同级别的图标
        [severity.ERROR] = " ",
        [severity.WARN] = " ",
        [severity.INFO] = " ",
        [severity.HINT] = "󰌵 ",
      },
    },
    virtual_text = {
      spacing = 2,
      prefix = "●",
      source = "if_many", -- 只有存在多个诊断来源时才标出来源，减少噪声
    },
    float = { -- 统一诊断浮窗的圆角和内容格式
      border = "rounded",
      source = true,
      header = "",
      prefix = "",
    },
  })
end

function M.show_current()
  vim.diagnostic.open_float({
    scope = "cursor",
    border = "rounded",
    source = true,
  })
end

function M.jump_next()
  vim.diagnostic.jump({
    count = 1,
    wrap = true,
  })
end

function M.jump_previous()
  vim.diagnostic.jump({
    count = -1,
    wrap = true,
  })
end

function M.open_list()
  vim.diagnostic.setloclist({
    open = true,
    title = "Buffer Diagnostics",
  })
end

function M.open_workspace_list()
  vim.diagnostic.setqflist({
    open = true,
    title = "Workspace Diagnostics",
  })
end

function M.toggle()
  local enabled = vim.diagnostic.is_enabled({ bufnr = 0 })
  vim.diagnostic.enable(not enabled, { bufnr = 0 })
end

return M
