return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "┃" }, -- 新增或修改
          change = { text = "┃" },
          delete = { text = "▁" },
          topdelete = { text = "▔" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        attach_to_untracked = true,

        current_line_blame = false,
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "right_align",
          delay = 500,
          ignore_whitespace = false,
        },

        current_line_blame_formatter = "  <author>, <author_time:%R> · <summary>",

        preview_config = {
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      })
    end,
  },
}
