return {
  {
    "nvim-mini/mini.statusline",
    version = false,
    event = "VeryLazy",
    config = function()
      require("mini.statusline").setup({
        use_icons = true,
        set_vim_settings = true,
        content = {
          active = nil,
          inactive = nil,
        },
      })
    end,
  },
}
