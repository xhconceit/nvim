return {
  {
    "nvim-mini/mini.starter",
    version = false,
    event = "VimEnter",
    config = function()
      local starter = require("mini.starter")
      local picker = require("nvi.adapters.mini_pick")

      starter.setup({
        autoopen = true,
        evaluate_single = false,

        header = table.concat({
          "███╗   ██╗██╗   ██╗██╗",
          "████╗  ██║██║   ██║██║",
          "██╔██╗ ██║██║   ██║██║",
          "██║╚██╗██║╚██╗ ██╔╝██║",
          "██║ ╚████║ ╚████╔╝ ██║",
          "╚═╝  ╚═══╝  ╚═══╝  ╚═╝",
        }, "\n"),

        items = {
          {
            name = "查找文件",
            action = picker.find_files,
            section = "操作",
          },
          {
            name = "搜索文本",
            action = picker.search_text,
            section = "操作",
          },
          {
            name = "新建文件",
            action = "enew",
            section = "操作",
          },
          {
            name = "退出 Neovim",
            action = "qa",
            section = "操作",
          },

          starter.sections.recent_files(5, true, false),
        },
        content_hooks = {
          starter.gen_hook.adding_bullet(" "),
          starter.gen_hook.padding(3, 2),
          starter.gen_hook.aligning("center", "center"),
        },

        footer = "保持简单，持续改进。",
      })
    end,
  },
}
