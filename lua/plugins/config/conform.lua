require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" }, -- brew install stylua
    java = { "google-java-format" }, -- brew install google-java-format
    markdown = { "prettier" },
    -- 按需增减
  },
})
