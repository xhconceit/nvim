return {
    {
      "stevearc/conform.nvim",
      event = "BufWritePre",
      keys = {
        { "<leader>lf", function() require("conform").format({ async = true, lsp_fallback = true }) end, desc = "格式化" },
      },
      opts = {
        formatters_by_ft = {
          lua = { "stylua" }, -- brew install stylua
          java = { "google-java-format" }, -- brew install google-java-format
          markdown = { "prettier" },
          -- 按需增减
        },
      },
    },
  }