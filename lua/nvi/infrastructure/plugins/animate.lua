return {
  {
    "nvim-mini/mini.animate",
    version = false,
    event = "VeryLazy",
    config = function()
      local animate = require("mini.animate")
      animate.setup({
        cursor = {
          enable = false,
        },

        scroll = {
          enable = true,
          timing = animate.gen_timing.linear({
            duration = 120,
            unit = "total",
          }),
          subscroll = animate.gen_subscroll.equal({
            max_output_steps = 20,
          }),
        },

        resize = {
          enable = false,
        },

        open = {
          enable = false,
        },

        close = {
          enable = false,
        },
      })
    end,
  },
}
