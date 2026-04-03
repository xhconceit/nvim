return {{
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("lsp.lua_ls")
    end,
},
    {
        "mfussenegger/nvim-jdtls",
        ft = "java",
        config = function()
          require("lsp.jdtls")
        end,
    },
}