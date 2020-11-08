" AutoFormat  格式化
nnoremap \f :Autoformat<CR>
" 定义格式化程序
let g:formatdef_custom_js = '"js-beautify -t"'
" 文件应用多个格式化程序
let g:formatters_javascript = ['custom_js']
