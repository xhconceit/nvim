" <leader> 改为空格
let mapleader=" " 
" ; 改为 :
noremap ; :

" 还原上一步操作
noremap  U                <C-r>

" 退出
noremap  <C-q>            <Esc>:q<CR>

" 保存
noremap  <C-s>            <Esc>:w<CR>

" 向下移动 5 格
noremap  J                5j

" 向上移动 5 格
noremap  K                5k

" 清除搜索高亮
nnoremap <LEADER><CR>     :nohlsearch<CR>

" 反向缩进
nnoremap <                <<

" 缩进
nnoremap >                >>

" 复制到行尾
nnoremap Y                y$

" 复制选中文本至系统剪切板
vnoremap Y                "+y

" 剪切到行尾
nnoremap D                d$

" 剪切选中文本至系统剪切板
vnoremap D                "+d

" 从系统剪切板上粘贴到文件中
nnoremap P                "+p

" 在当前窗口下方新建一个终端窗口
nnoremap <LEADER>/        :set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>

" 删除下一个 <++> 并进入插入模式
nnoremap  <LEADER><LEADER> /<++><CR>:nohlsearch<CR>c4l

" 查找和替换
nnoremap \s               :%s//g<left><left>

" 更新 nvim 配置
nnoremap  <C-r>            :source $MYVIMRC<CR>

" 退出终端
tnoremap <C-q>             <C-\><C-n><Esc>:q<CR>
" 编辑终端
tnoremap <C-n>             <C-\><C-n>
" 返回打开终端的文件
tnoremap <C-o>             <C-\><C-n><C-o>
" 编译 预览
nnoremap r :call CompileRunGcc()<CR>
" 安装插件
nnoremap <leader>ip :PlugInstall<CR>

" 窗口快捷键
source ~/.config/nvim/config/general/keys/keys_window.vim

" buffer 快捷键
source ~/.config/nvim/config/general/keys/keys_buffer.vim

" tab 快捷键
source ~/.config/nvim/config/general/keys/keys_tab_page.vim

" 数字
source ~/.config/nvim/config/general/keys/keys_numbers.vim

" 方向
source ~/.config/nvim/config/general/keys/keys_direction.vim

" 符号
source ~/.config/nvim/config/general/keys/keys_symbol.vim
