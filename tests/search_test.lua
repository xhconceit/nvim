local calls = {
  find_files = 0,
  search_text = 0,
  search_keymaps = 0,
  search_commands = 0,
  search_buffers = 0,
  search_recent_files = 0,
  search_help = 0,
  search_word = 0,
  find_git_files = 0,
}

local fake_adapter = {}

function fake_adapter.find_files()
  calls.find_files = calls.find_files + 1
end

function fake_adapter.search_text()
  calls.search_text = calls.search_text + 1
end

function fake_adapter.search_keymaps()
  calls.search_keymaps = calls.search_keymaps + 1
end

function fake_adapter.search_commands()
  calls.search_commands = calls.search_commands + 1
end

function fake_adapter.search_buffers()
  calls.search_buffers = calls.search_buffers + 1
end

function fake_adapter.search_recent_files()
  calls.search_recent_files = calls.search_recent_files + 1
end

function fake_adapter.search_help()
  calls.search_help = calls.search_help + 1
end

function fake_adapter.search_word()
  calls.search_word = calls.search_word + 1
end

function fake_adapter.find_git_files()
  calls.find_git_files = calls.find_git_files + 1
end

require("nvi.features.search").setup(fake_adapter)

local function find_mapping(description)
  for _, mapping in ipairs(vim.api.nvim_get_keymap("n")) do
    if mapping.desc == description then
      return mapping
    end
  end

  error("找不到快捷键：" .. description)
end

local find_files_mapping = find_mapping("搜索文件")
local search_text_mapping = find_mapping("搜索文本")
local search_keymaps_mapping = find_mapping("搜索快捷键")
local search_commands_mapping = find_mapping("搜索命令")
local search_buffers_mapping = find_mapping("搜索 Buffer")
local search_recent_files_mapping = find_mapping("最近文件")
local search_help_mapping = find_mapping("搜索帮助")
local search_word_mapping = find_mapping("搜索当前单词")
local find_git_files_mapping = find_mapping("搜索 Git 文件")

assert(
  type(find_files_mapping.callback) == "function",
  "搜索文件快捷键没有 Lua callback"
)

assert(
  type(search_text_mapping.callback) == "function",
  "搜索文本快捷键没有 Lua callback"
)

assert(
  type(search_keymaps_mapping.callback) == "function",
  "搜索快捷键没有 Lua callback"
)

assert(
  type(search_commands_mapping.callback) == "function",
  "搜索命令没有 Lua callback"
)

assert(
  type(search_buffers_mapping.callback) == "function",
  "搜索 Buffer 没有 Lua callback"
)

assert(
  type(search_recent_files_mapping.callback) == "function",
  "最近文件没有 Lua callback"
)

assert(
  type(search_help_mapping.callback) == "function",
  "搜索帮助没有 Lua callback"
)

assert(
  type(search_word_mapping.callback) == "function",
  "搜索当前单词没有 Lua callback"
)

assert(
  type(find_git_files_mapping.callback) == "function",
  "搜索 Git 文件没有 Lua callback"
)

find_files_mapping.callback()
search_text_mapping.callback()
search_keymaps_mapping.callback()
search_commands_mapping.callback()
search_buffers_mapping.callback()
search_recent_files_mapping.callback()
search_help_mapping.callback()
search_word_mapping.callback()
find_git_files_mapping.callback()

assert(calls.find_files == 1, "find_files 应该被调用一次")

assert(calls.search_text == 1, "search_text 应该被调用一次")

assert(calls.search_keymaps == 1, "search_keymaps 应该被调用一次")

assert(calls.search_commands == 1, "search_commands 应该被调用一次")

assert(calls.search_buffers == 1, "search_buffers 应该被调用一次")

assert(
  calls.search_recent_files == 1,
  "search_recent_files 应该被调用一次"
)

assert(calls.search_help == 1, "search_help 应该被调用一次")

assert(calls.search_word == 1, "search_word 应该被调用一次")

assert(calls.find_git_files == 1, "find_git_files 应该被调用一次")

print("search_test: OK")
