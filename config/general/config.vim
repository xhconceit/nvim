" 矫正部分配色
let &t_ut=''

" 自动切换目录为当前文件所在的目录
set autochdir

" 显示下划线
set cursorline

" 开启缓冲区，允许不保存切换 buffer
set hidden

" 显示行号
set number

" 一个制表符表示一个缩进
set noexpandtab

" tab等于多少空格
set tabstop=4

" 自动缩进时缩进为4格
set shiftwidth=4

" 按下 <Tab> 将自动将空格转换为 <Tab>
set softtabstop=4

" 显示相对行号
set relativenumber

" 开启自动缩进
set autoindent

" 显示不可见字符 (space,tabs,newlines,trailing space,wrapped lines, ...)
set list

" 设置不可见字符显示符号
set listchars=tab:\|\ ,trail:▫

" 保持在光标上下最少行数
set scrolloff=4

" 设置终端键之间延时
set ttimeoutlen=0

" 关闭键之间延时
set notimeout

" 
set viewoptions=cursor,folds,slash,unix

" 自动折行，即太长的行分成几行显示
set wrap

" 缩进方法
set indentexpr=

" 启用缩进代码折叠 https://zhuanlan.zhihu.com/p/27473875
set foldmethod=indent

" 折叠级别 超过 99 折叠级别的都关闭
set foldlevel=99

" 开启折叠
set foldenable

" 文本格式化
set formatoptions-=tc

" 默认新分割窗口在右边
set splitright

" 默认新分割窗口在下边
set splitbelow

" 不显示当前 mode
set noshowmode

" 右下角显示当前按键操作
set showcmd

" 命令模式下补全以菜单形式显示
set wildmenu

" 搜索忽略大小写
set ignorecase

" 智能大小写搜索
set smartcase

"
set shortmess+=c

" 实时显示ex命令会造成的改变
set inccommand=split

" 关闭 preview 窗口
set completeopt=longest,noinsert,menuone,noselect,preview

" 使 vim 滚动更快
set ttyfast

set lazyredraw

" 出错时，发出视觉提示，通常是屏幕闪烁
set visualbell

" 允许光标出现在最后一个字符的后面
set virtualedit=block,onemore

set updatetime=100


" 保存修改历史 下次打开文件还可以使用之前的修改历史
silent !mkdir -p ~/.config/nvim/tmp/backup
silent !mkdir -p ~/.config/nvim/tmp/undo
"silent !mkdir -p ~/.config/nvim/tmp/sessions
set backupdir=~/.config/nvim/tmp/backup,.
set directory=~/.config/nvim/tmp/backup,.
if has('persistent_undo')
	set undofile
	set undodir=~/.config/nvim/tmp/undo,.
endif

" 打开文件，光标回到上次编辑的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" ===
" === nvim 终端配置
" ===
let g:neoterm_autoscroll = 1
autocmd TermOpen term://* startinsert
let g:terminal_color_0  = '#000000'
let g:terminal_color_1  = '#FF5555'
let g:terminal_color_2  = '#50FA7B'
let g:terminal_color_3  = '#F1FA8C'
let g:terminal_color_4  = '#BD93F9'
let g:terminal_color_5  = '#FF79C6'
let g:terminal_color_6  = '#8BE9FD'
let g:terminal_color_7  = '#BFBFBF'
let g:terminal_color_8  = '#4D4D4D'
let g:terminal_color_9  = '#FF6E67'
let g:terminal_color_10 = '#5AF78E'
let g:terminal_color_11 = '#F4F99D'
let g:terminal_color_12 = '#CAA9FA'
let g:terminal_color_13 = '#FF92D0'
let g:terminal_color_14 = '#9AEDFE'



" 编译 预览
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		set splitbelow
		exec "!g++ -std=c++11 % -Wall -o %<"
		:sp
		:res -15
		:term ./%<
	elseif &filetype == 'java'
		exec "!javac %"
		exec "!time java %<"
	elseif &filetype == 'sh'
		:!time bash %
	elseif &filetype == 'python'
		set splitbelow
		:sp
		:term python3 %
	elseif &filetype == 'html'
		silent! exec "!".g:mkdp_browser." % &"
	elseif &filetype == 'markdown'
		exec "InstantMarkdownPreview"
	elseif &filetype == 'tex'
		silent! exec "VimtexStop"
		silent! exec "VimtexCompile"
	elseif &filetype == 'dart'
		exec "CocCommand flutter.run -d ".g:flutter_default_device
		silent! exec "CocCommand flutter.dev.openDevLog"
	elseif &filetype == 'javascript'
		set splitbelow
		:sp
		:term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
	elseif &filetype == 'go'
		set splitbelow
		:sp
		:term go run .
	endif
endfunc
