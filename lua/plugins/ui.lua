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
                    highlight = highlight, -- 每一级缩进用不同颜色
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
    },
    {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("noice").setup({
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                },
                presets = {
                    bottom_search = true,         -- 搜索框在底部
                    command_palette = true,       -- 命令行变成弹窗
                    long_message_to_split = true, -- 长消息自动分屏显示
                    inc_rename = false,           -- 如果用 inc-rename.nvim 设为 true
                    lsp_doc_border = true,        -- LSP 文档加边框
                },
                -- 可选：过滤掉一些烦人的消息
                routes = {
                    {
                        filter = {
                            event = "msg_show",
                            kind = "",
                            find = "written",
                        },
                        opts = { skip = true }, -- 隐藏 "xxx written" 消息
                    },
                },
            })
            -- nvim-notify 的配置
            require("notify").setup({
                background_colour = "#000000", -- 透明主题必须设置
                timeout = 3000,
                max_width = 60,
            })
        end
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "BufReadPost",
        opts = {
            options = {
                mode = "buffers", -- 显示 buffer（也可以设为 "tabs" 显示标签页）
                themable = true, -- 允许主题自定义高亮
                numbers = "ordinal", -- 不显示编号，可选 "ordinal" | "buffer_id" | "both"
                close_command = "bdelete! %d", -- 关闭 buffer 的命令
                right_mouse_command = "bdelete! %d", -- 右键关闭
                indicator = {
                    icon = "▎", -- 当前 buffer 指示器图标
                    style = "underline", -- 指示器样式：icon | underline | none
                },
                buffer_close_icon = "󰅖", -- 关闭 buffer 的图标
                modified_icon = "● ", -- 修改过的 buffer 图标
                close_icon = " ", -- 关闭 buffer 的图标
                left_trunc_marker = " ", -- 左截断标记
                right_trunc_marker = " ", -- 右截断标记
                max_name_length = 18, -- 最大文件名长度
                max_prefix_length = 15, -- 最大前缀长度
                truncate_names = true, -- 截断文件名
                tab_size = 18, -- 标签页大小
                diagnostics = "nvim_lsp", -- 显示 LSP 诊断信息
                diagnostics_update_on_event = true, -- 诊断信息更新事件
                offsets = {
                    {
                        filetype = "NvimTree",
                        text = "File Explorer",
                        text_align = "center",
                        highlight = "Directory",
                        separator = true,
                    },
                    {
                        filetype = "neo-tree",
                        text = "File Explorer",
                        text_align = "center",
                        highlight = "Directory",
                        separator = true,
                    },
                },
                color_icons = true,               -- 显示颜色图标
                show_buffer_icons = true,         -- 显示 buffer 图标
                show_buffer_close_icons = true,   -- 显示关闭 buffer 图标
                show_close_icon = false,          -- 显示关闭图标
                show_tab_indicators = true,       -- 显示标签页指示器
                show_duplicate_prefix = true,     -- 显示重复前缀
                separator_style = "thin",         -- 分隔符样式："slant" | "slope" | "thick" | "thin" | { "▏", "▕" }
                always_show_bufferline = true,    -- 总是显示 bufferline
                hover = {
                    enabled = true,               -- 启用悬浮提示
                    delay = 200,                  -- 延迟时间
                    reveal = { "close" },         -- 显示关闭按钮
                },
                sort_by = "insert_after_current", -- 新 buffer 插入到当前之后
            },
        },
        keys = {
            { "<leader>bj", "<cmd>BufferLineCycleNext<cr>", desc = "下一个 buffer" },
            { "<leader>bk", "<cmd>BufferLineCyclePrev<cr>", desc = "上一个 buffer" },
            { "<leader>b>", "<cmd>BufferLineMoveNext<cr>", desc = "将 buffer 向右移动" },
            { "<leader>b<", "<cmd>BufferLineMovePrev<cr>", desc = "将 buffer 向左移动" },
            { "<leader>bp", "<cmd>BufferLineTogglePin<cr>", desc = "固定/取消固定 buffer" },
            { "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "关闭其他 buffer" },
            { "<leader>bl", "<cmd>BufferLineCloseRight<cr>", desc = "关闭右侧所有 buffer" },
            { "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", desc = "关闭左侧所有 buffer" },
            { "<leader>bs", "<cmd>BufferLinePick<cr>", desc = "选择 buffer" },
            { "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "跳转到 buffer 1" },
            { "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "跳转到 buffer 2" },
            { "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "跳转到 buffer 3" },
            { "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "跳转到 buffer 4" },
            { "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "跳转到 buffer 5" },
        },
    },
    {
        "rrethy/vim-illuminate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("illuminate").configure({
                providers = {
                    "lsp",
                    "treesitter",
                    "regex",
                },
                delay = 200,
                large_file_cutoff = 2000,
                large_file_overrides = {
                    providers = { "lsp" },
                },
                filetypes_denylist = {
                    "dirbuf",
                    "dirvish",
                    "fugitive",
                    "NvimTree",
                    "neo-tree",
                    "lazy",
                    "mason",
                    "TelescopePrompt",
                },
            })
    
            -- 自定义高亮颜色（可选，配合 tokyonight 透明主题）
            vim.api.nvim_set_hl(0, "IlluminatedWordText", { bg = "#3b4261" })
            vim.api.nvim_set_hl(0, "IlluminatedWordRead", { bg = "#3b4261" })
            vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { bg = "#3b4261" })
        end,
        keys = {
            { "]]", function() require("illuminate").goto_next_reference(false) end, desc = "下一个引用" },
            { "[[", function() require("illuminate").goto_prev_reference(false) end, desc = "上一个引用" },
        },
    },
    {
        "echasnovski/mini.animate",
        version = false,
        event = "VeryLazy",
        config = function()
            local animate = require("mini.animate")
    
            animate.setup({
                -- 光标移动动画
                cursor = {
                    enable = true,
                    timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
                },
                -- 滚动动画
                scroll = {
                    enable = true,
                    timing = animate.gen_timing.linear({ duration = 150, unit = "total" }),
                },
                -- 窗口大小变化动画
                resize = {
                    enable = true,
                    timing = animate.gen_timing.linear({ duration = 100, unit = "total" }),
                },
                -- 窗口打开动画
                open = { enable = true },
                -- 窗口关闭动画
                close = { enable = true },
            })
        end,
    },
    
}
