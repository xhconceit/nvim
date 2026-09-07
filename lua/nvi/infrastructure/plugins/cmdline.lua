return {
  {
    "nvim-mini/mini.cmdline",
    version = false,
    event = "VeryLazy",

    opts = {
      -- 输入命令时自动打开模糊补全菜单
      autocomplete = {
        enable = true,
        delay = 80,
        map_arrows = true,
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
