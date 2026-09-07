return {
  {
    "nvim-mini/mini.trailspace",
    version = false,
    event = { "BufReadPost", "BufNewFile" },

    opts = {
      only_in_normal_buffers = true,
    },

    keys = {
      {
        "<leader>cw",
        function()
          local trailspace = require("mini.trailspace")

          trailspace.trim()
          trailspace.trim_last_lines()
        end,
        desc = "清理行尾空白",
      },
    },
  },
}
