return {
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns")
          .setup({
            signcolumn         = true,
            numhl              = false,
            current_line_blame = false
          })
    end
  }
}
