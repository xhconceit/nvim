return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local languages = {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "bash",
        "dart",
        "json",
        "markdown"
      }

      local treesitter = require("nvim-treesitter")
      treesitter.setup({})
      -- 安装语言
      treesitter.install(languages)

      -- 启动语言高亮
      vim.api.nvim_create_autocmd(
        "FileType",
        {
          pattern = languages,
          callback = function()
            vim.treesitter.start()
          end
        }
      )
    end
  }
}
