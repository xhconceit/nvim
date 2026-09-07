return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    version = "1.*",
    opts = {
      -- 快捷键
      keymap = {
        preset = "default",
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
