
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

" 选择补全代码
inoremap <silent><expr> <a-tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<a-tab>" :
      \ coc#refresh()
inoremap <expr><c-k> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 调出补全
inoremap <silent><expr> <c-g> coc#refresh()

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
" inoremap <C-j> <Plug>(coc-snippets-expand-jump)
let g:snips_author = 'crush'

" 词典
nnoremap ts <Plug>(coc-translator-p)

" 下一个占位符
let g:coc_snippet_next = '<c-j>'

" 上一个占位符
let g:coc_snippet_prev = '<c-k>'

