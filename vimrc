" 操作系统、编码设置 {
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
" 快捷键  设置 {
	" 设置leader
	let mapleader=","
	let g:mapleader=","
	" 快速保存
	noremap `	:w!<cr> 
	" 快速退出
	noremap q	<ESC>:CloseBW<CR>
	" 行首
	noremap A   ^
	" 行尾
	noremap E   $
	" ; -> :
	noremap ; :
	" 关闭quickwindow
	noremap cl   :ccl<cr>
	" 查找当前光标下的单词且显示在quickfix窗口中
	noremap <silent><leader>g   :vimgrep <C-R>=expand("<cword>")<CR> %<CR>:copen<cr>
	" 查找当前光标下的单词，支持跳转
	noremap <silent><Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr . "[\t"<CR>
	noremap <F1>	<Nop>
	" 文件头
	noremap <F9>    :call Setfilehead()<cr>
	" 窗口移动 {
		map <C-j>	<C-W>j
		map <C-k>	<C-W>k
		map <C-h>	<C-W>h
		map <C-l>	<C-W>l
	" }
	" 关闭当前缓冲区
	map <leader>bd	:Bclose<cr>
 	" 关闭所有缓冲区
	map <leader>ba :1,1000 bd!<cr>
	" 切换缓冲区 {
		map <C-n>	:bn<cr>
		map <C-f>	:bp<cr>
	" }
	" 关闭当前缓冲区
	map <leader>dd :Bclose<cr> 			
	" 关闭所有缓冲区，包括当前窗口
	map <leader>da :BcloseA<cr>
" }

" 基本设置 {
	set number																			" 显示行号
	highlight lineNr cterm=NONE ctermfg=249 ctermbg=240 guifg=LightYellow guibg=Grey	" 自定义高亮的颜色
	set history=700																		" 保存历史记录
	" 根据文件类型 启用插件 和缩紧 {
		filetype plugin on
		filetype indent on
	" }
	set so=3  							" 移动时候，距离上下的距离
	set wildmenu 						" wildmenu 命令补全时候  C-p/n
	set wildignore=*.o,*~,~.pyc  		" wildmenu中忽略的文件类型
	set cmdheight=1 					" command bar高度
	set backspace=eol,start,indent 		" backspace可用
	set whichwrap+=<,>,h,l				" 折行
	set ignorecase 						" 搜索忽略大小写
	set smartcase 						" 智能搜索
	set hlsearch 						" 高亮搜索结果
	set incsearch 						" 搜索时 实时匹配
	set showmatch 						" 显示匹配括号
	set mat=2 							" 2s闪烁一下
	" 不要错误警告声 {
		set noerrorbells
		set novisualbell
		set t_vb=
		set tm=500
	" } 
	" 使用系统剪贴板
	if has('clipboard')
		set clipboard=unnamed
	endif
	set mouse=i 				" 插入模式下可以滚屏 鼠标可用
	set mousehide 				" 鼠标隐藏
	set virtualedit=onemore 	" 允许光标到最后一个位置
	set helplang=cn 			" 中文文档, 前提是已经下载了中文文档
	autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif		" 避免自动切换到当前文件的目录
	syntax enable		" 打开语法检查
	set modifiable 		" 如果关闭有时候缓冲期内容不能修改
	set viminfo^=% 		" 关闭后记录buffer信息 
	" 文件备份{
		set nobackup
		set nowb
		set noswapfile
	" }
	" 文件格式 {	
		" set expandtab		" 空格代替tabs
		set noexpandtab 	" 不用空格代替tabs
		set smarttab 		" 智能tab?
		set shiftwidth=4 	"tab = 4*spaces
		set tabstop=4
		" 500字符换行 {
			set lbr
			set tw=500
		" }
		" 自动缩进 智能缩进 折行 {
			set ai
			set si
			set wrap
		" }
	" }
	" 编码设置 {
		set encoding=utf-8
		if WINDOWS()
			set termencoding=gbk
		else
			set termencoding=utf-8  							" 终端编码
		endif
		set fileencoding=utf-8
		set fileencodings=utf-8,ucs-bom,chinese,cp930,GBK
		set ffs=unix,dos,mac									" 默认文件类型unix
	" }
	" 回到上次编辑的地方 "{
		autocmd BufReadPost *
		     \ if line("'\"") > 0 && line("'\"") <= line("$") |
		     \   exe "normal! g`\"" |
		     \ endif
	" }
	" matchstrpos vim74及以上才有
	" autocmd BufEnter * if matchstrpos(getcwd(), 'someone')[0] != '' | source .vimrc.test | endif
	" stridx vim72有
	" autocmd BufEnter * if stridx(getcwd(), 'zjz') >= 0 | source .vimrc.test | endif
