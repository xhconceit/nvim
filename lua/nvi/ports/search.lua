local M = {}

local required_methods = {
  "find_files",
  "search_text",
  "search_keymaps",
  "search_commands",
  "search_buffers",
  "search_recent_files",
  "search_help",
  "search_word",
  "find_git_files",
}

function M.validate(adapter)
  assert(
    type(adapter) == "table",
    "search adapter 必须是 table"
  )

  for _, method in ipairs(required_methods) do
    assert(
      type(adapter[method]) == "function",
      string.format(
        "search adapter 缺少方法：%s",
        method
      )
    )
  end

  return adapter
end

return M
