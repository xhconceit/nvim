" 自动安装 vim-plug 插件管理器
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
				\ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" vim plug
call plug#begin('~/.config/nvim/plugged')

" 主题插件
Plug 'dracula/vim', { 'as': 'dracula' }


" 透明插件
Plug 'kjwon15/vim-transparent'

" 命令栏中显示 buffer 列表
Plug 'bling/vim-bufferline'

" buffer 状态栏主题
Plug 'vim-airline/vim-airline'

" buffer 配色
Plug 'vim-airline/vim-airline-themes'

" 搜索文件 FZF
Plug 'junegunn/fzf.vim'

" 文件状态历史
Plug 'mbbill/undotree'

" 多光标操作文件
Plug 'mg979/vim-visual-multi', {'branch': 'master'}

" GIT 显示当前修改位置
Plug 'airblade/vim-gitgutter'

" 自动对齐
Plug 'junegunn/vim-easy-align'

" 保存需要权限的文件
Plug 'lambdalisue/suda.vim'

" JSON 高亮
Plug 'elzr/vim-json'

" HTML
Plug 'othree/html5.vim', { 'for': ['vim-plug' ,'php', 'html','js', 'javascript','vue', 'xml', 'xhtml', 'jsx', 'phtml', 'ts', 'typescript'] }

" 自动闭合标签
Plug 'alvan/vim-closetag', { 'for': ['vim-plug', 'php', 'html', 'js','javascript', 'vue','xml', 'xhtml', 'jsx', 'phtml', 'ts', 'typescript'] }

" javascript  语法高亮插件
Plug 'yuezk/vim-js', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'js','jsx', 'vue','ts', 'typescript'] }

" jsx 语法高亮和缩进插件
Plug 'maxmellon/vim-jsx-pretty', { 'for': ['vim-plug', 'php', 'html','js', 'javascript', 'jsx', 'ts', 'typescript'] }

" TypeScript语法
Plug 'HerringtonDarkholme/yats.vim', { 'for': ['vim-plug', 'javascript','js', 'jsx', 'ts','vue', 'typescript'] }

" vue 语法高亮
Plug 'posva/vim-vue', { 'for': ['vim-plug', 'vue'] }

" Go 语法
Plug 'fatih/vim-go' , { 'for': ['go', 'vim-plug'], 'tag': '*' }

" Python 缩进
Plug 'Vimjas/vim-python-pep8-indent', { 'for' :['python', 'py','vim-plug'] }

" Python 语义突出显示功能
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for' :['python', 'py','vim-plug'] }

" Python 折叠 有点智能自动缩进
Plug 'tweekmonster/braceless.vim', { 'for' :['python', 'vim-plug'] }

" Markdown 预览
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

" 自动创建表和格式化表
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle', 'for': ['markdown', 'vim-plug'] }

" Dart 提供文件类型检测 语法突出显示
Plug 'dart-lang/dart-vim-plugin', { 'for': ['dart', 'vim-plug'] }

" AutoFormat  格式化
Plug 'Chiel92/vim-autoformat'

" 显示函数与变量列表
Plug 'liuchengxu/vista.vim'

" Coc yarn
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}

" 代码补全
Plug 'honza/vim-snippets'

call plug#end()

" 主题插件
source ~/.config/nvim/config/plugs/dracula.vim

" 命令栏中显示 buffer 列表
source ~/.config/nvim/config/plugs/vim-airline.vim

" 搜索文件 FZF
source ~/.config/nvim/config/plugs/fzf.vim

" 文件状态历史
source ~/.config/nvim/config/plugs/undotree.vim

" GIT 显示当前修改位置
source ~/.config/nvim/config/plugs/vim-gitgutter.vim

" 保存需要权限的文件
source ~/.config/nvim/config/plugs/suda.vim

" vim-go
source ~/.config/nvim/config/plugs/vim-go.vim

" jsx 语法高亮和缩进插件
source ~/.config/nvim/config/plugs/vim-jsx-pretty.vim

" Markdown 预览
source ~/.config/nvim/config/plugs/vim-instant-markdown.vim

" 自动创建表和格式化表
source ~/.config/nvim/config/plugs/vim-table-mode.vim

" AutoFormat  格式化
source ~/.config/nvim/config/plugs/vim-autoformat.vim

" 显示函数与变量列表
source ~/.config/nvim/config/plugs/vista.vim

" Coc yarn
source ~/.config/nvim/config/plugs/coc.vim
