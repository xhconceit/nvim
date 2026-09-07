return {
  {
    "echasnovski/mini.pick",
    version = false,
    lazy = true,
    config = function()
      require("mini.pick").setup({
        window = {
          config = {
            border = "rounded",
          },
          prompt_caret = "▏",
          prompt_prefix = "   ",
        },
      })
    end,
  },
}
