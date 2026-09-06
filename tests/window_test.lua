local methods = {
  "split_vertical",
  "split_horizontal",
  "close",
  "only",
  "focus_left",
  "focus_down",
  "focus_up",
  "focus_right",
  "focus_previous",
  "equalize",
  "increase_height",
  "decrease_height",
  "increase_width",
  "decrease_width",
  "swap_next",
  "swap_previous",
}

local calls = {}
local adapter = {}

for _, method in ipairs(methods) do
  local name = method
  calls[name] = 0
  adapter[name] = function()
    calls[name] = calls[name] + 1
  end
end

require("nvi.features.window").setup(adapter)

local cases = {
  {
    lhs = "<leader>wa",
    desc = "左右分屏，光标留在左边",
    methods = { "split_vertical", "focus_left" },
  },
  {
    lhs = "<leader>wd",
    desc = "左右分屏，光标留在右边",
    methods = { "split_vertical" },
  },
  {
    lhs = "<leader>ww",
    desc = "上下分屏，光标留在上方",
    methods = { "split_horizontal", "focus_up" },
  },
  {
    lhs = "<leader>ws",
    desc = "上下分屏，光标留在下方",
    methods = { "split_horizontal" },
  },
  { lhs = "<leader>wq", desc = "关闭当前窗口", methods = { "close" } },
  { lhs = "<leader>we", desc = "关闭其他窗口", methods = { "only" } },
  { lhs = "<leader>wt", desc = "切换窗口", methods = { "focus_previous" } },
  { lhs = "<leader>wh", desc = "跳转到左侧窗口", methods = { "focus_left" } },
  { lhs = "<leader>wj", desc = "跳转到下方窗口", methods = { "focus_down" } },
  { lhs = "<leader>wk", desc = "跳转到上方窗口", methods = { "focus_up" } },
  { lhs = "<leader>wl", desc = "跳转到右侧窗口", methods = { "focus_right" } },
  { lhs = "<C-h>", desc = "移动到左侧窗口", methods = { "focus_left" } },
  { lhs = "<C-j>", desc = "移动到下方窗口", methods = { "focus_down" } },
  { lhs = "<C-k>", desc = "移动到上方窗口", methods = { "focus_up" } },
  { lhs = "<C-l>", desc = "移动到右侧窗口", methods = { "focus_right" } },
  { lhs = "<leader>w=", desc = "平均分配窗口", methods = { "equalize" } },
  { lhs = "<leader>wr", desc = "交换到下一个窗口", methods = { "swap_next" } },
  { lhs = "<leader>wR", desc = "交换到上一个窗口", methods = { "swap_previous" } },
  { lhs = "<leader>wmh", desc = "缩小窗口宽度", methods = { "decrease_width" } },
  { lhs = "<leader>wml", desc = "增加窗口宽度", methods = { "increase_width" } },
  { lhs = "<leader>wmk", desc = "缩小窗口高度", methods = { "decrease_height" } },
  { lhs = "<leader>wmj", desc = "增加窗口高度", methods = { "increase_height" } },
}

for _, case in ipairs(cases) do
  local mapping = vim.fn.maparg(case.lhs, "n", false, true)

  assert(
    mapping.desc == case.desc,
    case.lhs .. " 没有保留原快捷键语义"
  )
  assert(
    type(mapping.callback) == "function",
    case.lhs .. " 没有 Lua callback"
  )

  local before = vim.deepcopy(calls)
  local expected = {}

  for _, method in ipairs(case.methods) do
    expected[method] = true
  end

  mapping.callback()

  for _, method in ipairs(methods) do
    local increment = expected[method] and 1 or 0
    assert(
      calls[method] == before[method] + increment,
      case.lhs .. " 错误调用了 " .. method
    )
  end
end

print("window_test: OK")
