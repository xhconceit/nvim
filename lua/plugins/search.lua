return {
  {
    -- brew install ripgrep fd
    "echasnovski/mini.pick",
    version = "*",
    keys = {
      {
        "<leader>ff",
        function() require("mini.pick").builtin.files() end,
        desc = "搜索文件",
      },
      {
        "<leader>fg",
        function() require("mini.pick").builtin.grep_live() end,
        desc = "搜索内容",
      },
      {
        "<leader>fw",
        function() require("mini.pick").builtin.grep({ pattern = vim.fn.expand("<cword>") }) end,
        desc = "搜索光标词",
      },
      {
        "<leader>fb",
        function() require("mini.pick").builtin.buffers() end,
        desc = "搜索 Buffer",
      },
      {
        "<leader>fh",
        function() require("mini.pick").builtin.help() end,
        desc = "搜索帮助",
      },
      {
        "<leader>fr",
        function() require("mini.pick").builtin.resume() end,
        desc = "恢复上次搜索",
      },
    },
    opts = {
      mappings = {
        move_down = "<C-j>",
        move_up = "<C-k>",
      },
      window = {
        config = function()
          local height = math.floor(0.6 * vim.o.lines)
          local width = math.floor(0.6 * vim.o.columns)
          return {
            anchor = "NW",
            height = height,
            width = width,
            row = math.floor(0.2 * vim.o.lines),
            col = math.floor(0.2 * vim.o.columns),
            border = "rounded",
          }
        end,
      },
    },
  },
}

