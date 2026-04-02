return {

    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            ---@type false | "classic" | "modern" | "helix"
            preset = "helix", -- 预设布局，helix 风格比较紧凑美观
            delay = 300,      -- 按键后多少毫秒弹出面板（默认 200）
            icons = {
                breadcrumb = "»",
                separator = "➜",
                group = "+",
                mappings = true, -- 自动根据 desc 匹配图标
                rules = {},
                colors = true,
            },
            win = {
                border = "rounded", -- 边框样式
                padding = { 1, 2 }, -- 内边距
                title = true,
                title_pos = "center",
                wo = {
                    winblend = 10, -- 透明度，配合你的透明主题
                },
            },
            layout = {
                width = { min = 20 },
                spacing = 3,
            },
            -- 为键位前缀定义分组名称
            spec = {
                { "<leader>b", group = "Buffer" },
                { "<leader>n", group = "清除" },
                { "<leader>r", group = "重载" },
                { "w", group = "窗口" },
                { "wm", group = "窗口调整" },
                { "d", group = "删除" },
                { "y", group = "复制" },
                { "q", group = "退出" },
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer 本地快捷键",
            },
        },
    },
    {
        "numToStr/Comment.nvim",
        event = "VeryLazy",
        opts = {
            toggler = {
                line = "gcc",  -- 行注释切换（默认就是 gcc）
                block = "gbc", -- 块注释切换（默认就是 gbc）
            },
            opleader = {
                line = "gc",  -- 行注释 operator（默认就是 gc）
                block = "gb", -- 块注释 operator（默认就是 gb）
            },
        },
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)
            -- 与 nvim-cmp 集成：选中补全项后自动补全括号
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
        opts = {
            check_ts = true, -- 启用 Tree-sitter 智能检查
        },
    },

    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",                       -- 进入插入模式时才加载，节省启动时间
        opts = {
            check_ts = true,                         -- 启用 Tree-sitter 检查，更智能地判断是否补全
            ts_config = {
                lua = { "string" },                  -- 在 lua 的字符串节点内不自动补全
                javascript = { "template_string" },  -- 在 JS 模板字符串内不自动补全
            },
            disable_filetype = {                     -- 在这些文件类型中禁用自动补全
                "TelescopePrompt",                   -- Telescope 搜索框
                "vim",                               -- vim 文件（避免干扰命令编写）
            },
            fast_wrap = {                            -- 快速包裹功能（默认触发键 <M-e>）
                map = "<M-e>",                       -- Alt+e 触发快速包裹
                chars = { "{", "[", "(", '"', "'" }, -- 可包裹的字符
                pattern = [=[[%'%"%>%]%)%}%,]]=],    -- 匹配跳转的目标字符
                end_key = "$",                       -- 跳到行尾
                before_key = "h",                    -- 在目标前插入
                after_key = "l",                     -- 在目标后插入
                cursor_pos_before = true,            -- 包裹后光标停在括号前
                keys = "qwertyuiopzxcvbnmasdfghjkl", -- 跳转标签使用的字符
                highlight = "PmenuSel",              -- 跳转标签高亮组
                highlight_grey = "LineNr",           -- 灰色标签高亮组
            },
        },
        config = function(_, opts)
            require("nvim-autopairs").setup(opts)
            -- 与 nvim-cmp 集成：选中补全项后自动补全括号
            -- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            -- local cmp = require("cmp")
            -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },

    {
        "kylechui/nvim-surround",
        version = "*",                         -- 使用最新稳定版
        event = "VeryLazy",                    -- 延迟加载，提升启动速度
        opts = {
            aliases = {                        -- 字符别名，方便快速输入
                ["a"] = ">",                   -- a 代表尖括号 <>
                ["b"] = ")",                   -- b 代表圆括号 ()
                ["B"] = "}",                   -- B 代表花括号 {}
                ["r"] = "]",                   -- r 代表方括号 []
                ["q"] = { '"', "'", "`" },     -- q 代表任意引号（删除/修改时自动匹配最近的）
                ["s"] = { "}", "]", ")", ">", '"', "'", "`" }, -- s 代表任意包裹符号
            },
        },
    },

    {
        "https://codeberg.org/andyg/leap.nvim",
        dependencies = {
          "tpope/vim-repeat",
        },
        event = "VeryLazy",
        config = function()
          local leap = require("leap")
      
          vim.keymap.set({ "n", "x", "o" }, "s", "<Plug>(leap)", { silent = true })
          vim.keymap.set("n", "S", "<Plug>(leap-from-window)", { silent = true })
      
          leap.opts.preview = function(ch0, ch1, ch2)
            return not (
              ch1:match("%s")
              or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a"))
            )
          end
      
          leap.opts.equivalence_classes = {
            " \t\r\n",
            "([{",
            ")]}",
            "'\"`",
          }
        end,
      },
    {
        "echasnovski/mini.ai",
        version = "*",                                    -- 使用最新稳定版
        event = "VeryLazy",                               -- 延迟加载，不影响启动速度
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects", -- 提供各语言的 treesitter 文本对象查询
        },
        opts = function()
            local ai = require("mini.ai")
    
            return {
                -- 搜索文本对象时向上/下扫描的最大行数
                n_lines = 500,
    
                -- 搜索策略：先尝试覆盖光标的匹配，找不到则取最近的
                -- 可选值: 'cover', 'cover_or_next', 'cover_or_prev', 'cover_or_nearest', 'next', 'prev', 'nearest'
                search_method = "cover_or_nearest",
    
                -- 不显示非错误类的提示信息（保持界面清爽）
                silent = false,
    
                -- 键位映射
                mappings = {
                    around = "a",                         -- a 文本对象前缀（包含边界）
                    inside = "i",                         -- i 文本对象前缀（不含边界）
                    around_next = "an",                   -- 下一个 a 文本对象
                    inside_next = "in",                   -- 下一个 i 文本对象
                    around_last = "al",                   -- 上一个 a 文本对象
                    inside_last = "il",                   -- 上一个 i 文本对象
                    goto_left = "g[",                     -- 跳转到 a 文本对象的左边界
                    goto_right = "g]",                    -- 跳转到 a 文本对象的右边界
                },
    
                -- 自定义文本对象
                custom_textobjects = {
                    -- 函数定义（需要 treesitter textobjects 查询支持）
                    F = ai.gen_spec.treesitter({
                        a = "@function.outer",            -- aF 选中整个函数（含签名）
                        i = "@function.inner",            -- iF 选中函数体
                    }),
    
                    -- 条件/循环语句
                    o = ai.gen_spec.treesitter({
                        a = { "@conditional.outer", "@loop.outer" },   -- ao 选中整个 if/for 等
                        i = { "@conditional.inner", "@loop.inner" },   -- io 选中条件/循环体内部
                    }),
    
                    -- 类/结构体
                    c = ai.gen_spec.treesitter({
                        a = "@class.outer",               -- ac 选中整个类
                        i = "@class.inner",               -- ic 选中类体内部
                    }),
    
                    -- 函数调用（不含点号，避免 obj.method() 中 obj. 被选中）
                    f = ai.gen_spec.function_call({
                        name_pattern = "[%w_]",           -- 函数名只匹配字母数字下划线
                    }),
    
                    -- 参数（微调分隔符，让 daa 删除参数时连空白一起删）
                    a = ai.gen_spec.argument({
                        separator = "%s*,%s*",            -- 分隔符包含逗号两侧的空白
                    }),
    
                    -- 选中整个 buffer
                    g = function()
                        local from = { line = 1, col = 1 }
                        local to = {
                            line = vim.fn.line("$"),                      -- 最后一行
                            col = math.max(vim.fn.getline("$"):len(), 1), -- 最后一行的末尾
                        }
                        return { from = from, to = to }   -- ag/ig 选中整个缓冲区
                    end,
    
                    -- 数字文本对象
                    d = { "%f[%d]%d+" },                  -- ad/id 选中连续数字，如 42、3.14 中的整数部分
    
                    -- 单词（不含数字和标点，仅匹配英文字母）
                    e = { { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" }, "^().*()$" },
                                                          -- ae/ie 选中 camelCase 子词，如 myFunc 中的 my 或 Func
                },
            }
        end,
    },
    {
        "echasnovski/mini.splitjoin",
        version = "*",                                    -- 使用最新稳定版
        event = "VeryLazy",                               -- 延迟加载，不影响启动速度
        opts = function()
            local splitjoin = require("mini.splitjoin")
    
            -- 生成常用 hook
            local gen_hook = splitjoin.gen_hook
    
            -- split 后自动添加尾逗号（所有括号类型）
            local add_trailing = gen_hook.add_trailing_separator({
                sep = ",",                                -- 尾部追加的分隔符
            })
    
            -- join 后自动删除尾逗号（所有括号类型）
            local del_trailing = gen_hook.del_trailing_separator({
                sep = ",",                                -- 要删除的尾部分隔符
            })
    
            -- join 后在括号内侧添加单个空格，如 {a, b} 而非 {a,b}
            local pad = gen_hook.pad_brackets({
                pad = " ",                                -- 括号内侧填充的字符串
            })
    
            return {
                -- 键位映射，设为 '' 可禁用对应映射
                -- Normal 和 Visual 模式都会生效
                mappings = {
                    toggle = "gS",                        -- 切换：单行则 split，多行则 join
                    split = "",                           -- 强制 split（留空表示不单独映射）
                    join = "",                            -- 强制 join（留空表示不单独映射）
                },
    
                -- 参数检测配置：控制如何识别括号区域和分隔符
                detect = {
                    brackets = nil,                       -- 识别的括号类型，nil 默认为 { '%b()', '%b[]', '%b{}' }
                    separator = ",",                      -- 参数分隔符（Lua pattern），默认逗号
                    exclude_regions = nil,                -- 排除的子区域，nil 默认为 { '%b()', '%b[]', '%b{}', '%b""', "%b''" }
                },
    
                -- Split 配置（单行拆成多行）
                split = {
                    hooks_pre = {},                       -- split 前的钩子函数数组（修改目标位置）
                    hooks_post = { add_trailing },        -- split 后的钩子：自动加尾逗号
                },
    
                -- Join 配置（多行合成单行）
                join = {
                    hooks_pre = {},                       -- join 前的钩子函数数组
                    hooks_post = { del_trailing, pad },   -- join 后的钩子：删尾逗号 + 括号加空格
                },
            }
        end,
    },
    {
        "monaqa/dial.nvim",
        event = "VeryLazy",                                       -- 延迟加载，不影响启动速度
        keys = {
            -- Normal 模式：光标处数值递增
            { "<C-a>", function() require("dial.map").manipulate("increment", "normal") end, desc = "递增" },
            -- Normal 模式：光标处数值递减
            { "<C-x>", function() require("dial.map").manipulate("decrement", "normal") end, desc = "递减" },
            -- Normal 模式：多行递增（每行递增量叠加，如 1,2,3...）
            { "g<C-a>", function() require("dial.map").manipulate("increment", "gnormal") end, desc = "累进递增" },
            -- Normal 模式：多行递减（每行递减量叠加）
            { "g<C-x>", function() require("dial.map").manipulate("decrement", "gnormal") end, desc = "累进递减" },
            -- Visual 模式：选中区域内数值递增
            { "<C-a>", function() require("dial.map").manipulate("increment", "visual") end, mode = "x", desc = "递增(选中)" },
            -- Visual 模式：选中区域内数值递减
            { "<C-x>", function() require("dial.map").manipulate("decrement", "visual") end, mode = "x", desc = "递减(选中)" },
            -- Visual 模式：选中多行累进递增
            { "g<C-a>", function() require("dial.map").manipulate("increment", "gvisual") end, mode = "x", desc = "累进递增(选中)" },
            -- Visual 模式：选中多行累进递减
            { "g<C-x>", function() require("dial.map").manipulate("decrement", "gvisual") end, mode = "x", desc = "累进递减(选中)" },
        },
        config = function()
            local augend = require("dial.augend")                 -- 导入 augend 模块，用于定义递增/递减规则
    
            require("dial.config").augends:register_group({
                default = {
                    augend.integer.alias.decimal,                 -- 十进制自然数：0, 1, 2, ...
                    augend.integer.alias.decimal_int,             -- 十进制整数（含负数）：-3, -2, ..., 0, 1, 2
                    augend.integer.alias.hex,                     -- 十六进制数：0x00, 0x1a, 0xff
                    augend.integer.alias.octal,                   -- 八进制数：0o00, 0o77
                    augend.integer.alias.binary,                  -- 二进制数：0b0101, 0b1111
    
                    augend.date.alias["%Y/%m/%d"],                -- 日期格式：2026/04/03
                    augend.date.alias["%Y-%m-%d"],                -- 日期格式：2026-04-03
                    augend.date.alias["%m/%d"],                   -- 日期格式：04/03
                    augend.date.alias["%H:%M:%S"],                -- 时间格式：14:30:00
                    augend.date.alias["%H:%M"],                   -- 时间格式：14:30
    
                    augend.constant.alias.bool,                   -- 布尔值切换：true <-> false
                    augend.constant.alias.Bool,                   -- 布尔值切换（首字母大写）：True <-> False
    
                    augend.semver.alias.semver,                   -- 语义化版本：1.0.0, 2.3.1
    
                    augend.hexcolor.new({                         -- 十六进制颜色值：#ff0000, #00ff00
                        case = "lower",                           -- 使用小写字母：a-f
                    }),
    
                    augend.constant.new({                         -- 逻辑运算符切换
                        elements = { "&&", "||" },                -- && <-> ||
                        word = false,                             -- 不要求单词边界（因为是符号）
                        cyclic = true,                            -- 循环切换：|| 递增回到 &&
                    }),
    
                    augend.constant.new({                         -- 逻辑关键字切换
                        elements = { "and", "or" },               -- and <-> or
                        word = true,                              -- 要求单词边界，避免 "sand" 被误匹配
                        cyclic = true,                            -- 循环切换
                    }),
    
                    augend.constant.new({                         -- 比较运算符切换
                        elements = { "===", "!==" },              -- 全等 <-> 全不等
                        word = false,                             -- 不要求单词边界
                        cyclic = true,                            -- 循环切换
                    }),
    
                    augend.constant.new({                         -- 比较运算符切换
                        elements = { "==", "!=" },                -- 等于 <-> 不等于
                        word = false,                             -- 不要求单词边界
                        cyclic = true,                            -- 循环切换
                    }),
    
                    augend.constant.new({                         -- 大于/小于切换
                        elements = { ">=", "<=" },                -- 大于等于 <-> 小于等于
                        word = false,                             -- 不要求单词边界
                        cyclic = true,                            -- 循环切换
                    }),
    
                    augend.constant.new({                         -- 加减运算符切换
                        elements = { "+=", "-=" },                -- 加等于 <-> 减等于
                        word = false,                             -- 不要求单词边界
                        cyclic = true,                            -- 循环切换
                    }),
    
                    augend.constant.new({                         -- 前端常用：let/const 切换
                        elements = { "let", "const" },            -- let <-> const
                        word = true,                              -- 要求单词边界
                        cyclic = true,                            -- 循环切换
                    }),
    
                    augend.constant.new({                         -- 常见状态字符串切换
                        elements = { "yes", "no" },               -- yes <-> no
                        word = true,                              -- 要求单词边界
                        cyclic = true,                            -- 循环切换
                    }),
    
                    augend.constant.new({                         -- 常见状态字符串切换（首字母大写）
                        elements = { "Yes", "No" },               -- Yes <-> No
                        word = true,                              -- 要求单词边界
                        cyclic = true,                            -- 循环切换
                    }),
    
                    augend.constant.new({                         -- 启用/禁用切换
                        elements = { "enable", "disable" },       -- enable <-> disable
                        word = true,                              -- 要求单词边界
                        cyclic = true,                            -- 循环切换
                    }),
                },
            })
        end,
    },
    {
        "andymass/vim-matchup",                                  -- 增强版 % 匹配跳转插件，替代内置 matchit 和 matchparen
        event = { "BufReadPost", "BufNewFile" },                 -- 打开/新建文件时加载（作者建议不要用 VeryLazy，避免漏加载）
        dependencies = {
            "nvim-treesitter/nvim-treesitter",                   -- 可选：tree-sitter 集成，提供语言级别的匹配支持
        },
        init = function()
            -- init 在插件加载前执行，适合设置 vim.g 变量
    
            vim.g.matchup_matchparen_offscreen = {               -- 配置屏幕外匹配项的显示方式
                method = "popup",                                -- 使用浮动窗口显示屏幕外的匹配（也可选 "status"）
            }
    
            vim.g.matchup_matchparen_deferred = 1                -- 延迟高亮：光标移动时延迟计算匹配，提升 hjkl 移动性能
            vim.g.matchup_matchparen_deferred_show_delay = 50    -- 光标停稳后多少毫秒开始高亮匹配（默认 50）
            vim.g.matchup_matchparen_deferred_hide_delay = 700   -- 光标移走后多少毫秒隐藏高亮（默认 700）
    
            vim.g.matchup_matchparen_hi_surround_always = 1      -- 始终高亮光标所在块的首尾匹配词（需启用 deferred）
    
            vim.g.matchup_matchparen_stopline = 400              -- 高亮匹配时向上/下搜索的最大行数（值越大越耗性能）
            vim.g.matchup_delim_stopline = 1500                  -- 动作和文本对象搜索的最大行数（不影响高亮）
    
            vim.g.matchup_surround_enabled = 1                   -- 启用 ds% 删除包裹和 cs% 修改包裹功能
            vim.g.matchup_transmute_enabled = 0                  -- 实验性功能：修改一端自动同步另一端（0=关闭）
    
            vim.g.matchup_motion_override_Npercent = 6           -- {count}% 在 count<=6 时走匹配跳转，>6 时走百分比跳转
            vim.g.matchup_motion_cursor_end = 1                  -- 向下跳转(% ]%)时光标落在匹配词末尾，向上跳转落在开头
    
            vim.g.matchup_matchparen_singleton = 0               -- 是否高亮没有配对的已知关键词（0=不高亮，1=高亮）
    
            vim.g.matchup_text_obj_linewise_operators = {        -- 这些操作符配合 i%/a% 时会自动切换为行模式
                "d",                                             -- 删除操作
                "y",                                             -- 复制操作
            }
        end,
        config = function()
            -- 自定义高亮颜色，放在 ColorScheme autocmd 里防止切换主题后丢失
            vim.api.nvim_create_autocmd("ColorScheme", {
                callback = function()
                    vim.api.nvim_set_hl(0, "MatchParen", {          -- 括号匹配高亮样式
                        underline = true,                            -- 下划线
                        bold = true,                                 -- 加粗
                    })
                    vim.api.nvim_set_hl(0, "MatchWord", {           -- 关键词匹配高亮样式（if/end 等）
                        underline = true,                            -- 下划线（避免大块高亮太刺眼）
                    })
                    vim.api.nvim_set_hl(0, "MatchParenCur", {       -- 光标下括号的高亮样式
                        underline = true,                            -- 下划线
                    })
                    vim.api.nvim_set_hl(0, "MatchWordCur", {        -- 光标下关键词的高亮样式
                        underline = true,                            -- 下划线
                    })
                end,
            })
        end,
    }
}
