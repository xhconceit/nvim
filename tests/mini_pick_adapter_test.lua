local original_mini_pick =
  package.loaded["mini.pick"]
local module_name = "nvi.adapters.mini_pick"
local original_adapter = package.loaded[module_name]
local original_command = package.loaded["nvi.ui.command"]
local original_project = package.loaded["nvi.core.project"]
local original_recent_file =
  package.loaded["nvi.ui.recent_file"]

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
  expand = vim.fn.expand,
  get_keymap = vim.api.nvim_get_keymap,
  replace_termcodes = vim.api.nvim_replace_termcodes,
  feedkeys = vim.api.nvim_feedkeys,
}

local calls = {
  files = 0,
  grep_live = 0,
  buffers = 0,
  help = 0,
  grep = 0,
  picker_options = nil,
  replaced_keys = nil,
  feedkeys = nil,
  command_list = 0,
  executed_command = nil,
  project_root = 0,
  files_options = nil,
  git_files_local_options = nil,
  git_files_options = nil,
  grep_options = nil,
  recent_file_list = 0,
  opened_recent_file = nil,
  word_pattern = nil,
  word_options = nil,
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

vim.fn.expand = function(expression)
  assert(
    expression == "<cword>",
    "应该读取光标下的单词"
  )
  return "search_word"
end

vim.api.nvim_get_keymap = function(mode)
  assert(mode == "n", "应该读取普通模式快捷键")

  return {
    {
      lhs = "<leader>ff",
      desc = "搜索文件",
    },
    {
      lhs = "<leader>fg",
      desc = "搜索文本",
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

package.loaded["mini.pick"] = {
  builtin = {
    files = function(local_options, options)
      calls.files = calls.files + 1

      if calls.files == 1 then
        calls.files_options = options
      else
        calls.git_files_local_options = local_options
        calls.git_files_options = options
      end
    end,

    grep_live = function(_, options)
      calls.grep_live =
        calls.grep_live + 1
      calls.grep_options = options
    end,

    buffers = function()
      calls.buffers = calls.buffers + 1
    end,

    help = function()
      calls.help = calls.help + 1
    end,

    grep = function(local_options, options)
      calls.grep = calls.grep + 1
      calls.word_pattern = local_options.pattern
      calls.word_options = options
    end,
  },

  start = function(options)
    calls.picker_options = options
  end,
}

local MiniPickAdapter =
  require("nvi.adapters.mini_pick")

local ok, error_message = xpcall(function()
  MiniPickAdapter.find_files()
  MiniPickAdapter.search_text()
  MiniPickAdapter.search_keymaps()
  MiniPickAdapter.search_buffers()
  MiniPickAdapter.search_help()
  MiniPickAdapter.search_word()
  MiniPickAdapter.find_git_files()

  assert(
    calls.files == 2,
    "两种文件搜索都应该调用 builtin.files"
  )

  assert(
    calls.grep_live == 1,
    "search_text 应该调用一次 builtin.grep_live"
  )

  assert(
    calls.buffers == 1,
    "search_buffers 应该调用一次 builtin.buffers"
  )

  assert(
    calls.help == 1,
    "search_help 应该调用一次 builtin.help"
  )

  assert(
    calls.grep == 1,
    "search_word 应该调用一次 builtin.grep"
  )

  assert(
    calls.word_pattern == "search_word",
    "search_word 应该使用光标下的单词"
  )

  assert(
    calls.word_options.source.cwd == "/projects/demo",
    "当前单词搜索应该使用项目根目录"
  )

  assert(
    calls.git_files_local_options.tool == "git",
    "Git 文件搜索应该使用 git 工具"
  )

  assert(
    calls.git_files_options.source.cwd == "/projects/demo",
    "Git 文件搜索应该使用项目根目录"
  )

  assert(
    calls.files_options.source.cwd == "/projects/demo",
    "文件搜索应该使用项目根目录"
  )

  assert(
    calls.grep_options.source.cwd == "/projects/demo",
    "文本搜索应该使用项目根目录"
  )

  assert(
    calls.project_root == 4,
    "四种项目搜索都应该解析项目根目录"
  )

  local source = calls.picker_options.source

  assert(
    source.name == "快捷键",
    "快捷键 Picker 名称错误"
  )

  assert(
    #source.items == 2,
    "应该忽略没有 desc 的快捷键"
  )

  assert(
    source.items[1].text
      == "<leader>ff  搜索文件",
    "快捷键条目应该包含按键和描述"
  )

  source.choose(source.items[1])

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

  MiniPickAdapter.search_commands()

  source = calls.picker_options.source

  assert(source.name == "命令", "命令 Picker 名称错误")
  assert(source.items == command_items, "应该使用命令列表")

  source.choose(source.items[1])

  assert(calls.command_list == 1, "应该读取一次命令列表")
  assert(
    calls.executed_command == "NviConfig",
    "选中条目后应该执行对应命令"
  )

  MiniPickAdapter.search_recent_files()

  source = calls.picker_options.source

  assert(
    source.name == "最近文件",
    "最近文件 Picker 名称错误"
  )

  assert(
    source.items == recent_file_items,
    "最近文件 Picker 应该使用最近文件列表"
  )

  source.choose(source.items[1])

  assert(
    calls.recent_file_list == 1,
    "应该读取一次最近文件列表"
  )

  assert(
    calls.opened_recent_file == "/projects/demo/init.lua",
    "选中条目后应该打开对应文件"
  )
end, debug.traceback)

package.loaded["mini.pick"] =
  original_mini_pick
package.loaded["nvi.ui.command"] = original_command
package.loaded["nvi.core.project"] = original_project
package.loaded["nvi.ui.recent_file"] = original_recent_file
package.loaded[module_name] = original_adapter
vim.fn.expand = original.expand
vim.api.nvim_get_keymap = original.get_keymap
vim.api.nvim_replace_termcodes = original.replace_termcodes
vim.api.nvim_feedkeys = original.feedkeys

assert(ok, error_message)

print("mini_pick_adapter_test: OK")
