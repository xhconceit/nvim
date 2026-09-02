return {
  {
    "nvim-mini/mini.files",
    version = false,
    config = function()
      require("mini.files").setup({
        options = {
          use_as_default_explorer = false
        }
      })
    end
  }
}
