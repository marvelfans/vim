"----------------------------
"    外观相关设置
"----------------------------
set t_Co=256
highlight clear CursorLineNr
highlight clear LineNr
highlight clear SignColumn
" 背景颜色无法刷新的情况
if &term =~ '256color'
  set t_ut=
endif

" 主题设置与高行当前行与列
color zenburn
set cursorline
set cursorcolumn

" ---------------
" tab显示设置
" ---------------
" Rename tabs to show tab# and # of viewports 
if exists("+showtabline") 
    function! MyTabLine() 
        let s = '' 
        let wn = '' 
        let t = tabpagenr() 
        let i = 1 
        while i <= tabpagenr('$') 
            let buflist = tabpagebuflist(i) 
            let winnr = tabpagewinnr(i) 
            let s .= '%' . i . 'T' 
            let s .= (i == t ? '%1*' : '%2*') 
            let s .= ' ' 
            let wn = tabpagewinnr(i,'$') 

            let s .= (i== t ? '%#TabNumSel#' : '%#TabNum#') 
            let s .= i 
            if tabpagewinnr(i,'$') > 1 
                let s .= '.' 
                let s .= (i== t ? '%#TabWinNumSel#' : '%#TabWinNum#') 
                let s .= (tabpagewinnr(i,'$') > 1 ? wn : '') 
            end 

            let s .= ' %*' 
            let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#') 
            let bufnr = buflist[winnr - 1] 
            let file = bufname(bufnr) 
            let buftype = getbufvar(bufnr, 'buftype') 
            if buftype == 'nofile' 
                if file =~ '\/.' 
                    let file = substitute(file, '.*\/\ze.', '', '') 
                endif 
            else 
                let file = fnamemodify(file, ':p:t') 
            endif 
            if file == '' 
                let file = '[No Name]' 
            endif 
            let s .= file 
            let s .= (i == t ? '%m' : '') 
            let i = i + 1 
        endwhile 
        let s .= '%T%#TabLineFill#%=' 
        return s 
    endfunction 
endif 

function MyTabLabel(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    return bufname(buflist[winnr - 1])
endfunction

hi TabLineSel term=bold cterm=bold ctermfg=16 ctermbg=229
hi TabWinNumSel term=bold cterm=bold ctermfg=90 ctermbg=229
hi TabNumSel term=bold cterm=bold ctermfg=16 ctermbg=229
hi TabLine term=underline ctermfg=16 ctermbg=145
hi TabWinNum term=bold cterm=bold ctermfg=90 ctermbg=145
hi TabNum term=bold cterm=bold ctermfg=16 ctermbg=145
" 最多可以显示15个tab
set tabpagemax=15
" 需要的时候才展示
set tabline=1
set tabline=%!MyTabLine()
