"----------------------------
"    快捷键设置
"----------------------------
let mapleader=","
let g:mapleader=","

" cancel <F1> HelpPage
nnoremap <F1> <Nop>

" 使用;代替:
noremap ; :

" 使用*高亮当前KeyWord, 但不执行跳转
noremap * :let @/=expand('<cword>')<CR>:set hlsearch<CR>

" 多个vim-pane之间切换 
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l
