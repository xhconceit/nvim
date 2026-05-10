return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function() require("lsp.lua_ls") end,
  },
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    config = function() require("lsp.jdtls") end,
  },
  {
    "mason-org/mason.nvim",
    cmd = { "Mason", "MasonInstall", "MasonUpdate", "MasonLog" },
    build = ":MasonUpdate",
    config = function() require("plugins.config.mason") end,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    event = "VeryLazy",
    config = function() require("plugins.config.mason-install") end,
  },
}

