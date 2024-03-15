func! s:TmpLoadTagDB(force, root) "{{{
    let flg = str2nr(a:force, 10)
    if flg == 1
        let dbfile = s:FindTagDB(a:root)
    else
        let dbfile = s:DeleteTagDB(a:root)
    endif
    if flg == 0
        return
    endif
    let tagdirs = s:CreateTagDB(a:root)
    call s:Loading(tagdirs)
endfunc "}}}

func! s:FindTagDB(root) "{{{
    let path = a:root
    while 1 < len(path)
        let dbfile = '/tmp/tags' . path . '/.tags/tags'
        if filereadable(dbfile)
            return dbfile
        endif
        let path = fnamemodify(path, ':h')
    endwhile
    return ''
endfunc "}}}

func! s:DeleteTagDB(root) "{{{
    let path = a:root
    while 1 < len(path)
        let dir = '/tmp/tags' . path . '/.tags'
        if isdirectory(dir)
            call system("rm " . ' -rf ' . dir)
        endif
        let path = fnamemodify(path, ':h')
    endwhile
    return ''
endfunc "}}}

func! s:CreateTagDB(root) "{{{
    let dbrun = '0gentag.sh'
    let inputdir = substitute(input("source dir:", a:root, "dir"), '\/$', '', '')
    let tagsdir = expand('$TMP_TAGS' . inputdir . '/.tags')
    if !isdirectory(tagsdir)
        call mkdir(tagsdir, 'p')
    endif
    exec "silent! messages clear"
    call system(dbrun . ' -y -s ' . inputdir . ' -t ' . tagsdir . ' >/dev/null')
    return [tagsdir]
endfunc "}}}

func! s:BuildTagDB(root) "{{{
    exec "silent! messages clear"
    exec "silent! redraw"
    let res = str2nr(input("Select(1.build 2.rebuild 3.delete): ", ''), 10)
    if res == 1
        " build or load
        call s:TmpLoadTagDB(1, a:root)
    elseif res == 2
        " delete and load
        call s:TmpLoadTagDB(2, a:root)
    elseif res == 3
        " delete
        call s:TmpLoadTagDB(0, a:root)
    else
        return
    endif
endfunc "}}}

func! s:Loading(tagdirs) "{{{
    " 清空原全局tags
    set tags=
    for item in a:tagdirs
        let tagfile = item . '/tags'
        if filereadable(tagfile)
            exec 'set tags+=' . tagfile
        endif
    endfor
endfunc "}}}

func! s:LoadTagDB(root, tagdir) "{{{
    if len(a:tagdir) == 0
        echomsg 'You must add envirenment tags, export tags=your_fix_tagdirs in ~/.profile file'
        return
    endif

    let subdirs = [ ]
    let tagdirs = [ ]
    let i = 0
    exec "silent! messages clear"
    exec "silent! redraw"

    " 1. tags环境变量中的db (掉电不丢失)
    let dirs = globpath(a:tagdir . '/*', "")
    for subdir in dirs
        let subdir = substitute(subdir, '\/$', '', '')
        let dbfile = subdir . '/tags'
        if filereadable(dbfile)
            let i = i + 1
            echomsg ' ' . i . ' ' . subdir
            call add(subdirs, subdir)
        endif
    endfor

    " 2 临时目录下的tags
    if isdirectory($TMP_TAGS)
        let s:dirs = split(system("dirname `find " . $TMP_TAGS . " -name .tags -type d` 2>/dev/null "), '\n')
        for subdir in s:dirs
            let i = i + 1
            echomsg ' ' . i . ' ' . substitute(subdir, $TMP_TAGS, '', '')
            call add(subdirs, subdir . '/.tags')
        endfor
    endif

    " 3. 选择并设置tags
    let tmpstr = input("Select(,): ", '')
    exec 'silent! messages clear'
    exec 'redraw'
    echomsg " Loaded!"
    let nums = split(tmpstr, ',')
    for strn in nums
        let n = str2nr(strn, 10) - 1
        if n >= 0 && n <= i
            call add(tagdirs, subdirs[n])
        endif
    endfor

    " 5. 加载
    call s:Loading(tagdirs)

    unlet tagdirs
    unlet subdirs
endfunc "}}}

func! MyTags() "{{{
    exec 'lchdir %:p:h'
    let root = getcwd()
    let sel = str2nr(input("Select(1.load 2.create):", ''), 10)

    let tagdir = $TAG_HOME
    if len(tagdir) == 0
        if isdirectory($HOME . '/.tags')
            let tagdir = $HOME . '/.tags'
        else
            echomsg "not set TAG_HOME env"
            return
        endif
    endif

    if sel == 1
        call s:LoadTagDB(root, tagdir)
    elseif sel == 2
        call s:BuildTagDB(root)
    endif
endfunc "}}}
