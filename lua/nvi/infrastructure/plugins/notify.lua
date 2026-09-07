return {
  {
    "nvim-mini/mini.notify",
    version = false,
    event = "VeryLazy",

    config = function()
      local notify = require("mini.notify")

      notify.setup({
        lsp_progress = {
          enable = true,
          level = "INFO",
          duration_last = 1500,
        },

        window = {
          config = {
            border = "rounded",
          },
          max_width_share = 0.35,
          winblend = 0,
        },
      })

      vim.notify = notify.make_notify({
        ERROR = {
          duration = 7000,
          hl_group = "DiagnosticError",
        },
        WARN = {
          duration = 5000,
          hl_group = "DiagnosticWarn",
        },
        INFO = {
          duration = 3000,
          hl_group = "DiagnosticInfo",
        },
      })
    end,
  },
}
