return {
    {
        "folke/tokyonight.nvim",
        lazy = false,    -- 立即加载
        priority = 1000, -- 优先级
        config = function()
            -- tokyonight
            require('tokyonight').setup({
                style = "night",                  -- 风格
                transparent = true,               -- 透明
                terminal_colors = true,           -- 终端颜色
                styles = {
                    comments = { italic = true }, -- 注释样式
                    keywords = { italic = true }, -- 关键词样式
                    functions = {},               -- 函数样式
                },
                sidebars = { "qf", "help" },      -- 侧边栏
                day_brightness = 0.3,             -- 日光亮度
                hide_inactive_statusline = true,  -- 隐藏 inactive 状态栏
                dim_inactive = false,             -- 不透明度
                lualine_bold = false,             -- lualine 粗体
                on_colors = function(colors)      -- 颜色
                    return colors
                end,
                on_highlights = function(highlights, colors) -- 高亮
                    return highlights
                end,
            })
            vim.cmd("colorscheme tokyonight")
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        event = "BufReadPost",
        priority = 1000, -- 优先级
        config = function()
            local highlight = {
                "RainbowRed",
                "RainbowYellow",
                "RainbowBlue",
                "RainbowOrange",
                "RainbowGreen",
                "RainbowViolet",
                "RainbowCyan",
            }
        
            local hooks = require("ibl.hooks")
            hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
                vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
                vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
                vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
                vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
                vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
                vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
                vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
            end)
        
            require("ibl").setup({
                indent = {
                    char = "│",
                    highlight = highlight,  -- 每一级缩进用不同颜色
                },
                scope = {
                    enabled = true,
                    show_start = false,
                    show_end = false,
                },
            })
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        config = function()
            require("lualine").setup({
                options = {
                    theme = "tokyonight",
                    component_separators = { left = "", right = "" },
                    section_separators = { left = "", right = "" },
                    globalstatus = true, -- 全局状态栏（只有一个）
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {},
                },
            })
        end,
    }
}
