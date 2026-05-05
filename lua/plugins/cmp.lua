return {
  {
    "saghen/blink.cmp",
    version = "*",
    event = "InsertEnter",
    dependencies = {
      "rafamadriz/friendly-snippets", -- 常用代码片段集合（可选）
      "L3MON4D3/LuaSnip",
    },
    config = function() require("plugins.config.blink") end,
  },
}
