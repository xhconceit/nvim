return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = {
        char = "┊", -- 显示普通缩进层级
        tab_char = "|",
      },
      -- Treesitter 标出光标所在的代码作用域
      scope = {
        enabled = true,
        char = "|",
        show_start = false,
        show_end = false,
      },
      exclude = {
        filetypes = {
          "help",
          "lazy",
          "mason",
          "dashboard",
        },
        buftypes = {
          "terminal",
          "nofile",
          "quickfix",
          "prompt",
        },
      },
    },
  },
}
