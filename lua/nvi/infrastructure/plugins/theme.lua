return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      style = "night",
      transparent = false,
      dim_inactive = true,
      on_highlights = function(highlights, colors)
        highlights.WinSeparator = {
          fg = colors.border_highlight,
          bold = true,
        }
      end,
    },
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd.colorscheme("tokyonight")
    end,
  },
}
