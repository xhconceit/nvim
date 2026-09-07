# NVI

一个按清洁架构组织的 Neovim 配置。

## 使用

入口是 `init.lua`。首次启动会通过 lazy.nvim 安装插件；Treesitter 需要可用的 C 编译器、`tar`、`curl` 和 `tree-sitter` CLI。

运行测试：

```bash
make test
```

## 常用快捷键

Leader 键为空格：

| 快捷键 | 功能 |
| --- | --- |
| `<leader>ff` | 查找文件 |
| `<leader>fg` | 全文搜索 |
| `<leader>ef` | 打开当前文件所在目录 |
| `<leader>ts` | 打开水平终端 |
| `<leader>tv` | 打开垂直终端 |
| `<leader>bj` / `<leader>bk` | 下一个 / 上一个 Buffer |
| `<leader>bq` | 关闭当前 Buffer |
| `<leader>tn` / `<leader>tc` | 新建 / 关闭 Tab |
| `<leader>ss` / `<leader>sl` | 保存 / 恢复项目会话 |
| `<leader>sd` | 删除项目会话 |
| `<leader>xo` / `<leader>xc` | 打开 / 关闭 Quickfix |
| `]q` / `[q` | 下一个 / 上一个 Quickfix 项 |
| `]h` / `[h` | 下一个 / 上一个 Git 变更块 |
| `<leader>cf` | 格式化当前 Buffer |

终端模式中使用 `<Esc><Esc>` 返回 Normal 模式。

## 架构

```text
features → ports ← adapters
                         ↓
                 Neovim / plugins
```

- `lua/nvi/features/`：用户用例和快捷键
- `lua/nvi/ports/`：适配器契约
- `lua/nvi/adapters/`：Neovim 或插件实现
- `lua/nvi/infrastructure/`：插件与 LSP 基础设施
- `lua/nvi/core/`：选项、命令、自动命令和项目根识别
- `lua/nvi/init.lua`：组合根，负责依赖注入

