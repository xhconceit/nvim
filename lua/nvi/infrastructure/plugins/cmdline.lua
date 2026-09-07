return {
  {
    "nvim-mini/mini.cmdline",
    version = false,
    event = "VeryLazy",

    opts = {
      -- 命令行补全由 blink.cmp 负责
      autocomplete = {
        enable = false,
      },

      -- 自动修正不存在但非常接近的命令或选项
      autocorrect = {
        enable = true,
      },

      --- 命令包含行范围时，用浮窗预览即将处理的内容
      autopeek = {
        enable = true,
        n_context = 2,

        window = {
          config = {
            border = "rounded",
          },
        },
      },
    },
  },
}
