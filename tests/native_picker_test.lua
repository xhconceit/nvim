local module_name = "nvi.adapters.native_picker"
local original_adapter = package.loaded[module_name]
local original_command = package.loaded["nvi.ui.command"]
local original_project = package.loaded["nvi.core.project"]
local original_recent_file = package.loaded["nvi.ui.recent_file"]

local command_items = {
  {
    name = "NviConfig",
    desc = "打开 NVI 配置入口",
    text = "NviConfig  打开 NVI 配置入口",
  },
}

local recent_file_items = {
  {
    path = "/projects/demo/init.lua",
    text = "/projects/demo/init.lua",
  },
}

local original = {
  system = vim.system,
  input = vim.fn.input,
  expand = vim.fn.expand,
  fnameescape = vim.fn.fnameescape,
  escape = vim.fn.escape,
  getbufinfo = vim.fn.getbufinfo,
  get_keymap = vim.api.nvim_get_keymap,
  set_current_buf = vim.api.nvim_set_current_buf,
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
  "lua-guide",
}

local calls = {
  edit = nil,
  search_commands = {},
  copen = 0,
  notification = nil,
  escape = nil,
  select = nil,
  select_count = 0,
  replaced_keys = nil,
  feedkeys = nil,
  command_list = 0,
  executed_command = nil,
  project_root = 0,
  inputs = {},
  buffer_query = nil,
  current_buffer = nil,
  recent_file_list = 0,
  opened_recent_file = nil,
  help = nil,
  system = nil,
  system_wait = 0,
}

local buffer_items = {
  {
    bufnr = 3,
    name = "/projects/demo/init.lua",
  },
  {
    bufnr = 8,
    name = "",
  },
}

package.loaded["nvi.ui.command"] = {
  list = function()
    calls.command_list = calls.command_list + 1
    return command_items
  end,

  execute = function(name)
    calls.executed_command = name
  end,
}

package.loaded["nvi.core.project"] = {
  root = function()
    calls.project_root = calls.project_root + 1
    return "/projects/demo"
  end,
}

package.loaded["nvi.ui.recent_file"] = {
  list = function()
    calls.recent_file_list = calls.recent_file_list + 1
    return recent_file_items
  end,

  open = function(path)
    calls.opened_recent_file = path
  end,
}

package.loaded[module_name] = nil

local fail_vimgrep = false
local git_result = {
  code = 0,
  stdout = "lua/nvi/init.lua\nREADME.md\n",
  stderr = "",
}

vim.fn.input = function(prompt, default, completion)
  table.insert(calls.inputs, {
    prompt = prompt,
    default = default,
    completion = completion,
  })

  return table.remove(inputs, 1)
end

vim.fn.expand = function(expression)
  assert(expression == "<cword>", "应该读取光标下的单词")
  return "search_word"
end

vim.system = function(command, options)
  calls.system = {
    command = command,
    options = options,
  }

  return {
    wait = function()
      calls.system_wait = calls.system_wait + 1
      return git_result
    end,
  }
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

vim.fn.getbufinfo = function(query)
  calls.buffer_query = query
  return buffer_items
end

vim.api.nvim_set_current_buf = function(bufnr)
  calls.current_buffer = bufnr
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

vim.api.nvim_replace_termcodes = function(keys, from_part, do_lt, special)
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
  calls.select_count = calls.select_count + 1
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

function fake_cmd.help(topic)
  calls.help = topic
end

