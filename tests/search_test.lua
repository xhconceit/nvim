
local calls = {
  find_files = 0,
  search_text = 0,
  search_keymaps = 0,
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

find_files_mapping.callback()
search_text_mapping.callback()
search_keymaps_mapping.callback()

assert(
  calls.find_files == 1,
  "find_files 应该被调用一次"
)

assert(
  calls.search_text == 1,
  "search_text 应该被调用一次"
)

assert(
  calls.search_keymaps == 1,
  "search_keymaps 应该被调用一次"
)

print("search_test: OK")
