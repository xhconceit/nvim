require("nvi.core.keymaps").setup()

local expected_mappings = {
  ["<leader>fs"] = "保存文件",
  ["<leader>y"] = "复制到系统剪贴板",
  ["<leader>qa"] = "退出 Neovim",
  ["<leader>qf"] = "强制退出 Neovim",
  ["<leader>qw"] = "保存并关闭当前窗口",
  ["<leader>bj"] = "下一个 Buffer",
  ["<leader>bk"] = "上一个 Buffer",
  ["<leader>bq"] = "关闭当前 Buffer",
  ["J"] = "向下移动 5 行",
  ["H"] = "向左移动 5 列",
  ["K"] = "向上移动 5 行",
  ["L"] = "向右移动 5 列",
  ["<leader>jo"] = "上一个光标位置",
  ["<leader>ji"] = "下一个光标位置",
  ["<leader>wa"] = "左右分屏，光标留在左边",
  ["<leader>wd"] = "左右分屏，光标留在右边",
  ["<leader>ww"] = "上下分屏，光标留在上方",
  ["<leader>ws"] = "上下分屏，光标留在下方",
  ["<leader>wq"] = "关闭当前窗口",
  ["<leader>we"] = "关闭其他窗口",
  ["<leader>wt"] = "切换窗口",
  ["<leader>wh"] = "跳转到左侧窗口",
  ["<leader>wj"] = "跳转到下方窗口",
  ["<leader>wk"] = "跳转到上方窗口",
  ["<leader>wl"] = "跳转到右侧窗口",
  ["<leader>wmh"] = "缩小窗口宽度",
  ["<leader>wml"] = "增加窗口宽度",
  ["<leader>wmk"] = "缩小窗口高度",
  ["<leader>wmj"] = "增加窗口高度",
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
  "[b",
  "]b",
  "<leader>bd",
}) do
  assert(
    vim.tbl_isempty(
      vim.fn.maparg(lhs, "n", false, true)
    ),
    lhs .. " 旧 Buffer 快捷键应该被移除"
  )
end

print("core_keymaps_test: OK")
