return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets"
    },
    version = "1.*",
    opts = {
      keymap = {
        preset = "default",
      },
      sources = {
        default = {
          "lsp",
          "path",
          "snippets",
          "buffer",
        }
      },
      -- 提示配置
      completion = {
        list = {
          selection = {
            preselect = false,
            auto_insert = false,
          }
        },
        menu = {
          draw = {
            columns = {
              {
                "label",
                "label_description",
                gap = 1
              },
              {
                "kind",
                "source_name",
                gap = 1
              }
            }
          }
        },
        documentation = {
          auto_show = true
        },
      },
      signature = {
        enabled = true
      },
      fuzzy = {
        implementation = "lua"
      }
    },
    opts_extend = {
      "sources.default"
    }
  }
}
