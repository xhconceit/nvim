return {
  {
    "nvim-mini/mini.cursorword",
    version = false,
    event = { "BufReadPost", "BufNewFile" },

    opts = {
      delay = 200,
    },

    config = function(_, opts)
      require("mini.cursorword").setup(opts)

      vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", {})
    end,
  },
}
