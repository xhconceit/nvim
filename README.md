# Neovim 配置

一套以 `lazy.nvim` 为插件管理器的 Neovim 配置，覆盖基础编辑、UI 美化、LSP、自动补全、文件管理、搜索、终端、Git 集成和代码格式化。

## 目录结构

```text
.
├── init.lua
├── lazy-lock.json
└── lua
    ├── config
    │   ├── keymaps.lua        # 自定义快捷键
    │   ├── lazy.lua           # lazy.nvim 初始化
    │   └── options.lua        # 编辑器基础选项
    ├── core
    │   ├── keymap.lua         # vim.keymap.set 封装
    │   └── text.lua           # 文本工具函数
    ├── lsp
    │   ├── init.lua           # LSP 公共配置（on_attach、capabilities）
    │   ├── lua_ls.lua         # Lua LSP 配置
    │   └── jdtls.lua          # Java LSP 配置
    └── plugins
        ├── cmp.lua            # 自动补全（blink.cmp）
        ├── common.lua         # 通用依赖（plenary）
        ├── editor.lua         # 编辑增强插件
        ├── explorer.lua       # 文件管理（mini.files）
        ├── format.lua         # 代码格式化（conform）
        ├── git.lua            # Git 集成（gitsigns）
        ├── lsp.lua            # LSP 插件声明
        ├── search.lua         # 模糊搜索（mini.pick）
        ├── terminal.lua       # 浮动终端（toggleterm）
        ├── treesitter.lua     # 语法解析（treesitter）
        └── ui.lua             # UI 插件
```

## 插件列表

### UI

| 插件 | 说明 |
| --- | --- |
| `folke/tokyonight.nvim` | 主题，night 风格，透明背景 |
| `lukas-reineke/indent-blankline.nvim` | 彩虹缩进线 |
| `nvim-lualine/lualine.nvim` | 状态栏 |
| `akinsho/bufferline.nvim` | Buffer 标签栏 |
| `folke/noice.nvim` | 命令面板、通知美化 |
| `rcarriga/nvim-notify` | 通知弹窗 |
| `rrethy/vim-illuminate` | 高亮光标下相同单词 |
| `echasnovski/mini.animate` | 光标与滚动动画 |

### 编辑增强

| 插件 | 说明 |
| --- | --- |
| `folke/which-key.nvim` | 快捷键提示面板 |
| `numToStr/Comment.nvim` | 快速注释 |
| `windwp/nvim-autopairs` | 自动配对括号/引号 |
| `kylechui/nvim-surround` | 包裹操作（添加/修改/删除） |
| `andyg/leap.nvim` | 快速跳转 |
| `echasnovski/mini.ai` | 增强文本对象 |
| `echasnovski/mini.splitjoin` | 单行/多行切换 |
| `monaqa/dial.nvim` | 增强递增/递减 |
| `andymass/vim-matchup` | 增强 % 匹配跳转 |

### 语法与 LSP

| 插件 | 说明 |
| --- | --- |
| `nvim-treesitter/nvim-treesitter` | 语法高亮、增量选择、文本对象 |
| `neovim/nvim-lspconfig` | LSP 配置 |
| `mfussenegger/nvim-jdtls` | Java LSP（JDTLS 专用） |
| `saghen/blink.cmp` | 自动补全 |
| `rafamadriz/friendly-snippets` | 代码片段集合 |

### 工具

| 插件 | 说明 |
| --- | --- |
| `echasnovski/mini.files` | 文件管理器（Miller columns 风格） |
| `echasnovski/mini.pick` | 模糊搜索 |
| `akinsho/toggleterm.nvim` | 浮动终端 |
| `lewis6991/gitsigns.nvim` | Git 行内标记与 hunk 操作 |
| `stevearc/conform.nvim` | 代码格式化 |

## 快捷键说明

`<leader>` 为空格键。

### 窗口管理

| 快捷键 | 说明 |
| --- | --- |
| `wa` | 左右分屏，光标留在左侧 |
| `wd` | 左右分屏，光标留在右侧 |
| `ww` | 上下分屏，光标留在上方 |
| `ws` | 上下分屏，光标留在下方 |
| `wq` | 关闭当前窗口 |
| `we` | 关闭其他窗口 |
| `wt` | 切换窗口 |
| `wh` `wj` `wk` `wl` | 在窗口间移动 |
| `wmh` `wml` `wmk` `wmj` | 调整窗口大小 |

### 光标与文本操作

| 快捷键 | 说明 |
| --- | --- |
| `J` / `K` | 上下移动 5 行 |
| `H` / `L` | 左右移动 5 列 |
| `,` / `.` | 跳到行首 / 行尾 |
| `d.` `d,` | 删除到行尾 / 行首 |
| `y.` `y,` | 复制到行尾 / 行首 |
| `Y` | 复制到系统剪贴板 |
| `P` | 从系统剪贴板粘贴 |
| `U` | 还原上一步 |
| `=` / `-` | 当前数字加 1 / 减 1 |
| `s` | Leap 跳转 |
| `S` | Leap 跨窗口跳转 |
| `gS` | 单行/多行切换 |

