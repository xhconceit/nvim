# 我的 Neovim 配置

这是我使用的的 Neovim 配置，大部分参考 [@theniceboy](https://github.com/theniceboy) 和 [@KiteAB](https://github.com/KiteAB)

## 检查配置问题

执行 `:checkhealth` 检查配置问题

### Clipboard (optional)

报错：

```
## Clipboard (optional)
  - WARNING: No clipboard tool found. Clipboard registers (`"+` and `"*`) will not work.
    - ADVICE:
      - :help clipboard


```

解决：

```shell
sudo pacman -S clipmenu
```

### Python 2 provider (optional)

报错：

```
## Python 2 provider (optional)
  - WARNING: No Python executable found that can `import neovim`. Using the first available executable for diagnostics.
  - ERROR: Python provider error:
    - ADVICE:
      - provider/pythonx: Could not load Python 2:
          python2 not found in search path or not executable.
          python2.7 not found in search path or not executable.
          python2.6 not found in search path or not executable.
          /usr/bin/python is Python 3.8 and cannot provide Python 2.
  - INFO: Executable: Not found
```

解决：

```shell
sudo pacman -S python2
sudo pacman -S python2-pip
pip2 install pynvim
pip2 install neovim
```

设置 python2 安装位置

```vim
let g:python_host_prog=/usr/bin/python2
```

### Python 3 provider (optional)

报错：

```
## Python 3 provider (optional)
  - WARNING: No Python executable found that can `import neovim`. Using the first available executable for diagnostics.
  - ERROR: Python provider error:
    - ADVICE:
      - provider/pythonx: Could not load Python 3:
          /usr/bin/python3 does not have the "neovim" module. :help provider-python
          python3.7 not found in search path or not executable.
          python3.6 not found in search path or not executable.
          python3.5 not found in search path or not executable.
          python3.4 not found in search path or not executable.
          python3.3 not found in search path or not executable.
          /usr/bin/python does not have the "neovim" module. :help provider-python
  - INFO: Executable: Not found
```

解决：

```shell
sudo pacman -S python
sudo pacman -S python-pip
pip install pynvim
pip install neovim
```

设置 python3 安装位置

```vim
let g:python3_host_prog = "/usr/bin/python3"
```

### Ruby provider (optional)

报错：

```
## Ruby provider (optional)
  - WARNING: `neovim-ruby-host` not found.
    - ADVICE:
    - Run `gem install neovim` to ensure the neovim RubyGem is installed.
    - Run `gem environment` to ensure the gem bin directory is in $PATH.
    - If you are using rvm/rbenv/chruby, try "rehashing".
    - See :help g:ruby_host_prog for non-standard gem installations.
```

解决：

```shell
sudo pacman -S ruby	# 安装 ruby
gem sources --remove https://rubygems.org/	# 移除 https://rubygems.org/ 源
gem sources -a https://gems.ruby-china.com/	#设置国内镜像源 https://gems.ruby-china.com/
gem install neovim
```

设置 neovim-ruby-host 安装位置

```
let g:ruby_host_prog = '~/.gem/ruby/2.7.0/bin/neovim-ruby-host'
```

### Node.js provider (optional)

报错：

```
## Node.js provider (optional)
  - INFO: Node.js: v14.14.0
  - WARNING: Missing "neovim" npm (or yarn) package.
    - ADVICE:
      - Run in shell: npm install -g neovim
      - Run in shell (if you use yarn): yarn global add neovim
```

解决：

```shell
sudo pacman -S nodejs	# 安装 nodejs
sudo pacman -S npm	# 安装 npm
sudo npm install -g neovim --registry=https://registry.npm.taobao.org	# 使用淘宝源安装 neovim 模块
```

## nvim 快捷键

| 快捷键     | 行为                                                        |
| ------     | ----                                                        |
| `k`        | 将光标向上移动一行                                          |
| `j`        | 将光标向下移动一行                                          |
| `h`        | 将光标向左移动一格                                          |
| `l`        | 将光标向右移动一格                                          |
| `c`        | 移除当前文本到寄存器，且进入插入模式                        |
| `d`        | 移除当前文本到寄存器                                        |
| `y`        | 复制当前文本到寄存器                                        |
| `~`        | 变换大小写(不需要等待操作)                                  |
| `g` `~`    | 变换大小写                                                  |
| `g` `u`    | 变为小写                                                    |
| `g` `U`    | 变为大写                                                    |
| `!`        | 使用外部程序                                                |
| `0`        | 移动光标到当前行首个字符                                    |
| `^`        | 移动光标到当前行首个非空白字符                              |
| `$`        | 移动光标到当前行最后一个字符                                |
| `g` `_`    | 移动光标到当前行最后一个非空白字符                          |
| `_`        | 移动光标到当前行首个非空白字符                              |
| `g` `0`    | 移动光标到当前屏幕上显示行的首个字符，和 `0` 有所不同       |
| `g` `^`    | 移动光标到当前屏幕上显示行的首个非空白字符，和 `^` 有所不同 |
| `g` `m`    | 尽可能将光标右移到当前屏幕显示宽度的中间位置                |
| `g` `M`    | 以百分比方式将光标右移到当前屏幕显示宽度的位置              |
| `g` `$`    | 移动光标到当前屏幕上显示行的最后一个字符                    |
| `          | `                                                           |
| `f`        | 当前行向右侧搜索字符                                        |
| `F`        | 当前行向左侧搜索字符                                        |
| `t`        | 当前行向右侧搜索字符,光标在搜索到字符的前一个字符           |
| `T`        | 当前行向左侧搜索字符,光标在搜索到字符的前一个字符           |
| `;`        | 重复上次的 `f` 、`t` 、`F` 或者 `T` 命令                    |
| `,`        | 反方向重复上次的 `f` 、`t` 、`F` 或者 `T` 命令              |
| `g` `k`    | 移动光标到当前屏幕上显示行的上一行                          |
| `g` `j`    | 移动光标到当前屏幕上显示行的下一行                          |
| `-`        | 移动光标到上一行的首个非空白字符                            |
| `+`        | 移动光标到下一行的首个非空白字符                            |
| `Ctrl` `M` | 移动光标到下一行的首个非空白字符                            |
| `Enter`    | 移动光标到下一行的首个非空白字符                            |
| `G`        | 到第几行，默认最后一行                                      |
| `%`        | 到文件的百分比处并停在行的首个非空白字符上                  |
| `w`        | 下一个单词，光标在首字母                                    |
| `e`        | 当前单词或者下一个单词的最后一个字母                        |
| `b`        | 上一个单词，光标在首字母                                    |
| `g` `e`    | 上一个单词，光标在最后一个字母                              |
| `(`        | 上一个句子                                                  |
| `)`        | 下一个句子                                                  |
| `{`        | 上一个段落                                                  |
| `}`        | 下一个段落                                                  |
| `m`        | 位置标记                                                    |
| \`         | 到达标记                                                    |



## 映射模式


| 字符 | 模式                                        |
| ---  | ----                                        |
| ` `  | 普通、可视、选择和操作符等待
| `n`  | 普通
| `v`  | 可视和选择
| `s`  | 选择
| `x`  | 可视
| `o`  | 操作符等待
| `!`  | 插入和命令行
| `i`  | 插入
| `l`  | 插入、命令行和 Lang-Arg 模式的 ":lmap" 映射
| `c`  | 命令行
| `t`  | 终端作业

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
| `<C-n>`            | 编辑终端                       | `t`     | `<C-\><C-n>`                                          |
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

## 安装 vim-plug

```shell
# github
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.config}"/nvim/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# jsdelivr CDN
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.config}"/nvim/autoload/plug.vim --create-dirs \
       https://cdn.jsdelivr.net/gh/junegunn/vim-plug/plug.vim'

