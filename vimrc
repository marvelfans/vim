" 基本环境配置 {
    " 判断操作系统 {
        silent function! OSX()
            return  has('macunix')
        endfunction
        silent function! LINUX()
            return has('unix') && !has('maxunix') && !has('win32unix')
        endfunction
        silent function! WINDOWS()
            return (has('win32') || has('win64'))
        endfunction
    " }
    " 基本设置 {
        set nocompatible
        if !WINDOWS()
            set shell=/bin/sh
        endif
    " }
    " Windows下配置 {
        " Windows 下设置rtp,可以和linux, mac共用一个配置文件
        if WINDOWS()
            set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after,$VIM/.vim/
        endif
    " }
    " Windows 下乱码解决 {
        set encoding=utf-8
        set termencoding=utf-8
        set fileencoding=utf-8
        set fileencodings=ucs-bom,utf-8,chinese,cp930
        " vim 提示信息乱码
        if (has('gui_running') && WINDOWS())
            language message ZH_CH.UTF-8
            set encoding=chinese
            source $VIMRUNTIME/delmenu.vim
            source $VIMRUNTIME/menu.vim
        endif
    " }

    " Arrows Key Fix {
        if &term[:4] == 'xterm' || &term[:5] == 'screen' || &term[:3] == 'rxvt'
            inoremap <silent> <C-[>OC <RIGHT>
        endif
    " }
" }

" 使用bundles配置文件 {
    if filewritable(expand("$HOME/.vimrc.bundles"))
        source $HOME/.vimrc.bundles
    endif
" }

" 基本配置  {
    set background=dark
    function! ToggleBG()
        let s:tbg = &background
        if s:tbg == "dark"
            set background=light
        else
            set background=dark
        endif
    endfunction
    noremap <leader>bg :call ToggleBG()<CR>

    filetype plugin indent on
    syntax on
    set mousehide   " 隐藏鼠标
    set mouse=a     " 设置鼠标可用
    scriptencoding utf-8

    " 复制粘贴设置
    if has('clipboard')
        " 如果允许，使用 + register 来复制粘贴
        if has('unnamedplus')
            set clipboard=unnamed,unnamedplus
        else         " On mac and Windows, use * register for copy-paste
            " 在mac 和 windows 使用 * 寄存器来复制粘贴
            set clipboard=unnamed
        endif
    endif


    set vb t_vb=   " 不要提示音 和 闪烁

    " 避免自动切换到当前文件的目录
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

    set shortmess+=filmnrxoOtT          " 自动保存
    set viewoptions=folds,options,cursor,unix,slash
    set virtualedit=onemore
    set history=1000
    set spell   " 拼写检查 会有下划线
    set iskeyword-=.
    set iskeyword-=#
    set iskeyword-=-
    set confirm   " 在处理只读 未保存文件时，弹出确认
    set nobackup  " 不要备份文件
    set helplang=cn    " 中文帮助文档
" }

" Vim UI {
    let g:Solarized_path="$HOME/.vim/bundle/vim-colors-solarized/colors/solarized.vim"
    if filereadable(expand(g:Solarized_path))
        let g:solarized_termcolors=256
        let g:solarized_termtrans=1
        let g:solarized_contrast="normal"
        let g:solarized_visibility="normal"
        color solarized
    endif

    set tabpagemax=15
    set showmode        " 显示目前模式

    set cursorline
    set cursorcolumn

    highlight clear SignColumn
    highlight clear LineNr

    if has('cmdline_info')
        set ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)
        set showcmd
    endif

    if has('statusline')
        set laststatus=2

        set statusline=%<%F
        set statusline+=%w%h%m%r

        " set statusline+=\ [%{&ff}/%Y]
        set statusline+=\ [%{getcwd()}]
        " set statusline+=\ [%{strftime(\"%d/%m/%Y\ -\ %H:%M\")}]
        " set statusline+=%=%-14.(%l,%c%V%)\ %p%%
    endif

    set backspace=indent,eol,start
    set linespace=0
    set number
    set showmatch
    set incsearch
    set hlsearch
    set winminheight=0
    set ignorecase
    set smartcase
    set wildmenu
    set wildmode=list:longest,full
    set whichwrap=b,s,h,l,<,>,[,]
    set scrolljump=5
    set scrolloff=3
    set foldenable
    set list
    set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

    " 如果是gui方式 设置字体和工具栏菜单栏
    if has("gui_running")
        " set guifont=Courier_new:h11
        if OSX()
            set transparency=5 " 透明度设置
            set guioptions+=T
            set guioptions+=m
        else
            " gui模式开启最大化
            " au GUIEnter * simalt ~x
            " set go-=menu
            " set go+=Tools
            set go=
        endif
    endif
