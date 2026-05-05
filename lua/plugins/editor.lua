return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      ---@type false | "classic" | "modern" | "helix"
      preset = "helix", -- 预设布局，helix 风格比较紧凑美观
      delay = 300, -- 按键后多少毫秒弹出面板（默认 200）
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
        { "<leader>f", group = "搜索" },
        { "<leader>a", group = "AI" },
        { "<leader>b", group = "Buffer" },
        { "<leader>c", group = "Claude" },
        { "<leader>n", group = "清除" },
        { "<leader>r", group = "重载" },
        { "w", group = "窗口" },
        { "wm", group = "窗口调整" },
        { "d", group = "删除" },
        { "y", group = "复制" },
        { "q", group = "退出" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LSP" },
        { "<leader>j", group = "Java" },
        { "<leader>t", group = "终端" },
      },
    },
    keys = {
      {
        "<leader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer 本地快捷键",
      },
    },
  },
  {
    "numToStr/Comment.nvim",
    event = "VeryLazy",
    opts = {
      toggler = {
        line = "gcc", -- 行注释切换（默认就是 gcc）
        block = "gbc", -- 块注释切换（默认就是 gbc）
      },
      opleader = {
        line = "gc", -- 行注释 operator（默认就是 gc）
        block = "gb", -- 块注释 operator（默认就是 gb）
      },
    },
  },

  {
    "windwp/nvim-autopairs",
    event = "InsertEnter", -- 进入插入模式时才加载，节省启动时间
    opts = {
      check_ts = true, -- 启用 Tree-sitter 检查，更智能地判断是否补全
      ts_config = {
        lua = { "string" }, -- 在 lua 的字符串节点内不自动补全
        javascript = { "template_string" }, -- 在 JS 模板字符串内不自动补全
      },
      disable_filetype = { -- 在这些文件类型中禁用自动补全
        "TelescopePrompt", -- Telescope 搜索框
        "vim", -- vim 文件（避免干扰命令编写）
      },
      fast_wrap = { -- 快速包裹功能（默认触发键 <M-e>）
        map = "<M-e>", -- Alt+e 触发快速包裹
        chars = { "{", "[", "(", '"', "'" }, -- 可包裹的字符
        pattern = [=[[%'%"%>%]%)%}%,]]=], -- 匹配跳转的目标字符
        end_key = "$", -- 跳到行尾
        before_key = "h", -- 在目标前插入
        after_key = "l", -- 在目标后插入
        cursor_pos_before = true, -- 包裹后光标停在括号前
        keys = "qwertyuiopzxcvbnmasdfghjkl", -- 跳转标签使用的字符
        highlight = "PmenuSel", -- 跳转标签高亮组
        highlight_grey = "LineNr", -- 灰色标签高亮组
      },
    },
    config = function(_, opts) require("nvim-autopairs").setup(opts) end,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- 使用最新稳定版
    event = "VeryLazy", -- 延迟加载，提升启动速度
    opts = {
      aliases = { -- 字符别名，方便快速输入
        ["a"] = ">", -- a 代表尖括号 <>
        ["b"] = ")", -- b 代表圆括号 ()
        ["B"] = "}", -- B 代表花括号 {}
        ["r"] = "]", -- r 代表方括号 []
        ["q"] = { '"', "'", "`" }, -- q 代表任意引号（删除/修改时自动匹配最近的）
        ["s"] = { "}", "]", ")", ">", '"', "'", "`" }, -- s 代表任意包裹符号
      },
    },
  },

  {
    "echasnovski/mini.splitjoin",
    version = "*", -- 使用最新稳定版
    event = "VeryLazy", -- 延迟加载，不影响启动速度
    opts = function()
      local splitjoin = require("mini.splitjoin")

      -- 生成常用 hook
      local gen_hook = splitjoin.gen_hook

      -- split 后自动添加尾逗号（所有括号类型）
      local add_trailing = gen_hook.add_trailing_separator({
        sep = ",", -- 尾部追加的分隔符
      })

      -- join 后自动删除尾逗号（所有括号类型）
      local del_trailing = gen_hook.del_trailing_separator({
        sep = ",", -- 要删除的尾部分隔符
      })

      -- join 后在括号内侧添加单个空格，如 {a, b} 而非 {a,b}
      local pad = gen_hook.pad_brackets({
        pad = " ", -- 括号内侧填充的字符串
      })

      return {
        -- 键位映射，设为 '' 可禁用对应映射
        -- Normal 和 Visual 模式都会生效
        mappings = {
          toggle = "gS", -- 切换：单行则 split，多行则 join
          split = "", -- 强制 split（留空表示不单独映射）
          join = "", -- 强制 join（留空表示不单独映射）
        },

        -- 参数检测配置：控制如何识别括号区域和分隔符
        detect = {
          brackets = nil, -- 识别的括号类型，nil 默认为 { '%b()', '%b[]', '%b{}' }
          separator = ",", -- 参数分隔符（Lua pattern），默认逗号
          exclude_regions = nil, -- 排除的子区域，nil 默认为 { '%b()', '%b[]', '%b{}', '%b""', "%b''" }
        },

        -- Split 配置（单行拆成多行）
        split = {
          hooks_pre = {}, -- split 前的钩子函数数组（修改目标位置）
          hooks_post = { add_trailing }, -- split 后的钩子：自动加尾逗号
        },

        -- Join 配置（多行合成单行）
        join = {
          hooks_pre = {}, -- join 前的钩子函数数组
          hooks_post = { del_trailing, pad }, -- join 后的钩子：删尾逗号 + 括号加空格
        },
      }
    end,
  },
  {
    "monaqa/dial.nvim",
    event = "VeryLazy", -- 延迟加载，不影响启动速度
    keys = {
      -- Normal 模式：光标处数值递增
      {
        "<C-a>",
        function() require("dial.map").manipulate("increment", "normal") end,
        desc = "递增",
      },
      -- Normal 模式：光标处数值递减
      {
        "<C-x>",
        function() require("dial.map").manipulate("decrement", "normal") end,
        desc = "递减",
      },
      -- Normal 模式：多行递增（每行递增量叠加，如 1,2,3...）
      {
        "g<C-a>",
        function() require("dial.map").manipulate("increment", "gnormal") end,
        desc = "累进递增",
      },
      -- Normal 模式：多行递减（每行递减量叠加）
      {
        "g<C-x>",
        function() require("dial.map").manipulate("decrement", "gnormal") end,
        desc = "累进递减",
      },
      -- Visual 模式：选中区域内数值递增
      {
        "<C-a>",
        function() require("dial.map").manipulate("increment", "visual") end,
        mode = "x",
        desc = "递增(选中)",
      },
      -- Visual 模式：选中区域内数值递减
      {
        "<C-x>",
        function() require("dial.map").manipulate("decrement", "visual") end,
        mode = "x",
        desc = "递减(选中)",
      },
      -- Visual 模式：选中多行累进递增
      {
        "g<C-a>",
        function() require("dial.map").manipulate("increment", "gvisual") end,
        mode = "x",
        desc = "累进递增(选中)",
      },
      -- Visual 模式：选中多行累进递减
      {
        "g<C-x>",
        function() require("dial.map").manipulate("decrement", "gvisual") end,
        mode = "x",
        desc = "累进递减(选中)",
      },
    },
    config = function()
      local augend = require("dial.augend") -- 导入 augend 模块，用于定义递增/递减规则

      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal, -- 十进制自然数：0, 1, 2, ...
          augend.integer.alias.decimal_int, -- 十进制整数（含负数）：-3, -2, ..., 0, 1, 2
          augend.integer.alias.hex, -- 十六进制数：0x00, 0x1a, 0xff
          augend.integer.alias.octal, -- 八进制数：0o00, 0o77
          augend.integer.alias.binary, -- 二进制数：0b0101, 0b1111

          augend.date.alias["%Y/%m/%d"], -- 日期格式：2026/04/03
          augend.date.alias["%Y-%m-%d"], -- 日期格式：2026-04-03
          augend.date.alias["%m/%d"], -- 日期格式：04/03
          augend.date.alias["%H:%M:%S"], -- 时间格式：14:30:00
          augend.date.alias["%H:%M"], -- 时间格式：14:30

          augend.constant.alias.bool, -- 布尔值切换：true <-> false
          augend.constant.alias.Bool, -- 布尔值切换（首字母大写）：True <-> False

          augend.semver.alias.semver, -- 语义化版本：1.0.0, 2.3.1

          augend.hexcolor.new({ -- 十六进制颜色值：#ff0000, #00ff00
            case = "lower", -- 使用小写字母：a-f
          }),

          augend.constant.new({ -- 逻辑运算符切换
            elements = { "&&", "||" }, -- && <-> ||
            word = false, -- 不要求单词边界（因为是符号）
            cyclic = true, -- 循环切换：|| 递增回到 &&
          }),

          augend.constant.new({ -- 逻辑关键字切换
            elements = { "and", "or" }, -- and <-> or
            word = true, -- 要求单词边界，避免 "sand" 被误匹配
            cyclic = true, -- 循环切换
          }),

          augend.constant.new({ -- 比较运算符切换
            elements = { "===", "!==" }, -- 全等 <-> 全不等
            word = false, -- 不要求单词边界
            cyclic = true, -- 循环切换
          }),

          augend.constant.new({ -- 比较运算符切换
            elements = { "==", "!=" }, -- 等于 <-> 不等于
            word = false, -- 不要求单词边界
            cyclic = true, -- 循环切换
          }),

          augend.constant.new({ -- 大于/小于切换
            elements = { ">=", "<=" }, -- 大于等于 <-> 小于等于
            word = false, -- 不要求单词边界
            cyclic = true, -- 循环切换
          }),

          augend.constant.new({ -- 加减运算符切换
            elements = { "+=", "-=" }, -- 加等于 <-> 减等于
            word = false, -- 不要求单词边界
            cyclic = true, -- 循环切换
          }),

          augend.constant.new({ -- 前端常用：let/const 切换
            elements = { "let", "const" }, -- let <-> const
            word = true, -- 要求单词边界
            cyclic = true, -- 循环切换
          }),

          augend.constant.new({ -- 常见状态字符串切换
            elements = { "yes", "no" }, -- yes <-> no
            word = true, -- 要求单词边界
            cyclic = true, -- 循环切换
          }),

          augend.constant.new({ -- 常见状态字符串切换（首字母大写）
            elements = { "Yes", "No" }, -- Yes <-> No
            word = true, -- 要求单词边界
            cyclic = true, -- 循环切换
          }),

          augend.constant.new({ -- 启用/禁用切换
            elements = { "enable", "disable" }, -- enable <-> disable
            word = true, -- 要求单词边界
            cyclic = true, -- 循环切换
          }),
        },
      })
    end,
  },
}
