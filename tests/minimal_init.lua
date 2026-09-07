vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 让 require() 能找到当前仓库的 lua/nvi
vim.opt.runtimepath:prepend(vim.fn.getcwd())
