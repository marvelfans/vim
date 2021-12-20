" -------------------------
"   vim-plug 插件管理器
" -------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" ------------------------------------
"  开始安装插件
" ------------------------------------
call plug#begin('~/.vim/plugged')



" -----------
"  基础插件
" -----------

" tab增强
Plug 'ervandew/supertab'

" 一个不错的主题
Plug 'jnurmine/Zenburn'

" 一个查看启动时间的插件
Plug 'tweekmonster/startuptime.vim'

" ------------
"   <vim-go>
" ------------
Plug 'fatih/vim-go'

let g:go_code_completion_enabled = 1
let g:go_auto_type_info = 1
let g:go_updatetime = 500
let g:go_auto_sameids = 0       " => 影响速度
let g:go_fmt_comand = "gofmt"
let g:syntastic_go_checkers = ['golint', 'govet']
let g:syntastic_mode_map = {'mode': 'active', 'passive_filetypes': ['go']}
let g:go_list_type = "quickfix"


"----------------
" <vim-godef>
"----------------
Plug 'dgryski/vim-godef'

" 使用Ctrl+[跳转到定义处
let g:godef_split=3
let g:godef_same_file_window=1

" --------------
"   <NerdTree>
" --------------
Plug 'preservim/nerdtree'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" 允许的最大尺寸, 解决和bufExplore冲突的问题
let g:NERDTreeWinSize=35

let g:NERDTreeMinimalUI = 1
let g:NERDTreeDirArrows = 1
let g:NERDTreeHijackNetrw = 0

" 不显示的文件
let NERDTreeIgnore=['.pyc$']

" exit when only nerdtree win exists
autocmd bufenter * if(winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" 设置一下快捷键
nnoremap <F2> :NERDTreeToggle<CR>

" --------------
"   bufexplore
" --------------
Plug 'jlanzarotta/bufexplorer'

let g:bufExplorerDefaultHelp=0
" 显示最近使用最多的
let g:bufExplorerSortBy='mru'
" 在下边显示
let g:bufExplorerSplitBelow=1
" 将路径和文件名显示到一起
let g:bufExplorerSplitOutPathName=1
nnoremap <F3> :ToggleBufExplorer<CR>


" --------------------------------------------------------
"   winresizer 调整窗口大小
"   在tmux中鼠标不能拖动调整大小了,添加该插件补充该功能
" --------------------------------------------------------
Plug 'simeji/winresizer'

let g:winresizer_start_key='<C-i>'
let g:winresizer_horiz_resize=2
let g:winresizer_vert_resize=2
" 调整窗口大小插件
nnoremap <Leader>w :WinResizerStartResize<CR>


" ------------------------
"   ctrlp 文件模糊搜索插件
" ------------------------
Plug 'ctrlpvim/ctrlp.vim'

let g:ctrlp_cmd ='CtrlP'
let g:ctrlp_custom_ignore = {
            \ 'dir': '\v(venv|env|apitest)',
            \ 'file': '\v\.(exe|so|dll)$',
            \ }
let g:ctrlp_map = '<Leader>s'



" ------------------------
"  结束插件安装
" ------------------------
call plug#end()
