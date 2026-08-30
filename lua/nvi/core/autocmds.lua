local M = {}

function M.setup()
  local group = vim.api.nvim_create_augroup("nvi_core", {
    clear = true,
  })

  -- 复制文字命令后短暂高亮
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    desc = "复制文字后高亮选区",
    callback = function()
      vim.highlight.on_yank({
        higroup = "IncSearch",
        timeout = 150,
      })
    end
  })

  -- 回到 Neovim 时检查文件是否被外部程序修改
  vim.api.nvim_create_autocmd({
    "FocusGained",
    "TermClose",
    "TermLeave"
  }, {
    group = group,
    desc = "检查文件的外部修改",
    command = "checktime"
  })

  -- 终端窗口尺寸改变后，重新平均分配窗口
  vim.api.nvim_create_autocmd("VimResized", {
    group = group,
    desc = "重新平衡窗口尺寸",
    callback = function()
      vim.cmd("wincmd =")
    end
  })
end

return M