### Buffer

| 快捷键 | 说明 |
| --- | --- |
| `<leader>bj` / `<leader>bk` | 下/上一个 buffer |
| `<leader>bq` | 关闭当前 buffer |
| `<leader>b>` / `<leader>b<` | 移动 buffer 位置 |
| `<leader>bp` | 固定/取消固定 buffer |
| `<leader>bo` | 关闭其他 buffer |
| `<leader>bs` | 选择 buffer |
| `<leader>1` ~ `<leader>5` | 跳转到指定 buffer |
| `<BS>` / `<S-BS>` | 上/下一个光标位置 |

### 搜索（mini.pick）

| 快捷键 | 说明 |
| --- | --- |
| `<leader>ff` | 搜索文件 |
| `<leader>fg` | 搜索内容（live grep） |
| `<leader>fw` | 搜索光标词 |
| `<leader>fb` | 搜索 Buffer |
| `<leader>fh` | 搜索帮助 |
| `<leader>fr` | 恢复上次搜索 |

### 文件管理（mini.files）

| 快捷键 | 说明 |
| --- | --- |
| `<leader>e` | 打开文件树（定位当前文件） |
| `<leader>E` | 打开文件树（项目根目录） |
| 树内 `l` / `<CR>` | 进入目录或打开文件 |
| 树内 `h` / `H` | 返回上级目录 |

### LSP

| 快捷键 | 说明 |
| --- | --- |
| `gd` | 跳转定义 |
| `gD` | 跳转声明 |
| `gr` | 查看引用 |
| `gi` | 跳转实现 |
| `gh` | 悬停文档 |
| `<leader>lr` | 重命名 |
| `<leader>la` | 代码操作 |
| `<leader>ld` | 行内诊断 |
| `<leader>lf` | 格式化 |
| `[d` / `]d` | 上/下一个诊断 |

### Java（nvim-jdtls）

| 快捷键 | 说明 |
| --- | --- |
| `<leader>jo` | 整理 imports |
| `<leader>jv` | 提取变量 |
| `<leader>jc` | 提取常量 |
| `<leader>jt` | 测试当前方法 |
| `<leader>jT` | 测试当前类 |

### Git（gitsigns）

| 快捷键 | 说明 |
| --- | --- |
| `]h` / `[h` | 下/上一个 hunk |
| `<leader>gs` | 暂存 hunk |
| `<leader>gr` | 还原 hunk |
| `<leader>gS` / `<leader>gR` | 暂存/还原整个文件 |
| `<leader>gu` | 撤销暂存 |
| `<leader>gp` | 预览 hunk |
| `<leader>gb` | blame 当前行 |
| `<leader>gd` | diff 当前文件 |
| `<leader>gt` | 显示/隐藏已删除行 |

### 终端（toggleterm）

| 快捷键 | 说明 |
| --- | --- |
| `<leader>tt` | 浮动终端 |
| `<leader>th` | 底部终端 |
| `<leader>tv` | 侧边终端 |
| `<leader>tg` | LazyGit |

### 补全（blink.cmp）

| 快捷键 | 说明 |
| --- | --- |
| `<CR>` | 确认选中项 |
| `<C-j>` / `<C-k>` | 上下选择 |
| `<C-d>` / `<C-u>` | 滚动文档 |
| `<Tab>` / `<S-Tab>` | snippet 跳转占位符 |

### 插入模式增强

| 快捷键 | 说明 |
| --- | --- |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | 插入模式下方向移动 |
| `<C-o>` | 在下方新开一行并进入插入 |
| `<C-;>` | 跳到行首插入 |
| `<C-'>` | 跳到行尾插入 |
| `<C-e>` | 跳到单词末尾插入 |
| `<C-b>` | 跳到单词开头插入 |

### 其他

| 快捷键 | 说明 |
| --- | --- |
| `qa` | 退出 Neovim |
| `q1` | 强制退出 |
| `qw` | 保存并退出 |
| `<leader>nh` | 清除搜索高亮 |
| 可视模式 `/` | 搜索选中文本 |
| `<leader>rr` | 重新加载配置 |
| `<leader>?` | 查看 Buffer 本地快捷键 |
| `]]` / `[[` | 下/上一个引用（illuminate） |

## 安装

### 系统依赖

```bash
# 必须
brew install neovim git

# LSP
brew install lua-language-server jdtls

# 搜索（推荐）
brew install ripgrep fd

# 格式化（按需）
brew install stylua google-java-format
npm install -g prettier

# Git（可选）
brew install lazygit
```

### 安装配置

```bash
git clone <your-repo-url> ~/.config/nvim
```

首次启动 Neovim 时，`lazy.nvim` 会自动安装所有插件。

![Neovim Logo](https://raw.githubusercontent.com/neovim/neovim/master/runtime/nvim.png)

