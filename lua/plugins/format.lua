return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    keys = {
      {
        "<leader>/",
        function() require("conform").format({ async = true, lsp_fallback = true }) end,
        desc = "格式化",
      },
    },
    config = function() require("plugins.config.conform") end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufNewFile", "BufWritePost" },
    config = function() require("plugins.config.lint") end,
  },
}