" }

" Formatting {
    set wrap            " 自动折行
    set autoindent      " 自动缩进
    set shiftwidth=4
    set expandtab
    set tabstop=4
    set softtabstop=4
    " set splitright      " 在右边分割窗口
    " set splitbelow      " 在下边分割窗口
" }

" Key (re)Mappings {
    " 设置leader键
    let mapleader = ','
    " 移动窗口
    map <C-J> <C-W>j
    map <C-L> <C-W>l
    map <C-H> <C-W>h
    map <C-K> <C-W>k
    " map    <tab>   <C-W>w
    " 搜索关键词
    nmap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr . "[\t"<CR>
    " 显示屏幕 隐藏所有程序
    map <slient> <F11> :call system("wmctrl -ir " . v:windowid . " -b toggle,fullscreen")<CR>
    " F1-F12快捷键 {
        " 关闭<F1>
        map         <F1>    <Nop>
        " <F3>打开当前路径目录.
        nmap        <F3>    <ESC>:vi ./<cr>
        " <F2>开启列可视模式
        nmap        <F2>    <ESC><C-v>
        " <F5>打开所有折叠 F6关闭所有折叠
        noremap     <F5>    zR
        noremap     <F6>    zM
        " <F7>快速缓冲区交换文件.
        noremap     <F7>    :vi #<cr>
        " <F8>打开当前缓冲区所有文件，快速选择缓冲区文件
        if v:version >= 704
            noremap     <F8>    :BufExplorer<cr>
        endif
        " <F9>快速插入desc
        map <F9> O/*<CR>@brief: <CR>@date:[<Esc>:read !date<CR>kJ$a]<CR>@author:zjz<CR>@param: <CR>@return: <CR><tab>*/<ESC><s-i><backspace><ESC>
        " <F10>排版
        noremap     <F10>   <ESC>gg=G<ESC>
        " 有的文件对高亮不支持，手动打开
        noremap     <F12>   <ESC>:set syntax=on<cr>
    " }
    " 清楚末尾空格
    noremap cl  :%s/\s\+$//<cr>
    " 快速移动到行头行尾
    noremap     A       ^
    noremap     E       $
    " 粘贴
    nmap    p       <s-p>
    " 强制退出
    nmap    q       <Esc>:q!<cr>
    " ` 保存，这个键发现挺方便也没其他用途
    noremap     `       <Esc>:w!<cr>
    " 上下翻页
    noremap     f       <C-d>
    noremap     F       <C-u>
    " 用分号可以快速输入冒号，不用每次都shift
    noremap     ;       :
    " 快速回到上次插入位置
    noremap     '   '^
    "
" }

" Plugins {
    " Ctags {
        " 支持ctags
        set tags=./tags;/,~/.vimtags,$VIM/vim74/,tags

        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot != ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif
    " }

    " NerdTree {
        " 显示目录树
        let g:NERDTree_path = "$HOME/.vim/bundle/nerdtree"
        if isdirectory(expand(g:NERDTree_path))
            " let NERDTreeShowBookmarks=1
            let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
            let NERDTreeChDirMode=0
            " let g:NERDTreeQuitOnOpen=1 " 打开文件后关闭buffer
            let g:NERDTreeMouseMode=2
            let g:NERDTreeShowHidden=1
            let g:NERDTreeKeepTreeInNewTab=1
            let g:nerdtree_tabs_open_on_gui_startup=0
            let g:NERDTreeWinPos="left"
            let g:NERDTreeWinSize=25
            let g:NERDTreeAutoDeleteBuffer=1
            let g:NERDTreeMinimalUI=1
            let g:NERDTreeDirArrows=0
            " vim 开启时 自动打开nerdtree
            " 并且鼠标停留在文件编辑区
            autocmd VimEnter * NERDTree
            wincmd l
            autocmd VimEnter * wincmd l

            map <Leader>e :NERDTreeToggle()<CR>
        endif
    " }

    " Taglist{
        " 显示Tag
        let g:Tlist_path = "$HOME/.vim/bundle/taglist.vim/"
        if isdirectory(expand(g:Tlist_path))
            let g:Tlist_Show_One_File=1     " 只显示当前文件的tag
            let g:Tlist_Exit_OnlyWindow=1   " 如果最后只有Taglist窗口,则退出
            let g:Tlist_WinWidt=20          " 宽度
            let g:Tlist_Use_Right_Window=1  " 在右侧打开窗口
            " let g:Tlist_Auto_Open=1         " 自动打开
            let g:Tlist_Process_File_Always=1 " 始终解析文件

            nnoremap <silent> <leader>t :Tlist<CR>
        endif
    "}

    " vim-airline {
        " 下边栏的颜色样式
        if isdirectory(expand("$HOME/.vim/bundle/vim-airline-themes/"))
            if !exists('g:airline_theme')
                let g:airline_theme = 'solarized'
            endif
            if !exists('g:airline_powerline_fonts')
                " Use the default set of separators with a few customizations
                let g:airline_left_sep='›'  " Slightly fancier than '>'
                let g:airline_right_sep='‹' " Slightly fancier than '<'
                let g:airline_theme='dark'  " 设置颜色
                let g:airline_detect_crypt=0 " 我也不知道是什么
                let g:airline_detect_modified=0 " 修正修改
                let g:airline_detect_paste=1    " 粘贴
                let g:airline_detect_spell=1    " 拼写
                let g:airline_detect_iminsert=1    " 不知道什么意思
                let g:airline_inactive_collapse=0   " 不知道什么意思
                let g:airline_powerline_fonts=0     " 不知道什么意思
                let g:airline_exclude_filenames=[]
                let g:airline_exclude_filetypes=[]
                let g:airline_exclude_preview=0
                let g:airline_skip_empty_section=0


                " 设置一些颜色 不同模式 不同颜色
                let g:airline_theme_patch_func = 'AirlineThemePatch'
                function! AirlineThemePatch(palette)
                  if g:airline_theme == 'badwolf'
                    for colors in values(a:palette.inactive)
                      let colors[3] = 245
                    endfor
                  endif
                endfunction
                " 模式名字
                let g:airline_mode_map = {
                    \ '__' : '-',
                    \ 'n'  : 'N',
                    \ 'i'  : 'I',
                    \ 'R'  : 'R',
                    \ 'c'  : 'C',
                    \ 'v'  : 'V',
                    \ 'V'  : 'V',
                    \ '' : 'V',
                    \ 's'  : 'S',
                    \ 'S'  : 'S',
                    \ '' : 'S',
                    \ }
            endif
        endif
    " }
    " syntastic {
        " 语法检查
        let g:syntastic_error_symbol='>>'
        let g:syntastic_warning_symbol='>'
        let g:syntastic_check_on_open=1
        let g:syntastic_check_on_wq=0
        let g:syntastic_enable_highlighting=1
    " }

    " bufferline {
        let g:bufferline_active_buffer_left = '['
        let g:bufferline_active_buffer_right = ']'
        let g:bufferline_modified = '+'
        let g:bufferline_show_bufnr = 1
        let g:bufferline_fname_mod = ':t'
        let g:bufferline_active_highlight = 'StatusLine'
        let g:bufferline_solo_highlight = 'StatusLine'
        let g:bufferline_echo = 1
        """""""
        if isdirectory(expand("$HOME/.vim/bundle/vim-bufferline/"))
            " 切换缓冲区 {
                " 正常模式 {
                    noremap <silent><leader>1 :b 1<cr>
                    noremap <silent><leader>2 :b 2<cr>
                    noremap <silent><leader>3 :b 3<cr>
                    noremap <silent><leader>4 :b 4<cr>
                    noremap <silent><leader>5 :b 5<cr>
                    noremap <silent><leader>6 :b 6<cr>
                    noremap <silent><leader>7 :b 7<cr>
                    noremap <silent><leader>8 :b 8<cr>
                    noremap <silent><leader>9 :b 9<cr>
                    noremap <silent><leader><Tab> :bn<cr>
                " }
                " 插入模式 {
                    inoremap <silent><leader>1 <ESC>:b 1<cr>
                    inoremap <silent><leader>2 <ESC>:b 2<cr>
                    inoremap <silent><leader>3 <ESC>:b 3<cr>
                    inoremap <silent><leader>4 <ESC>:b 4<cr>
                    inoremap <silent><leader>5 <ESC>:b 5<cr>
                    inoremap <silent><leader>6 <ESC>:b 6<cr>
                    inoremap <silent><leader>7 <ESC>:b 7<cr>
                    inoremap <silent><leader>8 <ESC>:b 8<cr>
                    inoremap <silent><leader>9 <ESC>:b 9<cr>
                    inoremap <silent><leader><Tab> <ESC>:bn<cr>
                " }
                " 可视模式 {
                    vnoremap <silent><leader>1 <ESC><ESC>:b 1<cr>
                    vnoremap <silent><leader>2 <ESC><ESC>:b 2<cr>
                    vnoremap <silent><leader>3 <ESC><ESC>:b 3<cr>
                    vnoremap <silent><leader>4 <ESC><ESC>:b 4<cr>
                    vnoremap <silent><leader>5 <ESC><ESC>:b 5<cr>
                    vnoremap <silent><leader>6 <ESC><ESC>:b 6<cr>
                    vnoremap <silent><leader>7 <ESC><ESC>:b 7<cr>
                    vnoremap <silent><leader>8 <ESC><ESC>:b 8<cr>
                    vnoremap <silent><leader>9 <ESC><ESC>:b 9<cr>
                    vnoremap <silent><leader><Tab> <ESC><ESC>:bn<cr>
                " }
            " }
        endif
    " }

    " 自动补全 {
        " OmniComplete 补全 {
            if has("autocmd") && exists("+omnifunc")
                autocmd FileType *
                            \if &omnifunc == "" |
                            \setlocal omnifunc=syntaxcomplete#Complete |
                            \endif
                            \endif
            endif

            hi Pmenu guifg=#000000 guibg=#F8F8F8 ctermfg=black ctermbg=Lightgray
            hi PmenuSbar guifg=#8A95A7 guibg=#F8F8F8 gui=NONE ctermfg=darkcyan ctermfg=lightgray cterm=NONE
            hi PmenuThumb guifg=#F8F8F8 guibg=#8A95A7 gui=NONE ctermfg=lightgray ctermfg=darkcyan cterm=NONE

            inoremap <expr> <Down>  pumvisible() ? "\<C-n>" : "\<DOWN>"
            inoremap <expr> <Up>    pumvisible() ? "\<C-p>" : "\<Up>"
            inoremap <expr> <C-d>   pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<C-d>"
            inoremap <expr> <C-u>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<C-u>"

            au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
            set completeopt=menu,preview,longest
        " }

        " neocomplcache {
            let g:acp_enableAtStartup = 0
            let g:neocomplcache_enable_at_startup = 1
            let g:neocomplcache_enable_camel_case_completion = 1
            let g:neocomplcache_enable_smart_case = 1
            let g:neocomplcache_enable_underbar_completion = 1
            let g:neocomplcache_enable_auto_delimiter = 1
            let g:neocomplcache_max_list = 15
            let g:neocomplcache_force_overwrite_completefunc = 1

            " Define dictionary.
            let g:neocomplcache_dictionary_filetype_lists = {
                        \ 'default' : '',
                        \ 'vimshell' : $HOME.'/.vimshell_hist',
                        \ 'scheme' : $HOME.'/.gosh_completions'
                        \ }

            " Define keyword.
            if !exists('g:neocomplcache_keyword_patterns')
                let g:neocomplcache_keyword_patterns = {}
            endif
            let g:neocomplcache_keyword_patterns._ = '\h\w*'

            " Plugin key-mappings {
                " These two lines conflict with the default digraph mapping of <C-K>
                imap <C-k> <Plug>(neosnippet_expand_or_jump)
                smap <C-k> <Plug>(neosnippet_expand_or_jump)

                imap <silent><expr><C-k> neosnippet#expandable() ?
                            \ "\<Plug>(neosnippet_expand_or_jump)" : (pumvisible() ?
                            \ "\<C-e>" : "\<Plug>(neosnippet_expand_or_jump)")
                smap <TAB> <Right><Plug>(neosnippet_jump_or_expand)

                inoremap <expr><C-g> neocomplcache#undo_completion()
                inoremap <expr><C-l> neocomplcache#complete_common_string()
                " inoremap <expr><CR> neocomplcache#complete_common_string()

                function! CleverCr()
                    if pumvisible()
                        if neosnippet#expandable()
                            let exp = "\<Plug>(neosnippet_expand)"
                            return exp . neocomplcache#close_popup()
                        else
                            return neocomplcache#close_popup()
                        endif
                    else
                        return "\<CR>"
                    endif
                endfunction

                " <CR> close popup and save indent or expand snippet
                imap <expr> <CR> CleverCr()

                " <CR>: close popup
                " <s-CR>: close popup and save indent.
                inoremap <expr><s-CR> pumvisible() ? neocomplcache#close_popup()."\<CR>" : "\<CR>"
                "inoremap <expr><CR> pumvisible() ? neocomplcache#close_popup() : "\<CR>"

                " <C-h>, <BS>: close popup and delete backword char.
                inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
                inoremap <expr><C-y> neocomplcache#close_popup()

                " <TAB>: completion.
                inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
                inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<TAB>"

            " }

            " Enable omni completion.
            autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
            autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
            autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
            autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
            autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
            autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
            autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

            " Enable heavy omni completion.
            if !exists('g:neocomplcache_omni_patterns')
                let g:neocomplcache_omni_patterns = {}
            endif
            let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
            let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
            let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
            let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
            let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\h\w*\|\h\w*::'
            let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'
        " }
    " }
" }
