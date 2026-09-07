return {
  {
    "nvim-mini/mini.clue",
    version = false,
    event = "VeryLazy",

    opts = function()
      local clue = require("mini.clue")

      return {
        triggers = {
          { mode = "n", keys = "<Leader>" },
          { mode = "x", keys = "<Leader>" },
          { mode = "n", keys = "g" },
          { mode = "x", keys = "g" },
          { mode = "n", keys = "[" },
          { mode = "n", keys = "]" },
          { mode = "n", keys = '"' },
          { mode = "x", keys = '"' },
          { mode = "i", keys = "<C-x>" },
          { mode = "c", keys = "<C-r>" },
          { mode = "n", keys = "z" },
          { mode = "x", keys = "z" },
        },

        clues = {
          clue.gen_clues.builtin_completion(),
          clue.gen_clues.g(),
          clue.gen_clues.marks(),
          clue.gen_clues.registers(),
          clue.gen_clues.windows(),
          clue.gen_clues.z(),

          { mode = "n", keys = "<Leader>b", desc = "+Buffer" },
          { mode = "n", keys = "<Leader>c", desc = "+Code" },
          { mode = "n", keys = "<Leader>d", desc = "+Diagnostics" },
          { mode = "n", keys = "<Leader>e", desc = "+Explorer" },
          { mode = "n", keys = "<Leader>f", desc = "+Find" },
          { mode = "n", keys = "<Leader>h", desc = "+Git hunk" },
          { mode = "n", keys = "<Leader>q", desc = "+Quit" },
          { mode = "n", keys = "<Leader>s", desc = "+Session" },
          { mode = "n", keys = "<Leader>t", desc = "+Tab/Terminal" },
          { mode = "n", keys = "<Leader>w", desc = "+Window" },
          { mode = "n", keys = "<Leader>x", desc = "+Quickfix" },
        },
        window = {
          delay = 300,
          config = {
            border = "rounded",
          },
        },
      }
    end,
  },
}
