function! MyFun_echo(text) "{{{
    call v:lua.vim.notify(a:text)
endfunc "}}}

function! MyFun_input(prompt, text, completion) "{{{
    let height = &cmdheight
    call inputsave()
    exec 'set cmdheight=1'
    if a:completion != ''
        let key = input(a:prompt, a:text, a:completion)
    else
        let key = input(a:prompt, a:text)
    endif
    exec 'set cmdheight=' .. height
    call inputrestore()
    return key
endfunc "}}}

function! MyFun_is_special_buffer(bt) "{{{
    let buftype = a:bt != '' ? a:bt : getbufvar('%', '&filetype')
    let buffers = g:ignore_filetypes
    let ret = 0
    for name in buffers
        if name ==# buftype
            let ret = 1
            break
        endif
    endfor
    unlet buffers
    return ret
endfunc "}}}

"{{{ MyScroll
command! MyScroll call s:_MyScrollBinder()
function s:_MyScrollBinder()
    " first set then split windo
    let select = str2nr(MyFun_input('Select(1/V, 2/H, 0/Cancel) : ', ' ', ''))
    if select == 1
        set scrollbind
        set scrollopt=ver
    elseif select == 2
        set scrollbind
        set scrollopt=hor
    else
        set noscrollbind
    endif
endfunction "}}}

 "{{{ MyCLopen
command! MyBottomCopen  call s:_MyCLopen('cwindow', 0)
command! MyTopCopen     call s:_MyCLopen('cwindow', 1)
command! MyBelowCopen   call s:_MyCLopen('cwindow', 2)
command! MyAboveCopen   call s:_MyCLopen('cwindow', 3)
command! MyBottomLopen  call s:_MyCLopen('lwindow', 0)
command! MyTopLopen     call s:_MyCLopen('lwindow', 1)
command! MyBelowLopen   call s:_MyCLopen('lwindow', 2)
command! MyAboveLopen   call s:_MyCLopen('lwindow', 3)
function s:_MyCLopen(cmd, place)
    let h = winheight(0) / 2
    if h < 5
        let h = ''
    endif
    if a:place == 0
        execute "silent! botright " . a:cmd . " " . h
    elseif a:place == 1
        execute "silent! topleft " . a:cmd . " " . h
    elseif a:place == 2
        execute "silent! belowright " . a:cmd . " " . h
    elseif a:place == 3
        execute "silent! aboveleft " . a:cmd . " " . h
    else
        let w = winwidth(0) / 2 - 5
        if w < 5
            execute "silent! vertical " . a:cmd . " ". w
        else
            execute "silent! vertical " . a:cmd
        endif
    endif
endfunction
"}}}

"{{{ MyColColor
" autocmd FileType nerdtree,tagbar,lookupfile setlocal cc=""
command! MyColColor call s:_MyColColor()
function! s:_MyColColor()
    let cx = &colorcolumn
    let cz = "+1,86," . col(".")
    if cx != '' && cx == cz
        exec "set cc=\"\""
    else
        "+1表示textwidth后一列标亮
        exec "set cc=+1,86," . col(".")
    endif
endfunc
"}}}

"{{{ MyBufExplorer 
command! MyBufExplorer call s:DoBufExplorer()
function! s:DoBufExplorer()
    let buftype = getbufvar('%', '&filetype')
    if buftype == 'leaderf'
        exec 'normal q'
    else
        " TODO fullscreen is error
        exec 'silent Leaderf! buffer --popup --popup-height=0.99'
    endif
endfunction
"}}}

"{{{ MyMarkColor
command! MyMarkColor call s:_MyMarkColor()
function! s:_MyMarkColor()
    exec "Mark " . expand("<cword>")
endfunc
"}}}

"{{{ MyMarksBrowser
command! MyMarksBrowser call s:_MyMarksBrowser()
function! s:_MyMarksBrowser()
    let buftype = getbufvar('%', '&filetype')
    " if MyFun_is_special_buffer(buftype)
    "     return
    " endif
    if buftype == "TelescopePrompt"
        exec 'normal q'
    else
        exec 'Telescope marks mark_type=all'
    endif
endfunction
"}}}

"{{{MyDoSave
command! MyDisplayPath call s:_MyDisplayPath()
function! s:_MyDisplayPath()
    let p = expand('%:p')
    let h = expand('%:p:h')
    call setreg('*', p)
    call setreg('+', h)
    call MyFun_echo(p)
endfunction
"}}}

command! MyWindowClose call s:_MyFun_WindowClose()
function! s:_MyFun_WindowClose()"{{{
    let tid = tabpagenr() 
    if tabpagenr('$') != 1
        if tabpagewinnr(tid, '$') == 2
            for nr in tabpagebuflist(tid)
                if bufname(nr) =~ 'NvimTree'
                    exec ':tabclose'
                    return
                endif
            endfor
        endif
    endif
    exec ':q!'
endfunction
"}}}

command! MyNvimTreeSwitchBuffer call s:_MyFun_if_nvimtree_then_switch()
function! s:_MyFun_if_nvimtree_then_switch()"{{{
    let buftype = getbufvar('%', '&filetype')
    if buftype == 'NvimTree'
        exec ':wincmd w'
    endif
endfunction
"}}}