```

## vim plug 配置

安装 `plug` 需要在 `call plug#begin('~/.vim/plugged')` `call plug#end()` 安装

### dracula/vim

dracula 主题

#### 安装

```vim
Plug 'dracula/vim', { 'as': 'dracula' }
```

#### 配置

```vim
colorscheme dracula
```


### kjwon15/vim-transparent

透明 vim 插件

#### 安装

```vim
Plug 'kjwon15/vim-transparent'
```

### bling/vim-bufferline

命令栏中显示 buffer 列表

#### 安装

```vim
Plug 'bling/vim-bufferline'
```

### vim-airline/vim-airline

buffer 状态栏主题

#### 安装

```vim
Plug 'vim-airline/vim-airline'
```

### vim-airline/vim-airline-themes

buffer 配色

#### 安装

```vim
Plug 'vim-airline/vim-airline-themes'
```

### junegunn/fzf.vim

搜索文件 FZF

#### 依赖

+ fzf

```shell
sudo pacman -S fzf
```

#### 安装

```vim
Plug 'junegunn/fzf.vim'
```

#### 配置

```vim
nnoremap <C-f> :FZF<CR>					" 快捷键打开 FZF
let g:fzf_preview_window = 'right:60%'	" 预览位置大小
```

#### 快捷键