" }

" Bundle 及插件设置 {
	filetype off 			" 安装插件时候首先关闭文件类型检测 最后在打开 
	set rtp+=$HOME/.vim/bundle/Vundle.vim/
	call vundle#rc()
	" Vundle 插件管理 {
		Bundle 'VundleVim/Vundle.vim'
	" }
	" 通用插件 {
		" 语法检查
		Bundle 'scrooloose/syntastic'
		" 自动补全括号
		Bundle 'jiangmiao/auto-pairs'
		" 补全
		Bundle 'Shougo/neocomplcache'
 		" 模板补全
		Bundle 'neosnippet'
 		" 自动弹框
		Bundle 'AutoComplPop'
		" 目录配置
		Bundle 'scrooloose/nerdtree'
		if executable('ctags')
			" Tlist
	    	Bundle 'marvelfans/taglist.vim'
		endif
	" }
	" 外观插件  "{
		" 颜色主题
		Bundle 'altercation/vim-colors-solarized'
		" Bundle 'vim-scripts/minibufexplorerpp'
		" 缓冲区设置
		Bundle 'bling/vim-bufferline'
	" }
	" GoLang 相关插件 {
		Bundle 'fatih/vim-go'
		Bundle 'nsf/gocode'
	" }
" }

" 外观及界面设置 "{
	" 放到前边 solarized 颜色设置
	let g:solarized_termcolors=256
	let g:solarized_termtrans=1
	let g:solarized_contrast="normal"
	let g:solarized_visibility="normal"
	colorscheme solarized
	" set background=dark
	set background=light
	set t_Co=256

	set cursorline	" 显示下划线
	" set cursorcolumn " 显示竖对齐线
	
	highlight clear CursorLineNr
	highlight clear LineNr
	highlight clear SignColumn

	" highlight CursorLine  cterm=NONE ctermbg=black ctermfg=green guibg=black guifg=green	" 高亮当前行背景 而不是一个下划线
	" highlight CursorColumn  cterm=NONE ctermbg=black ctermfg=green guibg=black guifg=green	" 设置竖对齐线的显示样式
	
	if has("gui_running")
		set guioptions-=T
		set guioptions+=e
		set guitablabel=%M\ %t
	    set guifont=Courier_New_Bold:h14
	    " set guifont=Courier_New_Bold_Italic:h14
	    if OSX()
	        set guioptions-=T
	        set guioptions-=m
	    else
	        set go=
	    endif
	endif

	" 状态栏设置 {
		set laststatus=2 " 总是显示状态栏"
		" 状态栏显示格式 {
			" set statusline=\ %1*\ %{getcwd()}/%t%y
			set statusline=\ %1*\ %t%y
			set statusline+=\ %2*\ %{strftime(\"%Y/%m/%d\ %H:%M\")}
			set statusline+=\ %3*\ %l,%c
		" }
		" 状态栏颜色 根据不同区域，用户，颜色不同 {
			hi User1 cterm=bold ctermfg=232 ctermbg=179 guifg=Black     guibg=Yellow
			hi User2 cterm=None ctermfg=214 ctermbg=242 guifg=Yellow    guibg=Brown
			hi User3 cterm=None ctermfg=251 ctermbg=240 guifg=Black     guibg=DarkYellow
			hi User4 cterm=bold ctermfg=169 ctermbg=239 guifg=Black     guibg=LightYellow
			hi User5 cterm=None ctermfg=208 ctermbg=238 guifg=Black     guibg=LightYellow
			hi User6 cterm=None ctermfg=246 ctermbg=237 guifg=Black     guibg=LightYellow
			hi User7 cterm=None ctermfg=250 ctermbg=238 guifg=Black     guibg=LightYellow
			hi User8 cterm=None ctermfg=249 ctermbg=240 guifg=Black     guibg=LightYellow
		" }
	" }
" }

" 自定义函数 "{
	" 删除缓冲区时候 不退出 
	command! Bclose call <SID>BufcloseCloseIt()
	function! <SID>BufcloseCloseIt()
	   let l:currentBufNum = bufnr("%")
	   let l:alternateBufNum = bufnr("#")
	   if buflisted(l:alternateBufNum)
	     buffer #
	   else
	     bnext
	   endif
	   if bufnr("%") == l:currentBufNum
	     new
	   endif
	   if buflisted(l:currentBufNum)
	     execute("bdelete! ".l:currentBufNum)
	   endif
	endfunction
	" 关闭所有缓冲区
	command! BcloseA call <SID>BufcloseCloseAll()
	function! <SID>BufcloseCloseAll()
		new
		let l:lastBufNr = bufnr("$")
		buffer #
		for l:bufNr in range(l:lastBufNr)
			let l:bufNr = bufnr("%")
			if l:bufNr == l:lastBufNr
				continue
			endif
			if buflisted(l:bufNr)
				execute("bdelete! ".l:bufNr)
			endif
		endfor
	endfunction
	" 关闭缓冲区和窗口
	command! CloseBW call <SID>CloseBuffersAndWindow()
	function! <SID>CloseBuffersAndWindow()
		execute("BcloseA")
		q!
	endfunction
	" 模板函数-文件
	function! Setfilehead()
	    call append(line("."),  '/***********************************************')
	    call append(line(".")+1, '*        Author: zhaojingzhen@weidian.com')
	    call append(line(".")+2, '*        Create: '.strftime("%Y-%m-%d %H:%M:%S"))
	    call append(line(".")+3, '*   Description: ')
	    call append(line(".")+4, '*         Param: ')
	    call append(line(".")+5, '*        Return: ')
	    call append(line(".")+6, '***********************************************/')
	endfunc
" }"

" 插件设置 "{
	" buffline 设置 {
		" let g:bufferline_echo=0
		" autocmd VimEnter *
		" 			\ let &statusline='%{bufferline#refresh_status()}'
		" 			\ .bufferline#get_status_string()
	" }
	" ctags 设置 {
		set tags=./tags;/,~/.vimtags,tags
	" }
	" Tlist 设置 {
		let g:Tlist_path = "$HOME/.vim/bundle/taglist.vim/"
		if isdirectory(expand(g:Tlist_path))
			let g:Tlist_Show_One_File=1     " 只显示当前文件的tag
			let g:Tlist_Exit_OnlyWindow=1   " 如果最后只有Taglist窗口,则退出
			let g:Tlist_WinWidt=25          " 宽度
			let g:Tlist_Use_Right_Window=1  " 在右侧打开窗口
			" let g:Tlist_Auto_Open=1         " 自动打开
			let g:Tlist_Process_File_Always=1 " 始终解析文件

			nnoremap <silent> <leader>t :Tlist<CR>
		endif
	" }
	" NERDTree 设置 {
		" let NERDTreeShowBookmarks=1
		let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
		let NERDTreeChDirMode=0
		let g:NERDTreeMouseMode=2
		let g:NERDTreeShowHidden=1
		let g:NERDTreeKeepTreeInNewTab=1
		let g:nerdtree_tabs_open_on_gui_startup=0
		let g:NERDTreeWinPos="left"
		let g:NERDTreeWinSize=25
		let g:NERDTreeAutoDeleteBuffer=1
		let g:NERDTreeMinimalUI=1
		let g:NERDTreeDirArrows=0
		" let g:NERDTreeQuitOnOpen=1
		" vim 开启时 自动打开nerdtree
		" 并且鼠标停留在文件编辑区
		" if has('gui_running')
		"   autocmd VimEnter * NERDTree
		"   wincmd l
		"   autocmd VimEnter * wincmd l
		" endif

		" 只有nerdtree窗口时，关闭
		autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
		" ,e 打开目录，并移动光标到当前窗口
		noremap     <silent><leader>e   :NERDTreeToggle<Bar>execute "normal <C-l>"<CR>

		" map <Leader>e :NERDTreeToggle()<CR>
	" }
	" 补全设置 (不要更改，除非知道你在做什么) {
		" OmniComplet 补全 {
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
			" set completeopt=menu,preview,longest
			set completeopt=menu,longest

			" neocomplcache 
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
filetype on " 打开文件类型检测 
