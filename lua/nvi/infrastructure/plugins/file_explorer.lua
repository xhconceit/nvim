return {
  {
    "stevearc/oil.nvim",
    lazy = true,
    dependencies = { "nvim-mini/mini.icons" },
    opts = {
      default_file_explorer = false,
      columns = { "icon" },
      skip_confirm_for_simple_edits = false,
      view_options = { show_hidden = true },
      float = { border = "rounded" },
    },
  },
}