| 快捷键  | 行为                                 | 插件      | 模式  |
| ------  | ----                                 | -----     | ----- |
| `<C-f>` | 打开搜索文件 `fzf`                   | `fzf`     | `n`   |
| `<C-t>` | `fzf` 插件中使用，在 `tab` 打开文件  | `fzf.vim` | `fzf` |
| `<C-x>` | `fzf` 插件中使用，在下方分屏打开文件 | `fzf.vim` | `fzf` |
| `<C-t>` | `fzf` 插件中使用，在右边分屏打开文件 | `fzf.vim` | `fzf` |
| `<C-j>` | `fzf` 插件中使用，选择下一个文件     | `fzf.vim` | `fzf` |
| `<C-k>` | `fzf` 插件中使用，选择上一个文件     | `fzf.vim` | `fzf` |

### mbbill/undotree

文件状态历史

#### 安装

```vim
Plug 'mbbill/undotree'
```

#### 配置

```vim
noremap L :UndotreeToggle<CR>	" 打开和关闭文件状态历史
let g:undotree_DiffAutoOpen = 1 " 自动打开修改差异内容窗口
let g:undotree_SetFocusWhenToggle = 1 " 打开状态历史时自动获取焦点
let g:undotree_ShortIndicators = 1 " 可获得较短的时间戳
let g:undotree_WindowLayout = 2 " 状态历史显示窗口样式
let g:undotree_DiffpanelHeight = 8 " 显示修改差异内容高度
let g:undotree_SplitWidth = 24	" 状态历史显示窗口宽度
function g:Undotree_CustomMap() " 在状态历史中的键映射
	nmap <buffer> k <plug>UndotreeNextState  " 上一个
	nmap <buffer> j <plug>UndotreePreviousState " 下一个
	nmap <buffer> K 5<plug>UndotreeNextState " 上 5 个
	nmap <buffer> J 5<plug>UndotreePreviousState " 下 5 个
endfunc
```

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

#### 安装

```shell
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
```

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

### airblade/vim-gitgutter

GIT 显示修改当前版本位置

#### 安装

```shell
Plug 'airblade/vim-gitgutter'
```

#### 配置

```shell
let g:gitgutter_sign_allow_clobber = 0 " 保留其他标志
let g:gitgutter_map_keys = 0 " 禁用所有键映射
let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_preview_win_floating = 1
```

### junegunn/vim-easy-align

自动对齐

#### 安装

```vim
Plug 'junegunn/vim-easy-align'
```

