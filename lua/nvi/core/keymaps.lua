local M = {}
local Keymap = require("nvi.ui.keymap")

function M.setup()
  -- Leader 必须在定义快捷键之前设置
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  --
  Keymap.nmap("<leader>nh", ":nohlsearch<cr>", "清除搜索高亮")

  -- 文件操作
  Keymap.nmap("<leader>fs", "<cmd>write<cr>", "保存文件")
  Keymap.set(
    { "n", "v" },
    "<leader>y",
    '"+y',
    "复制到系统剪贴板"
  )

  -- 按需从系统剪贴板粘贴
  Keymap.cmap("<D-v>", "<C-r>+", "从系统剪贴板粘贴")
  Keymap.imap("<D-v>", "<C-r>+", "从系统剪贴板粘贴")
  Keymap.nmap("<D-v>", '"+p', "从系统剪贴板粘贴")
  Keymap.vmap("<D-v>", '"+p', "从系统剪贴板粘贴")
  Keymap.tmap(
    "<D-v>",
    function()
      local job_id = vim.b.terminal_job_id

      if job_id then
        vim.api.nvim_chan_send(
          job_id,
          vim.fn.getreg("+")
        )
      end
    end,
    "从系统剪贴板粘贴"
  )

  -- Terminal
  Keymap.tmap(
    "<Esc><Esc>",
    [[<C-\><C-n>]],
    "退出终端模式"
  )

  -- 退出
  Keymap.nmap("<leader>qa", "<cmd>qa<CR>", "退出 Neovim")
  Keymap.nmap("<leader>qf", "<cmd>qa!<CR>", "强制退出 Neovim")
  Keymap.nmap("<leader>qw", "<cmd>wq<CR>", "保存并关闭当前窗口")

  -- 搜索
  Keymap.nmap("<Esc>", "<cmd>nohlsearch<cr>", "清除搜索高亮")

  -- 快速移动
  Keymap.set(
    { "n", "v" },
    "J",
    "5j",
    "向下移动 5 行"
  )
  Keymap.set(
    { "n", "v" },
    "K",
    "5k",
    "向上移动 5 行"
  )
  Keymap.nmap("H", "5h", "向左移动 5 列")
  Keymap.nmap("L", "5l", "向右移动 5 列")

  -- 跳转列表
  Keymap.nmap("<leader>jo", "<C-o>", "上一个光标位置")
  Keymap.nmap("<leader>ji", "<C-i>", "下一个光标位置")

  -- 调整缩进后保持选区
  Keymap.vmap("<", "<gv", "减少缩进")
  Keymap.vmap(">", ">gv", "增加缩进")
end

return M
