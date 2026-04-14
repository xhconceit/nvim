-- Lazy 地址
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        -- 如果克隆失败，则显示错误信息
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit...",   "WarningMsg" },
        }, true, {})
        -- 等待用户按下任意键
        vim.fn.getchar()
        -- 如果用户按下任意键，则退出
        os.exit(1)
    end
end
-- 将 lazy.nvim 添加到 runtimepath
vim.opt.rtp:prepend(lazypath)

-- 加载 lazy.nvim
require("lazy").setup({
    defaults = {
        -- 延迟加载
        lazy = true,
        -- 版本锁定
        version = false,
        -- 条件加载
        cond = nil,
    },
    -- 插件列表
    spec = {
        { import = "plugins" }
    },
    -- 并发任务数量
    -- 如果是 window 使用 cpu 核心乘 2 ，否则使用默认
    concurrency = jit.os:find("Windows") and (vim.uv.available_parallelism() * 2) or nil,
    pkg = {
        enabled = true,                                     -- 是否启用包管理功能
        cache = vim.fn.stdpath("state") .. "/lazy/pkg-cache.lua", -- 包缓存文件路径
        sources = { "lazy", "rockspec", "packspec" },       -- 包的来源
    },
    install = {
        missing = true,           -- 是否安装缺失的插件
    },
    ui = {
        size = { width = 0.8, height = 0.8 }, -- 窗口大小
        wrap = true,                          -- 是否自动换行
        border = "none",                      -- 边框样式
        backdrop = 60,                        -- 背景透明度
        title = "Lazy",                       -- 窗口标题
        title_pos = "center",                 -- 标题位置
        pills = true,                         -- 是否显示顶部的药丸状标签
        -- 图标
        icons = {
            cmd = " ",
            config = "",
            debug = "● ",
            event = " ",
            favorite = " ",
            ft = " ",
            init = " ",
            import = " ",
            keys = " ",
            lazy = "󰒲 ",
            loaded = "●",
            not_loaded = "○",
            plugin = " ",
            runtime = " ",
            require = "󰢱 ",
            source = " ",
            start = " ",
            task = "✔ ",
            list = { "●", "➜", "★", "‒" },
        },
        throttle = 1000 / 30, -- UI 刷新频率
    },
    headless = {
		process = true, -- 是否显示进程命令的输出
		log = true, -- 是否显示日志消息
		task = true, -- 是否显示任务的开始和结束信息
		colors = true, -- 是否使用 ANSI 颜色
	},
	checker = {
		enabled = true, -- 是否启用自动检查更新
		concurrency = 5, -- 并发检查任务的数量
		notify = true, -- 是否通知用户有更新
		frequency = 3600, -- 检查更新的频率（秒）
		check_pinned = false, -- 是否检查已固定的插件
	},
	change_detection = {
		enabled = true, -- 是否启用变更检测
		notify = true, -- 是否通知用户配置文件已更改
		debounce = 100, -- 防抖时间（毫秒）
	},
	-- 从插件的 README.md 文件中生成帮助文档
	readme = {
		enabled = true, -- 是否启用 README.md 的处理
		root = vim.fn.stdpath("state") .. "/lazy/readme", -- README 文件的缓存目录
		files = { "README.md", "lua/**/README.md" }, -- 需要处理的 README 文件
		skip_if_doc_exists = true, -- 如果插件已有文档，是否跳过处理
	},
	profiling = {
		loader = false, -- 是否启用加载器性能分析
		require = false, -- 是否跟踪每个 `require` 的性能
	},
}, {
 performance = {
    reset_packpath = false,
  },
  })
