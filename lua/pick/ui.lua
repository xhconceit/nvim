return {
  "folke/tokyonight.nvim",
  config = function()
    -- tokyonight
    require("tokyonight").setup({
      style = "storm", -- 风格
      transparent = true, -- 透明
      terminal_colors = true, -- 终端颜色
      styles = {
        comments = { italic = true }, -- 注释样式
        keywords = { italic = true }, -- 关键词样式
        functions = {}, -- 函数样式
      },
      sidebars = { "qf", "help" }, -- 侧边栏
      day_brightness = 0.3, -- 日光亮度
      hide_inactive_statusline = true, -- 隐藏 inactive 状态栏
      dim_inactive = false, -- 不透明度
      lualine_bold = false, -- lualine 粗体
      on_colors = function(colors) -- 颜色
        return colors
      end,
      on_highlights = function(highlights, colors) -- 高亮
        return highlights
      end,
    })
    vim.cmd("colorscheme tokyonight")
  end,
}
