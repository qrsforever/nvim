local CONFIG = {}

_G._leaderf_loaded = 0

---@diagnostic disable-next-line: undefined-field
table.insert(_G.ignore_filetypes, 'leaderf')

function CONFIG.setup()
    if _G._leaderf_loaded == 0 then
        vim.cmd([[
            let g:Lf_ShortcutF = '@nullf'
            let g:Lf_ShortcutB = '@nullb'
            let g:Lf_CacheDirectory = g:nvim_cache_path
            let g:Lf_WindowPosition = 'popup'  "top bottom popup
            let g:Lf_WindowHeight = 0.5
            let g:Lf_TabpagePosition = 3  " put tabpage to the last
            let g:Lf_PythonVersion = 3
            let g:Lf_ShowRelativePath = 0
            let g:Lf_CursorBlink = 0
            let g:Lf_DefaultMode = 'NameOnly'
            let g:Lf_MruFileExclude = ['*.so', '*.class', '*.o', '*.pyc']
            let g:Lf_MruMaxFiles = 80
            let g:Lf_UseVersionControlTool = 1
            let g:Lf_DefaultExternalTool = 'rg'
            let g:Lf_UseCache = 1
            let g:Lf_StlColorscheme = 'default'
            let g:Lf_PopupColorscheme = 'gruvbox_default'
            let g:Lf_PreviewInPopup = 0
            let g:Lf_ShowDevIcons = 1
            let g:Lf_PopupWidth = &columns  " preview must top-bottom mode
            let g:Lf_PopupHeight = 0.5
            let g:Lf_PopupPosition = [float2nr(&lines * 0.5) - 1, 3]
            let g:Lf_PopupShowStatusline = 1
            let g:Lf_PopupPreviewPosition = 'top'
            let g:Lf_PopupAutoAdjustHeight = 0
            let g:Lf_PopupBorders = ["═","║","═","║","╔","╗","╝","╚"]
            " let g:Lf_PopupBorders = ["━","┃","━","┃","┏","┓","┛","┗"]

            " only input mode work
            let g:Lf_QuickSelect = 1
            let g:Lf_QuickSelectAction = 1

            let g:Lf_EnableCircularScroll = 1

            let g:Lf_Ctags = 'ctags'
            let g:Lf_CtagsFuncOpts = {
                \ 'c': '-I __THROW --c++-kinds=+p --c-kinds=fp --fields=+ialS --extra=+q',
                \ 'rust': '--rust-kinds=f',
            \ }

            let g:Lf_RgConfig = [
                \ "--max-columns=0",
                \ "--case-sensitive",
                \ "--glob=!git/*",
            \ ]


            let g:Lf_WildIgnore = {
                \ 'dir': ['.svn','.git','.hg','out','output', 'build', '.venv*'],
                \ 'file': ['*.sw?','~$*','*.bak','*.exe','*.o','*.class','*.so','*.py[co]', '*.png', '*.jpg', '*.jpeg']
            \ }

            let g:Lf_PreviewResult = {
                \ 'File': 0,
                \ 'Buffer': 0,
                \ 'Mru': 0,
                \ 'Tag': 0,
                \ 'BufTag': 0,
                \ 'Function': 0,
                \ 'Line': 0,
                \ 'Jumps': 0,
                \ 'Colorscheme': 0,
                \ 'Rg': 1,
                \ 'Gtags': 0,
            \}

            let g:Lf_RootMarkers = ['.project', '.svn', '.git', '.hg', '.gradle', '.flake8']
            let g:Lf_HideHelp = 1

            let g:Lf_StlPalette = {
                \ 'stlBlank': {
                    \ 'gui': 'NONE',
                    \ 'font': 'NONE',
                    \ 'guifg': 'NONE',
                    \ 'guibg': '#303136',
                    \ 'cterm': 'NONE',
                    \ 'ctermfg': '145',
                    \ 'ctermbg': '236'
                    \},
            \}

            let g:Lf_CommandMap = {
                \ '<C-X>': ['<C-S>'],
                \ '<C-]>': ['<C-V>'],
                \ '<Tab>': ['<Tab>', '<C-I>'],
            \}

            " TODO below is not work
            " let g:Lf_NormalCommandMap = {
            " \ "*":      {
            " \            "<C-h>": "j",
            " \            "<C-k>": "k",
            " \           },
            " \}

            " TODO '_' is not work
            let g:Lf_NormalMap = {
                \ "Rg":[
                    \ ["<C-j>", ':exec g:Lf_py "rgExplManager._toDownInPopup()"<CR>'],
                    \ ["<C-k>", ':exec g:Lf_py "rgExplManager._toUpInPopup()"<CR>']
                    \ ],
                \ "Mru":      [ ["<Tab>", "j"] ],
                \ "BufTag":   [ ["<Tab>", "j"] ],
                \ "Buffer":   [ ["<Tab>", "j"] ],
                \ "Window":   [ ["<M-q>", "j"] ],
                \ "History":  [ ["i", ':exec g:Lf_py "historyExplManager.input()"<CR>'] ],
                \ "Command":  [ ["i", ':exec g:Lf_py "commandExplManager.input()"<CR>'] ]
            \}

            "        s : select file (multiple selected)
            "    <C-C>, <ESC> : quit from LeaderF.
            "    <C-R> : switch between fuzzy search mode and regex mode. (文本搜索) (按i进入输入模式有效)
            "    <C-F> : switch between full path search mode and name only search mode. (文件搜索)
            "    <Tab> : switch to normal mode.
            "    <C-V>, <S-Insert> : paste from clipboard.
            "    <C-U> : clear the prompt.
            "    <C-J>, <C-K> : navigate the result list.
            "    <Up>, <Down> : recall last/next input pattern from history.
            "    <2-LeftMouse> or <CR> : open the file under cursor or selected(when
            "                            multiple files are selected).
            "    <C-X> : open in horizontal split window.
            "    <C-]> : open in vertical split window.
            "    <C-T> : open in new tabpage.
            "    <F5>  : refresh the cache.
            "    <C-LeftMouse> or <C-S> : select multiple files.
            "    <S-LeftMouse> : select consecutive multiple files.
            "    <C-A> : select all files.
            "    <C-L> : clear all selections.
            "    <BS>  : delete the preceding character in the prompt.
            "    <Del> : delete the current character in the prompt.
            "    <Home>: move the cursor to the begin of the prompt.
            "    <End> : move the cursor to the end of the prompt.
            "    <Left>: move the cursor one character to the left.
            "    <Right> : move the cursor one character to the right.
            "    <C-P> : preview the result.

            function! s:DoLeaderfFileWithPath(cwd)
                let dir = expand("<cfile>")
                if a:cwd != 1
                    let tmp = getreg("*")
                    if len(tmp) < 128
                        let dir = tmp
                    endif
                endif
                if ! isdirectory(dir)
                    let dir = getcwd()
                endif
               let dir = MyFun_input("DIR@", dir, 'dir')
               if isdirectory(dir)
                   exec 'silent Leaderf! file --no-ignore --regexMode ' . dir
               endif
            endfunc

            function! s:DoLeaderfRgWithPath(cwd, nwrap, cbuf, icase, append)
                let key = expand("<cword>")
                if a:cwd != 1 || len(key) < 2
                    let tmp = getreg("*")
                    if len(tmp) < 88
                        let key = tmp
                    endif
                    let key = MyFun_input("KEY@", "\"" . key . "\"", 'var')
                endif
                if key == ""
                    return
                endif
                let tmpstr = ''
                let dirstr = ''
                if a:nwrap == 1
                    let tmpstr = tmpstr . ' --nowrap'
                endif
                if a:icase == 1
                    let tmpstr = tmpstr . ' --ignore-case'
                endif
                if a:append == 1
                    let tmpstr = tmpstr . ' --append'
                endif
                if a:cbuf == 1
                    exec "lchdir %:p:h"
                    let tmpstr = tmpstr . ' --current-buffer'
                elseif a:cbuf == 2  " gG
                    exec "lchdir %:p:h"
                    let tmpstr = tmpstr . ' --all-buffers'
                else
                    let dirstr = MyFun_input('[' . key . ']DIR@', getcwd(), 'dir')
                    if dirstr == ""
                        return
                    endif
                    " let tmpstr = tmpstr . ' --stayOpen'  " cannot use with --popup
                endif
                exec 'silent Leaderf! rg' . tmpstr . ' -e ' key . ' ' . dirstr
            endfunc
            "}}}

            " Leader!: normal mode; Leader：insert mode
            " usage: Leaderf[!] [-h] [--reverse] [--stayOpen] [--input <INPUT> | --cword]
            " [--top | --bottom | --left | --right | --belowright | --aboveleft | --fullScreen]
            " [--nameOnly | --fullPath | --fuzzy | --regexMode] [--nowrap]
            " {file,tag,function,mru,searchHistory,cmdHistory,help,line,colorscheme,self,bufTag,buffer,rg}

            " Warning conflict with unite.vim or fuzzyfinder or telescope
            " nnoremap <unique> <silent> sb :<C-U>Leaderf! buffer --nameOnly --nowrap<CR>

            " 搜索[当前目录]中的字符
            " nnoremap <unique> <silent> sS :<C-U>Leaderf rg --stayOpen --ignore-case --nowrap<CR>

            " 搜索[当前目录]中的文件
            " nnoremap <unique> <silent> ff :<C-U>Leaderf! file --no-ignore<CR>

            " 搜索[当前字符]最近文件
            " nnoremap <unique> <silent> sn :<C-U>Leaderf! mru --nowrap<CR>
            " nnoremap <unique> <silent> sN :<C-U>Leaderf mru --cword --regexMode --nowrap<CR>

            " 查找[所有]buffer中某个函数名或变量
            " nnoremap <unique> <silent> s, :<C-U>Leaderf! bufTag --nowrap<CR>
            " nnoremap <unique> <silent> s< :<C-U>Leaderf! bufTag --all --nowrap --stayOpen<CR>

            " 查找[所有]buffer中的某个函数
            " nnoremap <unique> <silent> s. :<C-U>Leaderf! function --nowrap<CR>
            " nnoremap <unique> <silent> s> :<C-U>Leaderf! function --all --nowrap --stayOpen<CR>

            " 从Tag文件中查找某个函数或变量名 (], })留给YCM使用
            " nnoremap <unique> <silent> s[ :<C-U>Leaderf tag --cword --regexMode --nowrap<CR>
            " nnoremap <unique> <silent> s{ :<C-U>Leaderf tag --nowrap --stayOpen<CR>

            " 搜索字符串 parameter(--cword --nowrap --current-buffer --ignore-case --append)
            nnoremap <unique> <silent> ss :call <SID>DoLeaderfRgWithPath(1, 1, 1, 1, 0)<CR>
            " nnoremap <unique> <silent> sG :call <SID>DoLeaderfRgWithPath(0, 1, 2, 1, 0)<CR>
            nnoremap <unique> <silent> s+ :call <SID>DoLeaderfRgWithPath(1, 1, 1, 1, 1)<CR>

            nnoremap <unique> <silent> s/ :call <SID>DoLeaderfRgWithPath(1, 1, 0, 1, 0)<CR>
            nnoremap <unique> <silent> s? :call <SID>DoLeaderfRgWithPath(0, 1, 0, 1, 0)<CR>

            nnoremap <unique> <silent> f/ :call <SID>DoLeaderfFileWithPath(1)<CR>
            nnoremap <unique> <silent> f? :call <SID>DoLeaderfFileWithPath(0)<CR>

            " nnoremap <unique> <silent> sw :Leaderf! rg --nowrap --stayOpen --recall<CR><CR>
        ]])
    end
    _G._leaderf_loaded = 1
end

return CONFIG
