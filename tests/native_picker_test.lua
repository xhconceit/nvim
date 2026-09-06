local original = {
  input = vim.fn.input,
  fnameescape = vim.fn.fnameescape,
  escape = vim.fn.escape,
  get_keymap = vim.api.nvim_get_keymap,
  replace_termcodes = vim.api.nvim_replace_termcodes,
  feedkeys = vim.api.nvim_feedkeys,
  select = vim.ui.select,
  cmd = vim.cmd,
  notify = vim.notify,
}

local inputs = {
  "notes/a b.lua",
  "needle",
  "missing",
}

local calls = {
  edit = nil,
  search_commands = {},
  copen = 0,
  notification = nil,
  escape = nil,
  select = nil,
  replaced_keys = nil,
  feedkeys = nil,
}

local fail_vimgrep = false

vim.fn.input = function()
  return table.remove(inputs, 1)
end

vim.fn.fnameescape = function(path)
  return "escaped:" .. path
end

vim.fn.escape = function(text, characters)
  calls.escape = {
    text = text,
    characters = characters,
  }

  return "escaped-" .. text
end

vim.api.nvim_get_keymap = function(mode)
  assert(mode == "n", "应该读取普通模式快捷键")

  return {
    {
      lhs = "<leader>ff",
      desc = "搜索文件",
    },
    {
      lhs = "<F12>",
    },
  }
end

vim.api.nvim_replace_termcodes = function(
  keys,
  from_part,
  do_lt,
  special
)
  calls.replaced_keys = {
    keys = keys,
    from_part = from_part,
    do_lt = do_lt,
    special = special,
  }

  return "encoded:" .. keys
end

vim.api.nvim_feedkeys = function(keys, mode, escape)
  calls.feedkeys = {
    keys = keys,
    mode = mode,
    escape = escape,
  }
end

vim.ui.select = function(items, options, on_choice)
  calls.select = {
    items = items,
    options = options,
  }

  on_choice(items[1])
end

local fake_cmd = {}

function fake_cmd.edit(path)
  calls.edit = path
end

setmetatable(fake_cmd, {
  __call = function(_, command)
    if command:match("^silent vimgrep") then
      table.insert(
        calls.search_commands,
        command
      )

      if fail_vimgrep then
        error("模拟搜索失败")
      end

      return
    end

    if command == "copen" then
      calls.copen = calls.copen + 1
    end
  end,
})

vim.cmd = fake_cmd

vim.notify = function(message, level)
  calls.notification = {
    message = message,
    level = level,
  }
end

local NativePicker =
  require("nvi.adapters.native_picker")

local ok, error_message = xpcall(function()
  NativePicker.find_files()

  assert(
    calls.edit
      == "escaped:notes/a b.lua",
    "find_files 没有转义并打开文件"
  )

  NativePicker.search_text()

  assert(
    #calls.search_commands == 1,
    "search_text 应该执行一次 vimgrep"
  )

  assert(
    calls.search_commands[1]
      == "silent vimgrep /\\Vescaped-needle/gj **/*",
    "search_text 生成了错误的 vimgrep 命令"
  )

  assert(
    calls.escape.text == "needle",
    "search_text 没有转义搜索文本"
  )

  assert(
    calls.escape.characters == [[\/]],
    "search_text 使用了错误的转义字符集合"
  )

  assert(
    calls.copen == 1,
    "搜索成功后应该打开 Quickfix"
  )

  fail_vimgrep = true

  NativePicker.search_text()

  assert(
    #calls.search_commands == 2,
    "失败场景也应该执行 vimgrep"
  )

  assert(
    calls.copen == 1,
    "搜索失败后不应该再次打开 Quickfix"
  )

  assert(
    calls.notification ~= nil,
    "搜索失败后应该显示通知"
  )

  assert(
    calls.notification.message
      == "没有找到：missing",
    "搜索失败通知内容错误"
  )

  assert(
    calls.notification.level
      == vim.log.levels.WARN,
    "搜索失败应该使用 WARN 级别"
  )

  NativePicker.search_keymaps()

  assert(
    calls.select.options.prompt == "搜索快捷键：",
    "原生 Picker 提示文本错误"
  )

  assert(
    #calls.select.items == 1,
    "应该忽略没有 desc 的快捷键"
  )

  assert(
    calls.select.items[1].text
      == "<leader>ff  搜索文件",
    "快捷键条目应该包含按键和描述"
  )

  assert(
    calls.replaced_keys.keys == "<leader>ff",
    "执行前应该转换快捷键编码"
  )

  assert(
    calls.feedkeys.keys == "encoded:<leader>ff"
      and calls.feedkeys.mode == "m"
      and calls.feedkeys.escape == false,
    "选中条目后应该执行对应快捷键"
  )
end, debug.traceback)

vim.fn.input = original.input
vim.fn.fnameescape = original.fnameescape
vim.fn.escape = original.escape
vim.api.nvim_get_keymap = original.get_keymap
vim.api.nvim_replace_termcodes = original.replace_termcodes
vim.api.nvim_feedkeys = original.feedkeys
vim.ui.select = original.select
vim.cmd = original.cmd
vim.notify = original.notify

assert(ok, error_message)

print("native_picker_test: OK")
