return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    version = "1.*",
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
      -- 快捷键
      keymap = {
        preset = "default",
        ["<A-j>"] = { "select_next", "fallback" },
        ["<A-k>"] = { "select_prev", "fallback" },
        ["<A-CR>"] = { "accept", "fallback" },
      },
      cmdline = {
        keymap = {
          preset = "cmdline",
          ["<A-j>"] = { "select_next", "fallback" },
          ["<A-k>"] = { "select_prev", "fallback" },
          ["<A-CR>"] = { "accept", "fallback" },
        },
      },
      -- 提示来源
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
        },
      },
      -- 提示配置
      completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          },
        },
        menu = {
          border = "rounded",
          scrolloff = 2,
          scrollbar = true,

          draw = {
            columns = {
              {
                "label",
                "label_description",
                gap = 1,
              },
              {
                "kind",
                "source_name",
                gap = 1,
              },
            },
          },
        },
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 300,
          window = {
            border = "rounded",
          },
        },
      },
      signature = {
        enabled = true,
      },
      fuzzy = {
        implementation = "lua",
      },
    },
    opts_extend = {
      "sources.default",
    },
  },
}
