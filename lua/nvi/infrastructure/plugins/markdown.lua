return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.icons",
    },
    opts = {
      render_modes = {
        "n",
        "c",
      },
      heading = {
        sign = false,
      },
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      completions = {
        lsp = {
          enabled = true,
        },
      },
    },
  },
}
