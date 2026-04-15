vim.pack.add({
  {
    src = "https://github.com/xhconceit/pick.nvim",
  },
})

require("pick").setup({
  plugins = {
    {
      import = "pick",
    },
  },
})
