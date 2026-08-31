local M = {}

function M.find_files()
  require("mini.pick").builtin.files()
end

function M.search_text()
  require("mini.pick").builtin.grep_live()
end

return M

