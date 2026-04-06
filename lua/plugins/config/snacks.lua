local snacks = require("snacks")
local keymap = require("core.keymap")

snacks.setup({
	explorer = {
		replace_netrw = true,
		trash = true,
	},
	picker = {
		sources = {
			explorer = {
				-- 基础行为
				tree = true, -- 显示文件树
				watch = true, -- 监听文件变化自动刷新
				follow_file = true, -- 自动跟踪当前 buffer 对应的文件
				-- Git 集成
				git_status = true, -- 显示 git 状态标记
				git_status_open = false, -- 已展开目录递归显示 git 状态
				git_untracked = true, -- 显示 untracked 文件的 git 状态
				-- 诊断集成
				diagnostics = true, -- 显示 LSP 诊断标记
				diagnostics_open = false, -- 已展开目录递归显示诊断
				-- 过滤
				hidden = false, -- 是否显示隐藏文件（H 键切换）
				ignored = false, -- 是否显示 .gitignore 忽略的文件（I 键切换）
				exclude = {}, -- 排除的 glob 模式，如 { "node_modules" }
				include = {}, -- 强制包含的 glob（优先级高于 exclude/hidden/ignored）
				-- 布局
				layout = {
					preset = "sidebar", -- 侧边栏布局（默认左侧）
					preview = false, -- 不显示预览
				},
				-- 焦点与关闭行为
				focus = "list", -- 打开时焦点在文件列表（而非输入框）
				auto_close = true, -- 自动关闭
				jump = { close = true }, -- 打开文件后,关闭 explorer
				win = {
					list = {
						keys = {},
					},
				},
			},
		},
	},
	bigfile = {
		enabled = true,
		notify = true, -- 检测到大文件时显示通知
		size = 1.5 * 1024 * 1024, -- 1.5MB
		line_length = 1000, -- 平均行长阈值
	},
	dim = {},
	git = {
		width = 0.6, -- 窗口宽度（占屏幕 60%）
		height = 0.6, -- 窗口高度（占屏幕 60%）
		border = true, -- 显示边框
		title = " Git Blame ",
		title_pos = "center",
		ft = "git", -- 文件类型设为 git（语法高亮）
	},
	gitbrowse = {
		notify = true, -- 打开 URL 时显示通知
		what = "commit", -- 默认打开类型: "repo" | "branch" | "file" | "commit" | "permalink"
		branch = nil, -- 指定分支（nil 表示使用当前分支）
		commit = nil, -- 指定 commit（nil 表示使用当前 commit）
		line_start = nil, -- 起始行号
		line_end = nil, -- 结束行号
		-- 自定义打开浏览器的方式
		open = function(url)
			vim.ui.open(url)
		end,
		-- remote URL 转换规则（将 git remote 地址转为 HTTPS 地址）
		remote_patterns = {
			{ "^git@(.+):(.+)%.git$", "https://%1/%2" },
			-- ... 更多内置规则
		},
		-- 不同平台的 URL 模板
		url_patterns = {
			["github%.com"] = {
				branch = "/tree/{branch}",
				file = "/blob/{branch}/{file}#L{line_start}-L{line_end}",
				permalink = "/blob/{commit}/{file}#L{line_start}-L{line_end}",
				commit = "/commit/{commit}",
			},
		},
	},
	-- 需要安装 ImageMagick 和 mermaid
	-- npm install -g @mermaid-js/mermaid-cli
	-- brew install imagemagick
	image = {
		enabled = true,
		force = false, -- 即使终端不支持也尝试显示
		doc = {
			enabled = true, -- 在文档中渲染图片
			inline = true, -- 内联渲染（直接在 buffer 文本中显示）
			float = true, -- 浮动窗口渲染（inline 不可用时的 fallback）
			max_width = 80, -- 最大宽度（列数）
			max_height = 40, -- 最大高度（行数）
			conceal = function(lang, type)
				return type == "math" -- 仅隐藏数学公式的源文本
			end,
		},
		-- 图片搜索目录（解析相对路径时使用）
		img_dirs = { "img", "images", "assets", "static", "public", "media", "attachments" },
		-- 内联图片的图标
		icons = {
			math = "󰪚 ",
			chart = "󰄧 ",
			image = " ",
		},
		math = {
			enabled = true, -- 启用数学公式渲染
			-- typst/latex 模板可自定义...
		},
		convert = {
			notify = false, -- 转换出错时是否通知
			-- ImageMagick 和 mermaid 转换参数可自定义
		},
	},
	indent = {
		indent = {
			enabled = true,
			char = "│",
		},
		scope = {
			enabled = true,
			char = "│",
		},
		animate = {
			enabled = true,
			style = "out",
		},
		chunk = {
			enabled = false, -- 想要块状效果可以改为 true
		},
	},
})

