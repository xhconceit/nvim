for _, lhs in ipairs({
  "<leader>bj",
  "<leader>bk",
  "<leader>bq",
}) do
  pcall(vim.keymap.del, "n", lhs)
end

require("nvi.core.keymaps").setup()

local expected_mappings = {
  ["<leader>fs"] = "保存文件",
  ["<leader>y"] = "复制到系统剪贴板",
  ["<leader>qa"] = "退出 Neovim",
  ["<leader>qf"] = "强制退出 Neovim",
  ["<leader>qw"] = "保存并关闭当前窗口",
  ["J"] = "向下移动 5 行",
  ["H"] = "向左移动 5 列",
  ["K"] = "向上移动 5 行",
  ["L"] = "向右移动 5 列",
  ["<leader>jo"] = "上一个光标位置",
  ["<leader>ji"] = "下一个光标位置",
}

for lhs, description in pairs(expected_mappings) do
  local mapping = vim.fn.maparg(
    lhs,
    "n",
    false,
    true
  )

  assert(
    mapping.desc == description,
    lhs .. " 没有注册正确的窗口快捷键"
  )
end

for _, lhs in ipairs({
  "<leader>wa",
  "<leader>wd",
  "<leader>ww",
  "<leader>ws",
  "<leader>wq",
  "<leader>we",
  "<leader>wt",
  "<leader>wh",
  "<leader>wj",
  "<leader>wk",
  "<leader>wl",
  "<C-h>",
  "<C-j>",
  "<C-k>",
  "<C-l>",
  "<leader>wmh",
  "<leader>wml",
  "<leader>wmk",
  "<leader>wmj",
}) do
  local mapping = vim.fn.maparg(lhs, "n", false, true)
  local description = mapping.desc or ""

  assert(
    not description:find("窗口", 1, true),
    lhs .. " 应该由 window Feature 管理"
  )
end

for _, lhs in ipairs({
  "J",
  "K",
  "<leader>y",
}) do
  local mapping = vim.fn.maparg(
    lhs,
    "v",
    false,
    true
  )

  assert(
    type(mapping.desc) == "string",
    lhs .. " 应该同时注册到 Visual 模式"
  )
end

assert(
  vim.tbl_isempty(
    vim.fn.maparg("<leader>j", "n", false, true)
  ),
  "<leader>j 应该只作为跳转命名空间前缀"
)

for _, lhs in ipairs({
  "<leader>h",
  "<leader>k",
  "<leader>l",
  "<leader>jh",
  "<leader>jj",
  "<leader>jk",
  "<leader>jl",
}) do
  assert(
    vim.tbl_isempty(
      vim.fn.maparg(lhs, "n", false, true)
    ),
    lhs .. " 旧快速移动快捷键应该被移除"
  )
end

local system_clipboard_mapping = vim.fn.maparg(
  "<leader>y",
  "n",
  false,
  true
)

assert(
  system_clipboard_mapping.rhs == '"+y',
  "<leader>y 应该使用系统剪贴板寄存器"
)

for _, mode in ipairs({
  "n",
  "v",
  "i",
  "c",
  "t",
}) do
  local mapping = vim.fn.maparg(
    "<D-v>",
    mode,
    false,
    true
  )

  assert(
    mapping.desc == "从系统剪贴板粘贴",
    "<D-v> 没有注册到模式 " .. mode
  )
end

local terminal_escape_mapping = vim.fn.maparg(
  "<Esc><Esc>",
  "t",
  false,
  true
)

assert(
  terminal_escape_mapping.desc == "退出终端模式",
  "<Esc><Esc> 没有注册 Terminal 退出映射"
)

local old_save_mapping = vim.fn.maparg(
  "<leader>w",
  "n",
  false,
  true
)

assert(
  vim.tbl_isempty(old_save_mapping),
  "<leader>w 应该只作为窗口命名空间前缀"
)

assert(
  vim.tbl_isempty(
    vim.fn.maparg("<leader>q", "n", false, true)
  ),
  "<leader>q 应该只作为退出命名空间前缀"
)

for _, lhs in ipairs({
  "<leader>bd",
  "<leader>bj",
  "<leader>bk",
  "<leader>bq",
}) do
  assert(
    vim.tbl_isempty(
      vim.fn.maparg(lhs, "n", false, true)
    ),
    lhs .. " 旧 Buffer 快捷键应该被移除"
  )
end

print("core_keymaps_test: OK")
