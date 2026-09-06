local WindowPort = require("nvi.ports.window")
local Keymap = require("nvi.ui.keymap")

local M = {}

function M.setup(adapter)
  local window = WindowPort.validate(adapter)

  Keymap.nmap("<leader>wa", function()
    window.split_vertical()
    window.focus_left()
  end, "左右分屏，光标留在左边")

  Keymap.nmap(
    "<leader>wd",
    window.split_vertical,
    "左右分屏，光标留在右边"
  )

  Keymap.nmap("<leader>ww", function()
    window.split_horizontal()
    window.focus_up()
  end, "上下分屏，光标留在上方")

  Keymap.nmap(
    "<leader>ws",
    window.split_horizontal,
    "上下分屏，光标留在下方"
  )

  Keymap.nmap("<leader>wq", window.close, "关闭当前窗口")
  Keymap.nmap("<leader>we", window.only, "关闭其他窗口")
  Keymap.nmap("<leader>wt", window.focus_previous, "切换窗口")

  Keymap.nmap("<leader>wh", window.focus_left, "跳转到左侧窗口")
  Keymap.nmap("<leader>wj", window.focus_down, "跳转到下方窗口")
  Keymap.nmap("<leader>wk", window.focus_up, "跳转到上方窗口")
  Keymap.nmap("<leader>wl", window.focus_right, "跳转到右侧窗口")

  Keymap.nmap("<C-h>", window.focus_left, "移动到左侧窗口")
  Keymap.nmap("<C-j>", window.focus_down, "移动到下方窗口")
  Keymap.nmap("<C-k>", window.focus_up, "移动到上方窗口")
  Keymap.nmap("<C-l>", window.focus_right, "移动到右侧窗口")

  Keymap.nmap("<leader>w=", window.equalize, "平均分配窗口")
  Keymap.nmap("<leader>wr", window.swap_next, "交换到下一个窗口")
  Keymap.nmap("<leader>wR", window.swap_previous, "交换到上一个窗口")

  Keymap.nmap(
    "<leader>wmh",
    window.decrease_width,
    "缩小窗口宽度"
  )
  Keymap.nmap(
    "<leader>wml",
    window.increase_width,
    "增加窗口宽度"
  )
  Keymap.nmap(
    "<leader>wmk",
    window.decrease_height,
    "缩小窗口高度"
  )
  Keymap.nmap(
    "<leader>wmj",
    window.increase_height,
    "增加窗口高度"
  )
end

return M
