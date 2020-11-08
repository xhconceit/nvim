
" 切换到下面一个窗口
nnoremap <LEADER>j        <C-w>j

" 切换到上面一个窗口
nnoremap <LEADER>k        <C-w>k

" 切换到左边一个窗口
nnoremap <LEADER>h        <C-w>h

" 切换到右边一个窗口
nnoremap <LEADER>l        <C-w>l

" 窗口间循环切换
nnoremap <LEADER>m        <C-w>w

" 窗口互换
nnoremap <LEADER>x        <C-w>x

" 垂直布局
nnoremap <LEADER>H        <C-w>H

" 水平布局
nnoremap <LEADER>J        <C-w>J

" 关闭其他窗口
nnoremap <LEADER>q        <C-w>o

" 在下方新建窗口 选中当前窗口
nnoremap <leader>w               :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>

" 在下方新建窗口 选中新窗口
nnoremap <leader>s               :set splitbelow<CR>:split<CR>

" 在右方新建窗口 选中当前窗口
nnoremap <leader>a               :set nosplitright<CR>:vsplit<CR>:set splitright<CR>

" 在右方新建窗口 选中新窗口
nnoremap <leader>d               :set splitright<CR>:vsplit<CR>
