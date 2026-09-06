local original_mini_pick =
  package.loaded["mini.pick"]

local original = {
  get_keymap = vim.api.nvim_get_keymap,
  replace_termcodes = vim.api.nvim_replace_termcodes,
  feedkeys = vim.api.nvim_feedkeys,
}

local calls = {
  files = 0,
  grep_live = 0,
  picker_options = nil,
  replaced_keys = nil,
  feedkeys = nil,
}

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
    files = function()
      calls.files = calls.files + 1
    end,

    grep_live = function()
      calls.grep_live =
        calls.grep_live + 1
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

  assert(
    calls.files == 1,
    "find_files 应该调用一次 builtin.files"
  )

  assert(
    calls.grep_live == 1,
    "search_text 应该调用一次 builtin.grep_live"
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
end, debug.traceback)

package.loaded["mini.pick"] =
  original_mini_pick
vim.api.nvim_get_keymap = original.get_keymap
vim.api.nvim_replace_termcodes = original.replace_termcodes
vim.api.nvim_feedkeys = original.feedkeys

assert(ok, error_message)

print("mini_pick_adapter_test: OK")
