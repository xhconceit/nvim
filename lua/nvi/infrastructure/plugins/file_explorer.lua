return {
  {
    "nvim-mini/mini.files",
    version = false,
    lazy = true,
    config = function()
      require("mini.files").setup({
        options = {
          use_as_default_explorer = false,
        },
      })
    end,
  },
}
