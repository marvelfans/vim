set nocompatible

" ------------
" 编码设置
" ------------
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,chinese,cp930,GBK


" ------------
" 基本设置
" ------------

" 回到上次打开的位置
autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \   exe "normal! g`\"" |
            \ endif


" 语法支持
syntax on
syntax enable

" 显示行号
set number

" 命令行数
set history=4096

" 命令补全
set wildmenu

" 忽略的文件
set wildignore=*.0,*~,~.pyc,*.pyc
set wildignore+=venv/**,pictures/**
set wildignore+=*.jpg,*.jpeg

" 退格可用
set backspace=eol,start,indent 

" 以下命令可以换行
set whichwrap+=<,>,h,l

" 搜索忽略大小写
" set ignorecase

" 智能搜索 如果没有,自动上一个搜索单词
set smartcase

" 高亮搜索单词
set hlsearch

" 每插入一个字符,就高亮一个 => 匹配影响速度
" set incsearch

" 显示匹配插号 => 匹配影响速度
" set showmatch

" 匹配时间 => 匹配影响速度
" set matchtime=2

" 延迟加载 
set lazyredraw

" 不要警告声音
set noerrorbells

" 不要警告闪屏
set novisualbell
set t_vb=
set tm=500

" 代码折叠
" set fdm=indent

" 鼠标模式
set mouse=a

" 鼠标可以在行未后一个字符
set virtualedit=onemore

" 不要备份文件
set nobackup

" 不要临时文件
set nowb

" 不要交换文件
set noswapfile

" 用空格代替tab
set expandtab   " noexpandtab

" 智能插入tab
set smarttab

" 缩进的空格数
set shiftwidth=4

" tab的空格数
set tabstop=4

" 对于长行，自动断行
set linebreak

" 自动使用当前行的缩进为下行缩进
set autoindent

" 自动缩进
set smartindent

" 一直显示状态栏
set laststatus=2

" 命令行高度
set cmdheight=1

" 共享粘贴板
" set clipboard=unnamedplus,unnamed

" 当文件修改时, 自动载入
set autoread

" viminfo保存vim状态的记录文件
" <20 每个寄存器最多保存100行
" '10 保存最近50个文件的标记
" /10 保存搜索历史条数
" :20 保存最近20个命令
" h 载入viminfo时,关闭hlsearch高亮
" s10 最多保存10个寄存器
set viminfo=<20,'10,/10,:20,h,s10
