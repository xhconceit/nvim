local module_name = "nvi.adapters.native_window"
local original_adapter = package.loaded[module_name]
local original_cmd = vim.cmd

local calls = {
  vsplit = 0,
  split = 0,
  close = 0,
  only = 0,
  wincmd = {},
  resize = {},
  vertical = {},
}

vim.cmd = {
  vsplit = function()
    calls.vsplit = calls.vsplit + 1
  end,
  split = function()
    calls.split = calls.split + 1
  end,
  close = function()
    calls.close = calls.close + 1
  end,
  only = function()
    calls.only = calls.only + 1
  end,
  wincmd = function(direction)
    table.insert(calls.wincmd, direction)
  end,
  resize = function(amount)
    table.insert(calls.resize, amount)
  end,
  vertical = function(command)
    table.insert(calls.vertical, command)
  end,
}

package.loaded[module_name] = nil

local ok, error_message = xpcall(function()
  local NativeWindow = require(module_name)

  NativeWindow.split_vertical()

  assert(
    calls.vsplit == 1,
    "split_vertical 应该执行一次 vsplit"
  )

  NativeWindow.split_horizontal()

  assert(
    calls.split == 1,
    "split_horizontal 应该执行一次 split"
  )

  assert(
    calls.vsplit == 1,
    "水平分屏不应该再次执行 vsplit"
  )

  NativeWindow.close()

  assert(
    calls.close == 1,
    "close 应该执行一次 close 命令"
  )

  NativeWindow.only()

  assert(
    calls.only == 1,
    "only 应该执行一次 only 命令"
  )

  NativeWindow.focus_left()
  NativeWindow.focus_down()
  NativeWindow.focus_up()
  NativeWindow.focus_right()
  NativeWindow.focus_previous()

  assert(
    vim.deep_equal(calls.wincmd, {
      "h",
      "j",
      "k",
      "l",
      "W",
    }),
    "窗口聚焦应该执行对应方向的 wincmd"
  )

  NativeWindow.equalize()

  assert(
    calls.wincmd[6] == "=",
    "equalize 应该执行 wincmd ="
  )

  NativeWindow.swap_next()
  NativeWindow.swap_previous()

  assert(calls.wincmd[7] == "r", "swap_next 应该执行 wincmd r")
  assert(calls.wincmd[8] == "R", "swap_previous 应该执行 wincmd R")

  NativeWindow.increase_height()
  NativeWindow.decrease_height()
  NativeWindow.increase_width()
  NativeWindow.decrease_width()

  assert(
    vim.deep_equal(calls.resize, { "+5", "-5" }),
    "窗口高度应该按 5 行增减"
  )

  assert(
    vim.deep_equal(calls.vertical, {
      "resize +5",
      "resize -5",
    }),
    "窗口宽度应该按 5 列增减"
  )
end, debug.traceback)

vim.cmd = original_cmd
package.loaded[module_name] = original_adapter

assert(ok, error_message)

print("native_window_test: OK")
