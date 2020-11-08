
# 我的 Neovim 配置

这是我使用的的 Neovim 配置，大部分参考 [@theniceboy](https://github.com/theniceboy) 和 [@KiteAB](https://github.com/KiteAB)

## 安装此配置后你需要做的事

### 首先

执行 `:checkhealth` 检查配置问题，问题解决方法 [checkhealth](./checkhealth.md)

### 配置 Python Ruby 路径

确保你安装了 Python Ruby
查看新建 `_machine_specific.vim` 文件，输入 Python 和 Ruby 对应的路径，下面仅供参考

```vim
" python2
let g:python_host_prog="/usr/bin/python2"
" python3
let g:python3_host_prog="/usr/bin/python3"
" ruby
let g:ruby_host_prog = "~/.gem/ruby/2.7.0/bin/neovim-ruby-host"
```

### FZF

安装 fzf

### GO

执行 `:GoInstallBinaries` 安装 `GO` 开发插件 

## 插件

+ [dracula/vim](https://github.com/dracula/vim) dracula 主题

+ [kjwon15/vim-transparent](https://github.com/kjwon15/vim-transparent) 透明 vim 插件

+ [bling/vim-bufferline](https://github.com/bling/vim-bufferline) 命令栏中显示 buffer 列表

+ [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline) buffer 状态栏主题

+ [vim-airline/vim-airline-themes](https://github.com/vim-airline/vim-airline-themes) buffer 配色

+ [junegunn/fzf.vim](https://github.com/junegunn/fzf.vim) 搜索文件 FZF

+ [mbbill/undotree](https://github.com/mbbill/undotree) 文件状态历史

+ [mg979/vim-visual-multi](https://github.com/mg979/vim-visual-multi) 多光标操作文件

+ [airblade/vim-gitgutter](https://github.com/airblade/vim-gitgutter) GIT 显示修改当前版本位置

+ [junegunn/vim-easy-align](https://github.com/junegunn/vim-easy-align) 自动对齐

+ [lambdalisue/suda.vim](https://github.com/lambdalisue/suda.vim) 执行 :sudowrite 或者 :sw 可以保存需要权限的文件

+ [elzr/vim-json](https://github.com/elzr/vim-json) JSON 高亮

+ [othree/html5.vim](https://github.com/othree/html5.vim) HTML 语法

+ [alvan/vim-closetag](https://github.com/alvan/vim-closetag) html 自动闭合标签

+ [yuezk/vim-js](https://github.com/yuezk/vim-js) javascript  语法高亮插件

+ [maxmellon/vim-jsx-pretty](https://github.com/maxmellon/vim-jsx-pretty) jsx 语法高亮和缩进插件

+ [HerringtonDarkholme/yats.vim](https://github.com/HerringtonDarkholme/yats.vim) TypeScript语法

+ [posva/vim-vue](https://github.com/posva/vim-vue) vue 语法高亮

+ [fatih/vim-go](https://github.com/fatih/vim-go) Go 语法

+ [Vimjas/vim-python-pep8-indent](https://github.com/Vimjas/vim-python-pep8-indent) Python 缩进

+ [numirias/semshi](https://github.com/numirias/semshi) Python 语义突出显示功能

+ [tweekmonster/braceless.vim](https://github.com/tweekmonster/braceless.vim) Python 折叠 有点智能自动缩进

+ [suan/vim-instant-markdown](https://github.com/suan/vim-instant-markdown) Markdown 预览

+ [dhruvasagar/vim-table-mode](https://github.com/dhruvasagar/vim-table-mode) 自动创建表和格式化表

+ [dart-lang/dart-vim-plugin](https://github.com/dart-lang/dart-vim-plugin) Dart 提供文件类型检测 语法突出显示

+ [Chiel92/vim-autoformat](https://github.com/Chiel92/vim-autoformat) AutoFormat  格式化

+ [neoclide/coc.nvim](https://github.com/neoclide/coc.nvim) Coc

+ [liuchengxu/vista.vim](https://github.com/liuchengxu/vista.vim) 显示函数与变量列表

+ [honza/vim-snippets](https://github.com/honza/vim-snippets) 代码补全

## 快捷键

#### nvim 映射模式

| 字符 | 模式                                        |
| ---  | ----                                        |
| ` `  | 普通、可视、选择和操作符等待                |
| `n`  | 普通                                        |
| `v`  | 可视和选择                                  |
| `s`  | 选择                                        |
| `x`  | 可视                                        |
| `o`  | 操作符等待                                  |
| `!`  | 插入和命令行                                |
| `i`  | 插入                                        |
| `l`  | 插入、命令行和 Lang-Arg 模式的 ":lmap" 映射 |
| `c`  | 命令行                                      |
| `t`  | 终端作业                                    |


## 自定义 nvim 快捷键

| 快捷键             | 行为                           | 模式    | 原来需要操作的输入                                    |
| ------             | ----                           | ----    | ------------------                                    |
| ` `                | `<leader>` 改为空格            | ` `     | `<leader>`                                            |
| `;`                | `;` 改为 `:`                   | ` `     | `:`                                                   |
| `U`                | 还原上一步操作                 | ` `     | `<C-r>`                                               |
| `<C-q>`            | 退出                           | `n`     | `Esc` `:q<CR>`                                        |
| `<C-s>`            | 保存                           | `n`     | `Esc` `:w<CR>`                                        |
| `K`                | 向上移动 5 格                  | ` `     | `5k`                                                  |
| `J`                | 向下移动 5 格                  | ` `     | `5j`                                                  |
| `leader` `CR`      | 清除搜索高亮                   | `n`     | `:nohlsearch<CR>`                                     |
| `<`                | 反向缩进                       | ` `     | `<<`                                                  |
| `>`                | 缩进                           | ` `     | `>>`                                                  |
| `Y`                | 从当前复制到行尾               | `n`     | `y$`                                                  |
| `Y`                | 复制选中文本至系统剪切板       | `v`     | `"+y`                                                 |
| `D`                | 从当前剪切到行尾               | `n`     | `d$`                                                  |
| `D`                | 剪切选中文本至系统剪切板       | `v`     | `"+d`                                                 |
| `P`                | 从系统剪切板上粘贴到文件中     | `n`     | `"+p`                                                 |
| `<leader>/`        | 在当前窗口下方新建一个终端窗口 | `n`     | `:set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>`  |
| `<leader><leader>` | 删除下一个 <++> 并进入插入模式 | `n`     | `/<++><CR>:nohlsearch<CR>c4l`                         |
| `\s`               | 查找和替换                     | `n`     | `:%s//g<left><left>`                                  |
| `<C-r>`            | 更新 nvim 配置                 | `n`     | `:source $MYVIMRC<CR>`                                |
| `<C-q>`            | 退出终端                       | `t`     | `<C-\><C-n><Esc>:q<CR>`                               |
| `<C-n>`            | 退出终端输入模式                       | `t`     | `<C-\><C-n>`                                          |
| `<C-o>`            | 返回打开终端的文件             | `t`     | `<C-\><C-n><C-o>`                                     |
| `r`                | 编译 预览                      | `n`     |                                                       |
| `<leader>ip`       | 安装插件                       | `n`     | `:PlugInstall<CR>`                                    |
| `<leader>j`        | 切换到下面窗口                 | `n`     | `<C-w>j`                                              |
| `<leader>k`        | 切换到上面窗口                 | `n`     | `<C-w>k`                                              |
| `<leader>h`        | 切换到左边窗口                 | `n`     | `<C-w>h`                                              |
| `<leader>l`        | 切换到右边窗口                 | `n`     | `<C-w>l`                                              |
| `<leader>x`        | 窗口互换，下 -> 上 -> 右 -> 左 | `n`     | `<C-w>x`                                              |
| `<leader>m`        | 窗口选择切换                   | `n`     | `<C-w>w`                                              |
| `<leader>H`        | 垂直布局                       | `n`     | `<C-w>H`                                              |
| `<leader>J`        | 水平布局                       | `n`     | `<C-W>J`                                              |
| `<leader>q`        | 关闭其他窗口                   | `n`     | `<C-w>o`                                              |
| `<leader>w`        | 在下方新建窗口 选中当前窗口    | `n`     | `:set nosplitbelow<cr>:split<cr>:set splitbelow<cr>`  |
| `<leader>s`        | 在下方新建窗口 选中新窗口      | `n`     | `:set splitbelow<CR>:split<CR>`                       |
| `<leader>a`        | 在右边新建窗口 选中当前窗口    | `n`     | `:set nosplitbelow<cr>:vsplit<cr>:set splitbelow<cr>` |
| `<leader>d`        | 在右边新建窗口 选中新窗口      | `n`     | `:set splitbelow<CR>:vsplit<CR>`                      |
| `<leader>n`        | 下一个 buffer                  | `n`     | `:bn<CR>`                                             |
| `<leader>p`        | 上一个 buffer                  | `n`     | `:bp<CR>`                                             |
| `<leader>e`        | 打开新 buffer                  | `n`     | `:badd `                                              |
| `<leader>b`        | 关闭当前 buffer                | `n`     | `:bd<CR>`                                             |
| `.k`               | 上一个 tab                     | `n`     | `:-tabnext<CR>`                                       |
| `.j`               | 下一个 tab                     | `n`     | `:+tabnext<CR>`                                       |
| `.h`               | 左移 tab                       | `n`     | `:-tabmove<CR>`                                       |
| `.l`               | 右移 tab                       | `n`     | `:+tabmove<CR>`                                       |
| `.e`               | 打开新 tab                     | `n`     | `:tabe<CR>`                                           |
| `<A-;>`            | `0`                            | ` ` `!` | 0                                                     |
| `<A-a>`            | `1`                            | ` ` `!` | 1                                                     |
| `<A-s>`            | `2`                            | ` ` `!` | 2                                                     |
| `<A-d>`            | `3`                            | ` ` `!` | 3                                                     |
| `<A-f>`            | `4`                            | ` ` `!` | 4                                                     |
| `<A-g>`            | `5`                            | ` ` `!` | 5                                                     |
| `<A-h>`            | `6`                            | ` ` `!` | 6                                                     |
| `<A-j>`            | `7`                            | ` ` `!` | 7                                                     |
| `<A-k>`            | `8`                            | ` ` `!` | 8                                                     |
| `<A-l>`            | `9`                            | ` ` `!` | 9                                                     |
| `<A-q>`            | `<Home>`                       | ` ` `!` | `<Home>`                                              |
| `<A-e>`            | `<End>`                        | ` ` `!` | `<End>`                                               |
| `<A-n>`            | `<Left>`                       | ` ` `!` | `<Left>`                                              |
| `<A-m>`            | `<Right>`                      | ` ` `!` | `<Right>`                                             |
| `<A-v>`            | `<Up>`                         | ` ` `!` | `<Up>`                                                |
| `<A-b>`            | `<Down>`                       | ` ` `!` | `<Down>`                                              |
| `<A-q>`            | `!`                            | ` ` `!` | `!`                                                   |
| `<A-w>`            | `@`                            | ` ` `!` | `@`                                                   |
| `<A-e>`            | `#`                            | ` ` `!` | `#`                                                   |
| `<A-r>`            | `$`                            | ` ` `!` | `$`                                                   |
| `<A-t>`            | `%`                            | ` ` `!` | `%`                                                   |
| `<A-y>`            | `^`                            | ` ` `!` | `^`                                                   |
| `<A-u>`            | `&`                            | ` ` `!` | `&`                                                   |
| `<A-i>`            | `*`                            | ` ` `!` | `*`                                                   |
| `<A-o>`            | `(`                            | ` ` `!` | `(`                                                   |
| `<A-p>`            | `)`                            | ` ` `!` | `)`                                                   |


## 插件快捷键

### junegunn/fzf.vim

搜索文件 FZF

- [ ] 确定你已经安装了 fzf

#### 快捷键

| 快捷键  | 行为                                 | 插件      | 模式  |
| ------  | ----                                 | -----     | ----- |
| `<C-f>` | 打开搜索文件 `fzf`                   | `fzf.vim` | `n`   |
| `<C-t>` | `fzf` 插件中使用，在 `tab` 打开文件  | `fzf.vim` | `fzf` |
| `<C-x>` | `fzf` 插件中使用，在下方分屏打开文件 | `fzf.vim` | `fzf` |
| `<C-t>` | `fzf` 插件中使用，在右边分屏打开文件 | `fzf.vim` | `fzf` |
| `<C-j>` | `fzf` 插件中使用，选择下一个文件     | `fzf.vim` | `fzf` |
| `<C-k>` | `fzf` 插件中使用，选择上一个文件     | `fzf.vim` | `fzf` |

### mbbill/undotree

文件状态历史

#### 快捷键

| 快捷键 | 行为                        | 插件       | 模式       |
| ------ | ----                        | -----      | -----      |
| `L`    | 打开和关闭文件状态修改历史  | `undotree` | ` `        |
| `?`    | `undotree` 插件中使用，帮助 | `undotree` | `undotree` |
| `j`    | 下一个修改历史              | `undotree` | `undotree` |
| `k`    | 上一个修改历史              | `undotree` | `undotree` |
| `J`    | 下 `5` 个修改历史           | `undotree` | `undotree` |
| `K`    | 上 `5` 个修改历史           | `undotree` | `undotree` |

### mg979/vim-visual-multi

多光标操作文件

#### 快捷键

| 快捷键      | 行为                             | 插件               | 模式                   |
| -           | -                                | -----              | ----                   |
| `<C-n>`     | 选择当前单词或者下一个相同的单词 | `vim-visual-multi` | ` ` `vim-visual-multi` |
| `<C-Down>`  | 垂直向下选择一个字符             | `vim-visual-multi` | ` ` `vim-visual-multi` |
| `<C-Up>`    | 垂直向上选择一个字符             | `vim-visual-multi` | ` ` `vim-visual-multi` |
| `<S-Left>`  | 向左选择一个字符                 | `vim-visual-multi` | ` ` `vim-visual-multi` |
| `<S-Right>` | 向右选择一个字符                 | `vim-visual-multi` | ` ` `vim-visual-multi` |
| `n`         | 获取下一个出现的位置             | `vim-visual-multi` | `vim-visual-multi`     |
| `N`         | 获取上一个出现的位置             | `vim-visual-multi` | `vim-visual-multi`     |
| `[`         | 跳转到下一次选择位置             | `vim-visual-multi` | `vim-visual-multi`     |
| `]`         | 跳转到上一次选择位置             | `vim-visual-multi` | `vim-visual-multi`     |
| `q`         | 跳过当前并获得下一次出现         | `vim-visual-multi` | `vim-visual-multi`     |
| `Q`         | 取消当前选择                     | `vim-visual-multi` | `vim-visual-multi`     |
| `r`         | 替换字符                         | `vim-visual-multi` | `vim-visual-multi`     |

### junegunn/vim-easy-align

自动对齐

#### 快捷键

| 快捷键 | 行为     | 插件             | 模式    |
| ------ | ----     | -----            | ----    |
| `ga`   | 自动对齐 | `vim-easy-align` | `n` `x` |

### lambdalisue/suda.vim

执行 :sudowrite 或者 :sw 可以保存需要权限的文件

### tweekmonster/braceless.vim

Python 折叠 有点智能自动缩进

#### 快捷键

| 快捷键 | 行为                              | 插件            | 模式            |
| ------ | ----                              | -----           | -----           |
| `[[`   | 移动到上一个块                    | `braceless.vim` | `n`             |
| `]]`   | 移动到下一个块                    | `braceless.vim` | `n`             |
| `[m`   | 移动到上一个 `def` `class`        | `braceless.vim` | `braceless.vim` |
| `]m`   | 移动到下一个 `def` `class`        | `braceless.vim` | `braceless.vim` |
| `[M`   | 移动到上一个 `def` `class` 的末尾 | `braceless.vim` | `braceless.vim` |
| `]M`   | 移动到下一个 `def` `class` 的末尾 | `braceless.vim` | `braceless.vim` |

### dhruvasagar/vim-table-mode

自动创建表和格式化表

#### 快捷键

| 快捷键       | 行为         | 插件             |  模式  |
| ------       | ----         | -----            |  ----- |
| `<leader>tm` | 开关表格模式 | `vim-table-mode` |  `n`   |
| `<leader>tr` | 重组表格     | `vim-table-mode` |  `n`   |


### Chiel92/vim-autoformat

AutoFormat  格式化

#### 快捷键

| 快捷键 | 行为   | 插件             | 模式  |
| ------ | ----   | -----            | ----- |
| `\f`   | 格式化 | `vim-autoformat` | `n`   |

### neoclide/coc.nvim

Coc

#### 快捷键

| 快捷键         | 行为                 | 插件                        | 模式  |
| ------         | ----                 | -----                       | ----- |
| `<leader>` `-` | 查看上一个报错       | `coc.nvim`                  | `n`   |
| `<leader>` `+` | 查看下一个报错       | `coc.nvim`                  | `n`   |
| `g` `d`        | 列出变量定义列表     | `coc.nvim`                  | `n`   |
| `g` `i`        | 跳转当前实现位置     | `coc.nvim`                  | `n`   |
| `g` `y`        | 转至类型定义         | `coc.nvim`                  | `n`   |
| `g` `r`        | 跳转到当前变量的引用 | `coc.nvim`                  | `n`   |
| `r` `n`        | 重命名变量           | `coc.nvim`                  | `n`   |
| `<A-Tab>`      | 下一个补全代码       | `coc.nvim`                  | `i`   |
| `<S-Tab>`      | 上一个补全代码       | `coc.nvim`                  | `i`   |
| `<C-g>`        | 调出补全             | `coc.nvim`                  | `i`   |
| `t` `t`        | 文件系统浏览器       | `coc.nvim` `coc-explorer`   | `n`   |
| `t` `s`        | 翻译                 | `coc.nvim` `coc-translator` | `n`   |
| `<C-j>`        | 下一个占位符         | `coc.nvim` `coc-snippets`   | `i`   |
| `<C-k>`        | 上一个占位符         | `coc.nvim` `coc-snippets`   | `i`   |

### liuchengxu/vista.vim

显示函数与变量列表

#### 快捷键

| 快捷键         | 行为                 | 插件                      | 模式  |
| ------         | ----                 | -----                     | ----- |
| `<leader>` `v` |  查看函数与变量列表      | `vista.nvim`                | `n`   |
| `<C-t>` |  筛选函数与变量列表      | `vista.nvim`                | `n`   |
