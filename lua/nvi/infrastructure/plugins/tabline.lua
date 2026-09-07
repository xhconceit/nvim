return {
  {
    "nvim-mini/mini.tabline",
    version = false,
    event = "VeryLazy",

    opts = {
      show_icons = true,
      tabpage_section = "right",
      format = function(buffer, label)
        local formatted = require("mini.tabline").default_format(buffer, label)
        local modified = vim.bo[buffer].modified and " ●" or ""
        return formatted .. modified
      end,
    },
  },
}
