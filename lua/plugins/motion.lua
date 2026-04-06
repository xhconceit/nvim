return {

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
				return not (ch1:match("%s") or (ch0:match("%a") and ch1:match("%a") and ch2:match("%a")))
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
		version = "*", -- 使用最新稳定版
		event = "VeryLazy", -- 延迟加载，不影响启动速度
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
					around = "a", -- a 文本对象前缀（包含边界）
					inside = "i", -- i 文本对象前缀（不含边界）
					around_next = "an", -- 下一个 a 文本对象
					inside_next = "in", -- 下一个 i 文本对象
					around_last = "al", -- 上一个 a 文本对象
					inside_last = "il", -- 上一个 i 文本对象
					goto_left = "g[", -- 跳转到 a 文本对象的左边界
					goto_right = "g]", -- 跳转到 a 文本对象的右边界
				},

				-- 自定义文本对象
				custom_textobjects = {
					-- 函数定义（需要 treesitter textobjects 查询支持）
					F = ai.gen_spec.treesitter({
						a = "@function.outer", -- aF 选中整个函数（含签名）
						i = "@function.inner", -- iF 选中函数体
					}),

					-- 条件/循环语句
					o = ai.gen_spec.treesitter({
						a = { "@conditional.outer", "@loop.outer" }, -- ao 选中整个 if/for 等
						i = { "@conditional.inner", "@loop.inner" }, -- io 选中条件/循环体内部
					}),

					-- 类/结构体
					c = ai.gen_spec.treesitter({
						a = "@class.outer", -- ac 选中整个类
						i = "@class.inner", -- ic 选中类体内部
					}),

					-- 函数调用（不含点号，避免 obj.method() 中 obj. 被选中）
					f = ai.gen_spec.function_call({
						name_pattern = "[%w_]", -- 函数名只匹配字母数字下划线
					}),

					-- 参数（微调分隔符，让 daa 删除参数时连空白一起删）
					a = ai.gen_spec.argument({
						separator = "%s*,%s*", -- 分隔符包含逗号两侧的空白
					}),

					-- 选中整个 buffer
					g = function()
						local from = { line = 1, col = 1 }
						local to = {
							line = vim.fn.line("$"), -- 最后一行
							col = math.max(vim.fn.getline("$"):len(), 1), -- 最后一行的末尾
						}
						return { from = from, to = to } -- ag/ig 选中整个缓冲区
					end,

					-- 数字文本对象
					d = { "%f[%d]%d+" }, -- ad/id 选中连续数字，如 42、3.14 中的整数部分

					-- 单词（不含数字和标点，仅匹配英文字母）
					e = {
						{
							"%u[%l%d]+%f[^%l%d]",
							"%f[%S][%l%d]+%f[^%l%d]",
							"%f[%P][%l%d]+%f[^%l%d]",
							"^[%l%d]+%f[^%l%d]",
						},
						"^().*()$",
					},
					-- ae/ie 选中 camelCase 子词，如 myFunc 中的 my 或 Func
				},
			}
		end,
	},

	{
		"andymass/vim-matchup", -- 增强版 % 匹配跳转插件，替代内置 matchit 和 matchparen
		event = { "BufReadPost", "BufNewFile" }, -- 打开/新建文件时加载（作者建议不要用 VeryLazy，避免漏加载）
		dependencies = {
			"nvim-treesitter/nvim-treesitter", -- 可选：tree-sitter 集成，提供语言级别的匹配支持
		},
		init = function()
			-- init 在插件加载前执行，适合设置 vim.g 变量

			vim.g.matchup_matchparen_offscreen = { -- 配置屏幕外匹配项的显示方式
				method = "popup", -- 使用浮动窗口显示屏幕外的匹配（也可选 "status"）
			}

			vim.g.matchup_matchparen_deferred = 1 -- 延迟高亮：光标移动时延迟计算匹配，提升 hjkl 移动性能
			vim.g.matchup_matchparen_deferred_show_delay = 50 -- 光标停稳后多少毫秒开始高亮匹配（默认 50）
			vim.g.matchup_matchparen_deferred_hide_delay = 700 -- 光标移走后多少毫秒隐藏高亮（默认 700）

			vim.g.matchup_matchparen_hi_surround_always = 1 -- 始终高亮光标所在块的首尾匹配词（需启用 deferred）

			vim.g.matchup_matchparen_stopline = 400 -- 高亮匹配时向上/下搜索的最大行数（值越大越耗性能）
			vim.g.matchup_delim_stopline = 1500 -- 动作和文本对象搜索的最大行数（不影响高亮）

			vim.g.matchup_surround_enabled = 1 -- 启用 ds% 删除包裹和 cs% 修改包裹功能
			vim.g.matchup_transmute_enabled = 0 -- 实验性功能：修改一端自动同步另一端（0=关闭）

			vim.g.matchup_motion_override_Npercent = 6 -- {count}% 在 count<=6 时走匹配跳转，>6 时走百分比跳转
			vim.g.matchup_motion_cursor_end = 1 -- 向下跳转(% ]%)时光标落在匹配词末尾，向上跳转落在开头

			vim.g.matchup_matchparen_singleton = 0 -- 是否高亮没有配对的已知关键词（0=不高亮，1=高亮）

			vim.g.matchup_text_obj_linewise_operators = { -- 这些操作符配合 i%/a% 时会自动切换为行模式
				"d", -- 删除操作
				"y", -- 复制操作
			}
		end,
		config = function()
			-- 自定义高亮颜色，放在 ColorScheme autocmd 里防止切换主题后丢失
			vim.api.nvim_create_autocmd("ColorScheme", {
				callback = function()
					vim.api.nvim_set_hl(0, "MatchParen", { -- 括号匹配高亮样式
						underline = true, -- 下划线
						bold = true, -- 加粗
					})
					vim.api.nvim_set_hl(0, "MatchWord", { -- 关键词匹配高亮样式（if/end 等）
						underline = true, -- 下划线（避免大块高亮太刺眼）
					})
					vim.api.nvim_set_hl(0, "MatchParenCur", { -- 光标下括号的高亮样式
						underline = true, -- 下划线
					})
					vim.api.nvim_set_hl(0, "MatchWordCur", { -- 光标下关键词的高亮样式
						underline = true, -- 下划线
					})
				end,
			})
		end,
	},
}
