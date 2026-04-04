return {
    {
      "saghen/blink.cmp",
      version = "*",
      event = "InsertEnter",
      dependencies = {
        "rafamadriz/friendly-snippets", -- 常用代码片段集合（可选）
      },
      opts = {
        keymap = {
          preset = "enter", -- 默认的快捷键
          ["<C-j>"] = { "select_next", "fallback" }, -- 向下选择
          ["<C-k>"] = { "select_prev", "fallback" }, -- 向上选择
          ["<C-d>"] = { "scroll_documentation_down" }, -- 向下滚动文档
          ["<C-u>"] = { "scroll_documentation_up" }, -- 向上滚动文档
          ["<Tab>"] = { "snippet_forward", "fallback" }, -- 向前选择
          ["<S-Tab>"] = { "snippet_backward", "fallback" }, -- 向后选择
        },
        -- 补全
        completion = { 
          list = { 
            selection = { 
                preselect = true,-- 自动插入
                auto_insert = false -- 自动插入
            }, 
          },
          menu = {
            border = "rounded", -- 边框
            draw = { -- 绘制
              columns = { -- 列
                { "kind_icon" }, -- 图标
                { "label", "label_description", gap = 1 }, -- 标签和描述
                { "kind" }, -- 类型
              },
            },
          },
          documentation = {
            auto_show = true, -- 自动显示
            auto_show_delay_ms = 200, -- 自动显示延迟
            window = { border = "rounded" }, -- 边框
          },
        },
        -- 源
        sources = {
          default = { "lsp", "path", "snippets", "buffer" },
        },
        -- 外观
        appearance = {
          nerd_font_variant = "mono", -- 字体变体
        },
      },
    },
  }