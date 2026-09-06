local Keymap = require("nvi.ui.keymap")

local M = {}

function M.find_files()
  require("mini.pick").builtin.files()
end

function M.search_text()
  require("mini.pick").builtin.grep_live()
end

function M.search_keymaps()
  require("mini.pick").start({
    source = {
      name = "快捷键",
      items = Keymap.list("n"),
      choose = function(item)
        Keymap.execute(item.lhs)
      end,
    },
  })
end

return M
