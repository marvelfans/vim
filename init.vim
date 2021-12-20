" ------------
" 入口文件
" -----------

" 防止重复加载
if get(s:, 'loaded', 0) != 0
	finish
else
	let s:loaded = 1
endif

" 取得本文件所在的目录
let s:home = fnamemodify(resolve(expand('<sfile>:p')), ':h')

" 定义一个命令用来加载文件
command! -nargs=1 LoadScript exec 'so '.s:home.'/'.'<args>'

" 将 vim-init 目录加入 runtimepath
exec 'set rtp+='.s:home

" 将 ~/.vim 目录加入 runtimepath (有时候 vim 不会自动帮你加入）
set rtp+=~/.vim

" ---------------
" 模块加载
" ---------------

" 加载基础配置
LoadScript init/init-basic.vim

" 加载插件
LoadScript init/init-plugins.vim

" 主题配色设置
LoadScript init/init-style.vim

" 快捷键设置
LoadScript init/init-shortcut.vim
