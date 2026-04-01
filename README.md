# Neovim 配置

一套以 `lazy.nvim` 为插件管理器的轻量 Neovim 配置，当前重点放在基础编辑体验、快捷键组织和 UI 美化上。

目前已经完成的部分包括：

- 基础编辑选项
- 自定义快捷键体系
- 主题与状态栏
- 彩虹缩进线
- 插件自动安装与锁定

## 目录结构

```text
.
├── init.lua
├── lazy-lock.json
└── lua
    ├── config
    │   ├── keymaps.lua
    │   ├── lazy.lua
    │   └── options.lua
    ├── core
    │   ├── keymap.lua
    │   └── text.lua
    └── plugins
        ├── common.lua
        └── ui.lua
```

## 配置入口

- `init.lua`
  按顺序加载基础选项、快捷键和插件管理。
- `lua/config/options.lua`
  管理编辑器基础行为，比如编码、缩进、搜索、行号、剪贴板相关显示等。
- `lua/config/keymaps.lua`
  集中管理自定义按键映射。
- `lua/config/lazy.lua`
  负责安装并初始化 `lazy.nvim`。
- `lua/core/keymap.lua`
  对 `vim.keymap.set` 做了一层简单封装，便于统一注册快捷键。
- `lua/core/text.lua`
  提供选中文本读取等小工具函数。
- `lua/plugins/*.lua`
  按模块拆分插件配置。

## 当前功能

### 基础编辑体验

- 使用 `UTF-8` 编码
- 显示绝对行号和相对行号
- 高亮当前行
- 上下滚动时保留边距
- 使用 2 空格缩进，`Tab` 自动展开为空格
- 搜索默认忽略大小写，输入大写时自动区分大小写
- 启用增量搜索与搜索高亮
- 禁用备份文件和交换文件
- 启用 24 位真彩色
- 显示 `signcolumn`
- `colorcolumn` 设置为 `100`
- 可视化空格与制表符

### UI 插件

当前启用的插件包括：

- `folke/tokyonight.nvim`
  使用 `night` 风格，启用透明背景。
- `lukas-reineke/indent-blankline.nvim`
  使用彩虹色缩进线，并启用作用域高亮。
- `nvim-lualine/lualine.nvim`
  提供全局状态栏，显示模式、分支、诊断、文件名、编码、进度和光标位置。
- `nvim-lua/plenary.nvim`
  通用 Lua 工具库，供其他插件使用。

### 插件管理

- 通过 `lazy.nvim` 自动安装缺失插件
- 使用 `lazy-lock.json` 锁定插件版本
- 启用插件更新检查
- 支持配置变更检测

## 快捷键说明

`<leader>` 被设置为空格键。

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

### Buffer 与跳转

| 快捷键 | 说明 |
| --- | --- |
| `<leader>bj` | 下一个 buffer |
| `<leader>bk` | 上一个 buffer |
| `<leader>bq` | 关闭当前 buffer |
| `<BS>` | 跳回上一个光标位置 |
| `<S-BS>` | 跳到下一个光标位置 |
| `<tab>` | 作为 mark 键 |
| `<tab><tab>` | 在标记位置间切换 |

### 退出与保存

| 快捷键 | 说明 |
| --- | --- |
| `qa` | 退出 Neovim |
| `q1` | 强制退出 Neovim |
| `qw` | 保存并退出 |

### 插入模式增强

| 快捷键 | 说明 |
| --- | --- |
| `<C-h>` `<C-j>` `<C-k>` `<C-l>` | 插入模式下方向移动 |
| `<C-o>` | 在下方新开一行并进入插入 |
| `<C-;>` | 跳到行首插入 |
| `<C-'>` | 跳到行尾插入 |
| `<C-e>` | 跳到单词末尾插入 |
| `<C-b>` | 跳到单词开头插入 |

### 搜索与配置重载

| 快捷键 | 说明 |
| --- | --- |
| `<leader>nh` | 清除搜索高亮 |
| 可视模式下 `/` | 搜索当前选中文本 |
| `<leader>rr` | 重新加载当前 Neovim 配置 |

## 安装方式

确保本机已安装：

- `Neovim` 0.9+
- `git`

然后将配置放到默认目录：

```bash
git clone <your-repo-url> ~/.config/nvim
```

首次启动 Neovim 时，`lazy.nvim` 会自动安装自身并拉取插件。

## 说明

这份配置目前偏向“可用的基础骨架”，适合继续往下扩展，例如：

- LSP
- 自动补全
- Treesitter
- 文件树
- Telescope
- Git 集成

如果后续继续扩展，建议仍然保持现在这种分层方式：

- `config` 放基础配置
- `core` 放工具封装
- `plugins` 按功能拆分插件
