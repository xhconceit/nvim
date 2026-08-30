local M = {}

function M.setup()
  -- Leader 必须在定义快捷键之前设置
  vim.g.mapleader = " "
  vim.g.maplocalleader = " "

  local function map(mode, lhs, rhs, description)
    vim.keymap.set(mode, lhs, rhs, {
      silent = true,
      desc = description,
    })
  end

 -- 文件操作
  map("n", "<leader>w", "<cmd>write<cr>", "保存文件")
  map("n", "<leader>q", "<cmd>confirm quit<cr>", "关闭窗口")

  -- 搜索
  map("n", "<Esc>", "<cmd>nohlsearch<cr>", "清除搜索高亮")

  -- 窗口导航
  map("n", "<C-h>", "<C-w>h", "移动到左侧窗口")
  map("n", "<C-j>", "<C-w>j", "移动到下方窗口")
  map("n", "<C-k>", "<C-w>k", "移动到上方窗口")
  map("n", "<C-l>", "<C-w>l", "移动到右侧窗口")

  -- Buffer 导航
  map("n", "[b", "<cmd>bprevious<cr>", "上一个 Buffer")
  map("n", "]b", "<cmd>bnext<cr>", "下一个 Buffer")
  map("n", "<leader>bd", "<cmd>bdelete<cr>", "关闭当前 Buffer")

  -- 调整缩进后保持选区
  map("v", "<", "<gv", "减少缩进")
  map("v", ">", ">gv", "增加缩进")
end

return M