#### 快捷键

| 快捷键 | 行为     | 插件             | 模式    |
| ------ | ----     | -----            | ----    |
| `ga`   | 自动对齐 | `vim-easy-align` | `n` `x` |

### lambdalisue/suda.vim

执行 :sudowrite 或者 :sw 可以保存需要权限的文件

#### 安装

```vim
Plug 'lambdalisue/suda.vim'
```

#### 配置

```vim
cnoreabbrev sudowrite w suda://%
cnoreabbrev sw w suda://%
```

### elzr/vim-json

JSON 高亮

#### 安装

```vim
Plug 'elzr/vim-json'
```

### othree/html5.vim

HTML 语法

#### 安装

```vim
Plug 'othree/html5.vim', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'xml', 'xhtml', 'jsx', 'phtml'] }
```

### alvan/vim-closetag

html 自动闭合标签

#### 安装

```vim
Plug 'alvan/vim-closetag', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'xml', 'xhtml', 'jsx', 'phtml'] }
```

### yuezk/vim-js

javascript  语法高亮插件

#### 安装

```vim
Plug 'yuezk/vim-js', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'jsx'] }
```

### maxmellon/vim-jsx-pretty

jsx 语法高亮和缩进插件

#### 安装

```vim
Plug 'maxmellon/vim-jsx-pretty', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'jsx'] }
```

#### 配置

```vim
let g:vim_jsx_pretty_colorful_config = 1 " 更多颜色样式
```

### HerringtonDarkholme/yats.vim

TypeScript语法

#### 安装

```vim
Plug 'HerringtonDarkholme/yats.vim', { 'for': ['vim-plug', 'javascript','js', 'jsx', 'ts','vue', 'typescript'] }
```
### posva/vim-vue

vue 语法高亮

#### 安装

```vim
Plug 'posva/vim-vue', { 'for': ['vim-plug', 'vue'] }
```

### fatih/vim-go

Go 语法

#### 安装

```vim
Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }
```

#### 配置

> 执行 :GoInstallBinaries 

```vim
let g:go_gopls_enabled = 0 " 隐藏 "vim-go: initialized gopls"
```

### Vimjas/vim-python-pep8-indent

Python 缩进

#### 安装

```vim
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'py','vim-plug'] }
```
### numirias/semshi

Python 语义突出显示功能

#### 安装

```vim
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'py','vim-plug'] }
```

### tweekmonster/braceless.vim

Python 折叠 有点智能自动缩进

#### 安装

```vim
Plug 'tweekmonster/braceless.vim', { 'for' :['python', 'vim-plug'] }
```

#### 快捷键

| 快捷键 | 行为                              | 插件            | 模式            |
| ------ | ----                              | -----           | -----           |
| `[[`   | 移动到上一个块                    | `braceless.vim` | `n`             |
| `]]`   | 移动到下一个块                    | `braceless.vim` | `n`             |
| `[m`   | 移动到上一个 `def` `class`        | `braceless.vim` | `braceless.vim` |
| `]m`   | 移动到下一个 `def` `class`        | `braceless.vim` | `braceless.vim` |
| `[M`   | 移动到上一个 `def` `class` 的末尾 | `braceless.vim` | `braceless.vim` |
| `]M`   | 移动到下一个 `def` `class` 的末尾 | `braceless.vim` | `braceless.vim` |

### suan/vim-instant-markdown

Markdown 预览

#### 安装

```vim
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}
```

#### 配置

```vim
" 仅在暂时没有输入，离开插入模式后的一会儿，保存文件时自动刷新
let g:instant_markdown_slow = 1
" 手动启动预览
let g:instant_markdown_autostart = 0
```


### dhruvasagar/vim-table-mode

自动创建表和格式化表

#### 安装

```vim
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['markdown', 'vim-plug'] }
```

#### 配置

