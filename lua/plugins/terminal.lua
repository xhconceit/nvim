return {
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        keys = {
          { "<leader>tt", "<cmd>ToggleTerm direction=float<cr>",      desc = "浮动终端" },
          { "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "底部终端" },
          { "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>",   desc = "侧边终端" },
          { "<leader>tg", function()
            require("toggleterm.terminal").Terminal:new({
              cmd = "lazygit",
              direction = "float",
              float_opts = { border = "rounded" },
              on_open = function(term)
                vim.cmd("startinsert!")
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<cr>", { noremap = true, silent = true })
              end,
            }):toggle()
          end, desc = "LazyGit" },
        },
        opts = {
          size = function(term)
            if term.direction == "horizontal" then return 15 end
            if term.direction == "vertical" then return vim.o.columns * 0.4 end
          end,
          float_opts = {
            border = "rounded",
            width = function() return math.floor(vim.o.columns * 0.85) end,
            height = function() return math.floor(vim.o.lines * 0.8) end,
          },
          highlights = {
            FloatBorder = { link = "FloatBorder" },
          },
        },
      }
}