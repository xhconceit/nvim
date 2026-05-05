local keymap = require("core.keymap")
local text = require("core.text")
local map = keymap.map
local nmap = keymap.nmap
local imap = keymap.imap
local tmap = keymap.tmap
local cmap = keymap.cmap
local vmap = keymap.vmap

-- 窗口管理
nmap("<leader>nh", ":nohlsearch<cr>", { desc = "清除搜索高亮" })
nmap("wa", ":set splitright<cr>:vsp<cr><C-w>h", { desc = "左右分屏, 光标留在左边" })
nmap("wd", ":set splitright<CR>:vsp<CR>", { desc = "左右分屏, 光标留在右边" })
nmap("ww", ":set splitbelow<CR>:sp<CR><C-w>k", { desc = "上下分屏, 光标留在上方" })
nmap("ws", ":set splitbelow<CR>:sp<CR>", { desc = "上下分屏, 光标留在下方" })
nmap("wq", "<C-w>c", { desc = "关闭当前窗口" })
nmap("we", "<C-w>o", { desc = "关闭其他" })
nmap("wt", "<C-w>W", { desc = "切换窗口" })
-- 窗口跳转
nmap("wh", "<C-w>h", { desc = "向左边窗口跳转" })
nmap("wj", "<C-w>j", { desc = "向下边窗口跳转" })
nmap("wk", "<C-w>k", { desc = "向上边窗口跳转" })
nmap("wl", "<C-w>l", { desc = "向右边窗口跳转" })
-- 窗口调整
nmap("wmh", ":vertical resize -5<CR>", { desc = "窗口大小向左边移动" })
nmap("wml", ":vertical resize +5<CR>", { desc = "窗口大小向右边移动" })
nmap("wmk", ":resize -5<CR>", { desc = "窗口大小向上边移动" })
nmap("wmj", ":resize +5<CR>", { desc = "窗口大小向下边移动" })

-- 移动
map({ "n", "v" }, "J", "5j", { desc = "向下移动5行" })
map({ "n", "v" }, "K", "5k", { desc = "向上移动5行" })
map("n", "H", "5h", { desc = "向左边移动5列" })
map("n", "L", "5l", { desc = "向右边移动5列" })
nmap(",", "^", { desc = "跳转到行首" })
nmap(".", "$", { desc = "跳转到行尾" })

-- 删除
nmap("d.", "d$", { desc = "删除到行尾" })
nmap("d,", "d^", { desc = "删除到行首" })
nmap("d>", "d$", { desc = "删除到行尾" })
nmap("d<", "d^", { desc = "删除到行首" })
nmap("dl", "d$", { desc = "删除到行尾" })
nmap("dh", "d^", { desc = "删除到行首" })

-- 复制
nmap("y.", "y$", { desc = "复制到行尾" })
nmap("y,", "y^", { desc = "复制到行首" })
nmap("y>", "y$", { desc = "复制到行尾" })
nmap("y<", "y^", { desc = "复制到行首" })
nmap("yl", "y$", { desc = "复制到行尾" })
nmap("yh", "y^", { desc = "复制到行首" })

-- 复制到系统剪切板
map({ "n", "v" }, "Y", '"+y', { desc = "复制到系统剪切板" })

-- 粘贴
map({ "n", "v" }, "P", '"+p', { desc = "粘贴系统剪切板" })
-- 还原上一步
nmap("U", "<C-r>", { desc = "还原上一步" })
-- 当前数字加1
nmap("=", "<C-a>", { desc = "当前数字加1" })
-- 当前数字减1
nmap("-", "<C-x>", { desc = "当前数字减1" })

-- buffer
nmap("<leader>bj", ":bn<cr>", { desc = "下一个 buffer" })
nmap("<leader>bk", ":bp<cr>", { desc = "上一个 buffer" })
nmap("<leader>bq", ":bd<cr>", { desc = "关闭当前 buffer" })
nmap("<BS>", "<C-o>", { desc = "上一个光标位置" })
nmap("<S-BS>", "<C-i>", { desc = "下一个光标位置" })
nmap("`", "~", { desc = "关闭当前字母大小写" })
nmap("<tab>", "`", { desc = "mark 键" })
nmap("<tab><tab>", "``", { desc = "切换光标位置" })
nmap("qa", ":qa<cr>", { desc = "退出 NVIM" })
nmap("q1", ":q!<cr>", { desc = "强制退出 NVIM" })
nmap("qw", ":wq<cr>", { desc = "保存文件退出 NVIM" })

imap("<c-j>", "<down>", { desc = "向下移动" })
imap("<c-k>", "<up>", { desc = "向上移动" })
imap("<c-l>", "<right>", { desc = "向右移动" })
imap("<c-h>", "<left>", { desc = "向左移动" })
imap("<c-o>", "<Esc>o", { desc = "插入模式下插入" })
imap("<c-;>", "<Esc>I", { desc = "插入模式下插入到行首" })
imap("<c-'>", "<Esc>A", { desc = "插入模式下插入到行尾" })
imap("<c-e>", "<Esc>ea", { desc = "插入模式下插入到单词末尾" })
imap("<c-b>", "<Esc>bi", { desc = "插入模式下插入到单词开头" })

-- cmap("<c-v>", "<c-r>*<left>", { desc = "从系统剪贴板中粘贴内容" })
cmap("<D-v>", "<c-r>*<left>", { desc = "从系统剪贴板中粘贴内容" })
imap("<d-v>", '<esc>"+pa', { desc = "从系统剪贴板中粘贴内容" })
-- imap("<c-v>", '<esc>"+pa', { desc = "从系统剪贴板中粘贴内容" })
tmap("<c-v>", '<c-\\><c-n>"+pa', { desc = "从系统剪贴板中粘贴内容" })
nmap("<d-v>", '"+p', { desc = "从系统剪贴板中粘贴内容" })
vmap("<d-v>", '"+p', { desc = "从系统剪贴板中粘贴内容" })
tmap("<d-v>", '<c-\\><c-n>"+pa', { desc = "从系统剪贴板中粘贴内容" })
tmap("<esc>", "<c-\\><c-n>", { desc = "终端进入 ESC" })

local function search_selected_text()
  local selected_text = text.get_selected_text()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "x", false)
  local escaped = selected_text:gsub("\\", "\\\\"):gsub("\n", "\\n")
  vim.fn.setreg("/", "\\V" .. escaped)
  vim.opt.hlsearch = true
  pcall(vim.cmd, "normal! n")
end

vmap("/", search_selected_text, { desc = "搜索选中文本" })

-- 重新加载配置
nmap("<leader>rr", function()
  for name, _ in pairs(package.loaded) do
    if name:match("^config") or name:match("^core") or name:match("^plugins") then package.loaded[name] = nil end
  end
  dofile(vim.env.MYVIMRC)
  vim.notify("配置已重新加载", vim.log.levels.INFO)
end, { desc = "重新加载配置" })
