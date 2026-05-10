local pick = require("mini.pick")

pick.setup({
  mappings = {
    move_down = "<A-j>",
    move_up = "<A-k>",
  },
  window = {
    config = function()
      local height = math.floor(0.6 * vim.o.lines)
      local width = math.floor(0.6 * vim.o.columns)
      return {
        anchor = "NW",
        height = height,
        width = width,
        row = math.floor(0.2 * vim.o.lines),
        col = math.floor(0.2 * vim.o.columns),
        border = "rounded",
      }
    end,
  },
})