```vim
nnoremap <LEADER>tm :TableModeToggle<CR>
let g:table_mode_cell_text_object_i_map = 'k<Bar>'
```


#### 快捷键

| 快捷键       | 行为         | 插件             |  模式  |
| ------       | ----         | -----            |  ----- |
| `<leader>tm` | 开关表格模式 | `vim-table-mode` |  `n`   |
| `<leader>tr` | 重组表格     | `vim-table-mode` |  `n`   |


### dart-lang/dart-vim-plugin

Dart 提供文件类型检测 语法突出显示

#### 安装

```vim
Plug 'dart-lang/dart-vim-plugin', { 'for': ['dart', 'vim-plug'] }
```

### Chiel92/vim-autoformat

AutoFormat  格式化

#### 安装

```vim
Plug 'Chiel92/vim-autoformat'
```

#### 配置

```vim
" AutoFormat  格式化
nnoremap \f :Autoformat<CR>
" 定义格式化程序，js-beautify 需要安装 sudo npm -g install js-beautify --registry=https://registry.npm.taobao.org
let g:formatdef_custom_js = '"js-beautify -t"'
" 文件应用多个格式化程序
let g:formatters_javascript = ['custom_js']
```


#### 快捷键

| 快捷键 | 行为   | 插件             | 模式  |
| ------ | ----   | -----            | ----- |
| `\f`   | 格式化 | `vim-autoformat` | `n`   |

### neoclide/coc.nvim

Coc yarn

#### 安装

```vim
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
```

#### 配置

```vim

" 查看上一个报错
nnoremap <silent> <LEADER>- <Plug>(coc-diagnostic-prev)
" 查看下一个报错
nnoremap <silent> <LEADER>= <Plug>(coc-diagnostic-next)

" 列出变量定义列表
nnoremap <silent> gd <Plug>(coc-definition)
" 跳转当前实现位置
nnoremap <silent> gi <Plug>(coc-implementation)
" 转至类型定义
nnoremap <silent> gy <Plug>(coc-type-definition)
" 跳转到当前变量的引用
nnoremap <silent> gr <Plug>(coc-references)

" 重命名 变量
nnoremap <leader>rn <Plug>(coc-rename)

" 使用 <Tab> 补全代码
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 调出补全
inoremap <silent><expr> <C-g> coc#refresh()


" 选中补全回车不换行
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" coc 插件安装位置
let g:coc_data_home	= "~/.config/nvim/coc"

" coc 插件
let g:coc_global_extensions = [
			\'coc-json',
			\'coc-vimlsp',
			\'coc-snippets',
			\'coc-explorer',
			\'coc-tsserver',
			\'coc-python' ,
			\'coc-flutter-tools',
			\'coc-html',
			\'coc-clangd',
			\'coc-translator',
			\'coc-css',
			\'coc-diagnostic',
			\'coc-gitignore',
			\'coc-vetur',
			\'coc-yaml',
			\'coc-eslint'
			\]

" coc-explorer 文件系统浏览器
nnoremap tt :CocCommand explorer<CR>


" coc-snippets
" 跳转到下一个
imap <C-j> <Plug>(coc-snippets-expand-jump)
let g:snips_author = 'crush'

" 词典
nmap ts <Plug>(coc-translator-p)

```

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

#### 安装

```vim
Plug 'liuchengxu/vista.vim'
```

#### 配置

```vim
noremap <LEADER>v :Vista coc<CR>
noremap <c-t> :silent! Vista finder coc<CR>
```

#### 快捷键

| 快捷键         | 行为               | 插件         | 模式  |
| ------         | ----               | -----        | ----- |
| `<leader>` `v` | 查看函数与变量列表 | `vista.nvim` | `n`   |
| `<C-t>`        | 筛选函数与变量列表 | `vista.nvim` | `n`   |

### honza/vim-snippets

代码补全

#### 安装

```vim
Plug 'honza/vim-snippets'
```

