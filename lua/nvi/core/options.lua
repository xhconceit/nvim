local M = {}

function M.setup()
	local opt = vim.opt

	-- 界面
	opt.number = true
	opt.relativenumber = true
	opt.cursorline = true
	opt.signcolumn = "yes"
	opt.scrolloff = 8
	opt.termguicolors = true

	-- 编辑
	opt.expandtab = true
	opt.tabstop = 2
	opt.shiftwidth = 2
	opt.smartindent = true
	opt.wrap = false

	-- 搜索
	opt.ignorecase = true
	opt.smartcase = true

	-- 窗口
	opt.splitright = true
	opt.splitbelow = true

	-- 系统交互
	opt.mouse = "a"
	opt.clipboard = "unnamedplus"
	opt.undofile = true
	opt.confirm = true
end

return M