setmetatable(fake_cmd, {
  __call = function(_, command)
    if command:match("^silent vimgrep") then
      table.insert(calls.search_commands, command)

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

local NativePicker = require("nvi.adapters.native_picker")

local ok, error_message = xpcall(function()
  NativePicker.find_files()

  assert(
    calls.edit == "escaped:notes/a b.lua",
    "find_files 没有转义并打开文件"
  )

  assert(
    vim.deep_equal(calls.inputs[1], {
      prompt = "打开文件：",
      default = "/projects/demo/",
      completion = "file",
    }),
    "文件输入应该默认从项目根目录开始"
  )

  NativePicker.search_text()

  assert(#calls.search_commands == 1, "search_text 应该执行一次 vimgrep")

  assert(
    calls.search_commands[1]
      == "silent vimgrep /\\Vescaped-needle/gj "
        .. "escaped:/projects/demo/**/*",
    "search_text 生成了错误的 vimgrep 命令"
  )

  assert(calls.escape.text == "needle", "search_text 没有转义搜索文本")

  assert(
    calls.escape.characters == [[\/]],
    "search_text 使用了错误的转义字符集合"
  )

  assert(calls.copen == 1, "搜索成功后应该打开 Quickfix")

  fail_vimgrep = true

  NativePicker.search_text()

  assert(#calls.search_commands == 2, "失败场景也应该执行 vimgrep")

  assert(calls.copen == 1, "搜索失败后不应该再次打开 Quickfix")

  assert(calls.notification ~= nil, "搜索失败后应该显示通知")

  assert(
    calls.notification.message == "没有找到：missing",
    "搜索失败通知内容错误"
  )

  assert(
    calls.notification.level == vim.log.levels.WARN,
    "搜索失败应该使用 WARN 级别"
  )

  assert(
    calls.project_root == 3,
    "文件与文本搜索都应该解析项目根目录"
  )

  NativePicker.search_keymaps()

  assert(
    calls.select.options.prompt == "搜索快捷键：",
    "原生 Picker 提示文本错误"
  )

  assert(#calls.select.items == 1, "应该忽略没有 desc 的快捷键")

  assert(
    calls.select.items[1].text == "<leader>ff  搜索文件",
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

  NativePicker.search_commands()

  assert(
    calls.select.options.prompt == "搜索命令：",
    "原生命令 Picker 提示文本错误"
  )

  assert(
    calls.select.items == command_items,
    "原生命令 Picker 应该使用命令列表"
  )

  assert(calls.command_list == 1, "应该读取一次命令列表")
  assert(
    calls.executed_command == "NviConfig",
    "选中条目后应该执行对应命令"
  )

  NativePicker.search_buffers()

  assert(
    vim.deep_equal(calls.buffer_query, { buflisted = 1 }),
    "应该只读取已列入列表的 Buffer"
  )

  assert(
    calls.select.options.prompt == "搜索 Buffer：",
    "原生 Buffer Picker 提示文本错误"
  )

  assert(
    calls.select.items == buffer_items,
    "原生 Buffer Picker 应该使用 Buffer 列表"
  )

  assert(
    calls.select.options.format_item(buffer_items[1])
      == "3  /projects/demo/init.lua",
    "Buffer 条目应该包含编号和名称"
  )

  assert(
    calls.select.options.format_item(buffer_items[2]) == "8  [No Name]",
    "未命名 Buffer 应该显示占位名称"
  )

  assert(
    calls.current_buffer == 3,
    "选中条目后应该切换到对应 Buffer"
  )

  NativePicker.search_recent_files()

  assert(
    calls.select.options.prompt == "最近文件：",
    "原生最近文件 Picker 提示文本错误"
  )

  assert(
    calls.select.items == recent_file_items,
    "原生 Picker 应该使用最近文件列表"
  )

  assert(
    calls.select.options.format_item(recent_file_items[1])
      == "/projects/demo/init.lua",
    "原生 Picker 应该显示最近文件文本"
  )

  assert(calls.recent_file_list == 1, "应该读取一次最近文件列表")

  assert(
    calls.opened_recent_file == "/projects/demo/init.lua",
    "选中条目后应该打开对应最近文件"
  )

  NativePicker.search_help()

  assert(
    vim.deep_equal(calls.inputs[4], {
      prompt = "搜索帮助：",
      default = "",
      completion = "help",
    }),
    "帮助输入应该启用原生 help 补全"
  )

  assert(calls.help == "lua-guide", "应该打开输入的帮助标签")

  fail_vimgrep = false
  NativePicker.search_word()

  assert(
    #calls.search_commands == 3,
    "当前单词搜索应该执行一次 vimgrep"
  )

  assert(
    calls.search_commands[3]
      == "silent vimgrep /\\Vescaped-search_word/gj "
        .. "escaped:/projects/demo/**/*",
    "当前单词搜索生成了错误的 vimgrep 命令"
  )

  assert(calls.copen == 2, "当前单词搜索成功后应该打开 Quickfix")

  assert(
    calls.project_root == 4,
    "当前单词搜索应该解析项目根目录"
  )

  NativePicker.find_git_files()

  assert(
    vim.deep_equal(calls.system.command, {
      "git",
      "-C",
      "/projects/demo",
      "ls-files",
    }),
    "Git 文件搜索使用了错误的命令"
  )

  assert(
    calls.system.options.text == true,
    "Git 命令应该返回文本输出"
  )

  assert(calls.system_wait == 1, "应该等待 Git 文件列表")

  assert(
    vim.deep_equal(calls.select.items, {
      "lua/nvi/init.lua",
      "README.md",
    }),
    "应该把 Git 输出转换为文件列表"
  )

  assert(
    calls.select.options.prompt == "搜索 Git 文件：",
    "原生 Git 文件 Picker 提示文本错误"
  )

  assert(
    calls.edit == "escaped:/projects/demo/lua/nvi/init.lua",
    "选中后应该打开项目中的 Git 文件"
  )

  assert(calls.project_root == 5, "Git 文件搜索应该解析项目根目录")

  local select_count_before_failure = calls.select_count
  local edit_before_failure = calls.edit

  git_result = {
    code = 128,
    stdout = "",
    stderr = "不是 Git 仓库",
  }

  NativePicker.find_git_files()

  assert(
    calls.notification.message == "无法读取 Git 文件",
    "Git 命令失败后应该显示通知"
  )

  assert(
    calls.notification.level == vim.log.levels.WARN,
    "Git 命令失败应该使用 WARN 级别"
  )

  assert(
    calls.select_count == select_count_before_failure,
    "Git 命令失败后不应该打开 Picker"
  )

  assert(
    calls.edit == edit_before_failure,
    "Git 命令失败后不应该打开文件"
  )
end, debug.traceback)

vim.system = original.system
vim.fn.input = original.input
vim.fn.expand = original.expand
vim.fn.fnameescape = original.fnameescape
vim.fn.escape = original.escape
vim.fn.getbufinfo = original.getbufinfo
vim.api.nvim_get_keymap = original.get_keymap
vim.api.nvim_set_current_buf = original.set_current_buf
vim.api.nvim_replace_termcodes = original.replace_termcodes
vim.api.nvim_feedkeys = original.feedkeys
vim.ui.select = original.select
vim.cmd = original.cmd
vim.notify = original.notify
package.loaded["nvi.ui.command"] = original_command
package.loaded["nvi.core.project"] = original_project
package.loaded["nvi.ui.recent_file"] = original_recent_file
package.loaded[module_name] = original_adapter

assert(ok, error_message)

print("native_picker_test: OK")
