local SearchPort = require("nvi.ports.search")

local valid_adapter = {
  find_files = function() end,
  search_text = function() end,
  search_keymaps = function() end,
  search_commands = function() end,
  search_buffers = function() end,
  search_recent_files = function() end,
  search_help = function() end,
  search_word = function() end,
  find_git_files = function() end,
}

assert(
  SearchPort.validate(valid_adapter) == valid_adapter,
  "有效适配器应该通过验证"
)

local ok, error_message = pcall(function()
  SearchPort.validate({
    find_files = function() end,
  })
end)

assert(not ok, "缺少 search_text 的适配器应该验证失败")

assert(
  error_message:match("search_text"),
  "错误信息应该指出缺少 search_text"
)

local keymaps_ok, keymaps_error = pcall(function()
  SearchPort.validate({
    find_files = function() end,
    search_text = function() end,
  })
end)

assert(not keymaps_ok, "缺少 search_keymaps 的适配器应该验证失败")

assert(
  keymaps_error:match("search_keymaps"),
  "错误信息应该指出缺少 search_keymaps"
)

local commands_ok, commands_error = pcall(function()
  SearchPort.validate({
    find_files = function() end,
    search_text = function() end,
    search_keymaps = function() end,
  })
end)

assert(not commands_ok, "缺少 search_commands 的适配器应该验证失败")

assert(
  commands_error:match("search_commands"),
  "错误信息应该指出缺少 search_commands"
)

local buffers_ok, buffers_error = pcall(function()
  SearchPort.validate({
    find_files = function() end,
    search_text = function() end,
    search_keymaps = function() end,
    search_commands = function() end,
  })
end)

assert(not buffers_ok, "缺少 search_buffers 的适配器应该验证失败")

assert(
  buffers_error:match("search_buffers"),
  "错误信息应该指出缺少 search_buffers"
)

local recent_files_ok, recent_files_error = pcall(function()
  SearchPort.validate({
    find_files = function() end,
    search_text = function() end,
    search_keymaps = function() end,
    search_commands = function() end,
    search_buffers = function() end,
  })
end)

assert(
  not recent_files_ok,
  "缺少 search_recent_files 的适配器应该验证失败"
)

assert(
  recent_files_error:match("search_recent_files"),
  "错误信息应该指出缺少 search_recent_files"
)

local help_ok, help_error = pcall(function()
  SearchPort.validate({
    find_files = function() end,
    search_text = function() end,
    search_keymaps = function() end,
    search_commands = function() end,
    search_buffers = function() end,
    search_recent_files = function() end,
  })
end)

assert(not help_ok, "缺少 search_help 的适配器应该验证失败")

assert(
  help_error:match("search_help"),
  "错误信息应该指出缺少 search_help"
)

local word_ok, word_error = pcall(function()
  SearchPort.validate({
    find_files = function() end,
    search_text = function() end,
    search_keymaps = function() end,
    search_commands = function() end,
    search_buffers = function() end,
    search_recent_files = function() end,
    search_help = function() end,
  })
end)

assert(not word_ok, "缺少 search_word 的适配器应该验证失败")

assert(
  word_error:match("search_word"),
  "错误信息应该指出缺少 search_word"
)

local git_files_ok, git_files_error = pcall(function()
  SearchPort.validate({
    find_files = function() end,
    search_text = function() end,
    search_keymaps = function() end,
    search_commands = function() end,
    search_buffers = function() end,
    search_recent_files = function() end,
    search_help = function() end,
    search_word = function() end,
  })
end)

assert(not git_files_ok, "缺少 find_git_files 的适配器应该验证失败")

assert(
  git_files_error:match("find_git_files"),
  "错误信息应该指出缺少 find_git_files"
)

print("search_port_test: OK")