keymap.nmap("<leader>gB", function()
	snacks.gitbrowse()
end, { desc = "在浏览器中打开" })

keymap.vmap("<leader>gB", function()
	snacks.gitbrowse()
end, { desc = "在浏览器中打开（带选中行）" })

snacks.dim.enable()

keymap.nmap("<leader>gb", function()
	snacks.git.blame_line()
end, {
	desc = "Git Blame 当前行",
})

keymap.nmap("<leader>e", function()
	snacks.explorer()
end, {
	desc = "文件浏览器",
})

keymap.nmap("<leader>tt", function()
	snacks.terminal.toggle(nil, {
		win = {
			position = "float",
			height = 0.8,
			width = 0.85,
			border = "rounded",
			keys = {
			  ["<esc>"] = {
				"<esc>",
				function(self) self:hide() end,
				mode = "t",         -- 必须指定 terminal 模式
				desc = "隐藏终端",
			  },
			  term_normal = {
				"<c-esc>",
				"<C-\\><C-n>",
				mode = "t",
				desc = "退出终端模式",
			  },
			},
		  },
	  })
end, {
	desc = "浮动终端",
})

local default_terminal_keys = {
	["<esc>"] = {
	  "<esc>",
	  function(self) self:hide() end,
	  mode = "t",         -- 必须指定 terminal 模式
	  desc = "隐藏终端",
	},
	term_normal = {
	  "<c-esc>",
	  "<C-\\><C-n>",
	  mode = "t",
	  desc = "退出终端模式",
	},
  }

local function create_terminal(cmd,title,keys)
	snacks.terminal.toggle(cmd, {
		win = {
			position = "float",
			height = 0.8,
			width = 0.85,
			border = "rounded",
			title = title,
			keys = table.deep_extend("force", default_terminal_keys, keys or {}),
		  },
	  })
end

keymap.batch({
	{
		"n",
		"<leader>tt",
		function ()
			create_terminal(nil, { { " 🐚 Terminal ", "FloatTitle" } })
		end,
		{	desc = "浮动终端",
		}
	},
	{
		"n",
		"<leader>tq",
		function ()
			create_terminal(nil, { { " 🐚 Terminal ", "FloatTitle" } })
		end,
		{	desc = "浮动终端",
		}
	},
	{
		"n",
		"<leader>tw",
		function ()
			create_terminal(nil, { { " 🐚 Terminal ", "FloatTitle" } })
		end,
		{	desc = "浮动终端",
		}
	},
	{
		"n",
		"<leader>te",
		function ()
			create_terminal(nil, { { " 🐚 Terminal ", "FloatTitle" } })
		end,
		{	desc = "浮动终端",
		}
	},
	{
		"n",
		"<leader>tr",
		function ()
			create_terminal(nil, { { " 🐚 Terminal ", "FloatTitle" } })
		end,
		{	desc = "浮动终端",
		}
	},
	{
		"n",
		"<leader>tg",
		function ()
			snacks.lazygit()
			-- create_terminal("lazygit", { { " 🐚 Terminal ", "FloatTitle" } })
		end,
		{	desc = "浮动终端",
		}
	},
})