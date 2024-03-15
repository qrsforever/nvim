-- terminal: font set: Hack Nerd Font Mono 15
-- vim.cmd [[ set packpath+=~/.config/nvim/other ]]

_G.ignore_filetypes = { 'qf', 'help', 'sagaoutline' }
_G.nvim_config_path = vim.fn.stdpath('config')
_G.nvim_cache_path = vim.fn.stdpath('cache')
_G.nvim_data_path = vim.fn.stdpath('data')
_G.sys_hostname = os.getenv('RSYNC') and 'R-' .. vim.fn['hostname']() or 'L-' .. vim.fn['hostname']()

_G.left_siderbar_width = 32
_G.right_siderbar_width = 35
_G.quickfix_bottom_height = 15

vim.cmd(string.format('let g:nvim_config_path = "%s"', _G.nvim_config_path))
vim.cmd(string.format('let g:nvim_cache_path = "%s"', _G.nvim_cache_path))
vim.cmd(string.format('let g:nvim_data_path = "%s"', _G.nvim_data_path))
vim.cmd(string.format('let g:sys_hostname = \"%s\"', _G.sys_hostname))
vim.cmd(string.format('let g:left_siderbar_width = %d', _G.left_siderbar_width))
vim.cmd(string.format('let g:right_siderbar_width = %d', _G.right_siderbar_width))
vim.cmd(string.format('let g:quickfix_bottom_height = %d', _G.quickfix_bottom_height))

vim.cmd [[

    " 全局变量"{{{
    let g:mapleader = ","
    let g:loaded_netrw = 1
    let g:loaded_netrwPlugin = 1
    let g:loaded_AlignMapsPlugin = 1
    let $TMP_TAGS = '/tmp/tags'
    "}}}

    " 定义命令"{{{
    command XCCTags !ctags --c++-kinds=+p --fields=+ialS --extra=+q -R .
    command XRS %s/\s\+$//ge     "消除每行后面的多余的空格
    " XRW:%s/<C-V><C-M>$//g"
    command XONE 0,$s/\n//       "多行变一行
    command XRD %s/^\d\{1,4}$\n//ge "消除只含数字的行
    " sudo usermod -a -G sudo $USER
    " 或者: /etc/sudoers: $USER ALL=(ALL) NOPASSWD: ALL
    command XW execute ':silent w !sudo tee % > /dev/null' | :edit!
    command XM message
    command XN Notifications

    "cwindow lwindow
    command! Cnext try | cnext | catch | try | cfirst | catch | endtry | endtry
    command! Cprev try | cprev | catch | try | clast  | catch | endtry | endtry
    command! Lnext try | lnext | catch | try | lfirst | catch | endtry | endtry
    command! Lprev try | lprev | catch | try | llast  | catch | endtry | endtry
    command! Lw try | lw | catch | endtry
    command! Cw try | cw | catch | endtry

    cabbrev cnext Cnext
    cabbrev cprev CPrev
    cabbrev lnext Lnext
    cabbrev lprev Lprev
    cabbrev lw Lw
    cabbrev cw Cw

    " 自己定义的命令 "}}}

	" 窗口配置"{{{
	" 让terminal进入norm模式
    tnoremap <Esc> <C-\><C-N>
    tnoremap <C-h> <C-\><C-N><C-w>h
    tnoremap <C-j> <C-\><C-N><C-w>j
    tnoremap <C-k> <C-\><C-N><C-w>k
    tnoremap <C-l> <C-\><C-N><C-w>l

	noremap <C-j> <C-W>j
	noremap <C-k> <C-W>k
	noremap <C-h> <C-W>h
	noremap <C-l> <C-W>l

	" <C-W>r --> 交换窗口
	noremap <C-W>v <C-W>v<C-W>l
	noremap <C-W>x <C-W>s<C-W>j
	noremap <unique> <silent> <C-W>q :MyWindowClose<cr>
    noremap <unique> <silent> X :MyWindowClose<CR>
	" 窗口配置"}}}

	" 简单配置"{{{

    " set shell=bash\ -i
    " 打开上一次位置
    au BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \     exe "normal! g'\"" |
        \ endif

	" 设置终端支持256颜色
	set t_Co=256
    if has("termguicolors")
        set termguicolors
    endif

	" 粘贴板(export DISPLAY=:0.0)
	" + : clipboard, common-key-bind ctrl+c, (ctrl+c, ctrl + v / 右击粘贴)
	" * : primary, copy-on-select (选择的内容, shift + insesrt / 滚轮点击)
	" (y, d, s x)默认的未命名寄存器与系统剪贴板板关联上关联上
    " not work in docker container
	set clipboard^=unnamed,unnamedplus
    set mouse=a
    set mousemoveevent
	imap <C-v> <ESC>"+pa
	vmap <C-c> "+y

    " 下面这个行会影响which-key in virutal mode
    " vmap <LeftRelease> "*ygv

	" Alt组合键不映射到菜单上
	set winaltkeys=no

	" 写备份但关闭vim后自动删除
	set writebackup

	" vi兼容开关 当使用omni自动补全时,要设置
	set nocompatible

	" 不使用swap文件
	set noswapfile

	" 关闭遇到错误时的声音提示
	set noerrorbells

	" 不要闪烁
	set novisualbell

	"使用空格来替换tab
	set expandtab

	"多标签设置
	set showtabline=1 "0表示从不显示标签栏 1表示打开文件多于一个时显示标签栏 2表示总是显示标签栏
	set tabpagemax=15 "标签个数

	"打开 VIM 的状态栏标尺
	set ruler
	set laststatus=2 "always show

	" 当光标达到上端或下端时 翻滚的行数
	set scrolljump=0

	" 当光标达到水平极端时 移动的列数
	set sidescroll=0

	" 当光标距离极端(上,下,左,右)多少时发生窗口滚动
	set scrolloff=2

	" 当使用vimdiff比较文件,相比较的比较文件同步滚动,但是splite分割窗口, 两个窗口也同步
	"set scrollbind

	set autoread              " read open files again when changed outside Vim ( 同步 )
	set autowriteall          " write a modified buffer on each :next , ... ( 跳到另一个文件时,自动保存上个文件 )
	set modified

	" 设置VIM行号
	set nu

	" Tab 宽度
	set ts=4

	" 自动缩进的时候, 缩进尺寸
	set sw=4
	set softtabstop=4

	" 显示括号配对情况 wrong
	set sm  "smartmatch

	" 开启新行时使用智能自动缩进
	set smartindent

	" 搜索时忽略大小写，但在有一个或以上大写字母时仍保持对大小写敏感
	set ignorecase smartcase

	" 输入搜索内容时就显示搜索结果
	set incsearch

	" 搜索时高亮显示被找到的文本
	set hlsearch

	" use backspace delete a word.
	set backspace=indent,eol,start
	" indent: 如果用了:set indent,:set ai 等自动缩进,想用退格键将字段缩进的删掉,必须设置这个选项.否则不响应.
	" eol:如果插入模式下在行开头,想通过退格键合并两行,需要设置eol.
	" start：要想删除此次插入前的输入,需设置这个.

	" 内容多时,是否换行显示
	set nowrap

	" characters to show before wrapped lines
	set showbreak=<<>>

	" 启动的时候不显示那个援助乌干达儿童的提示
	" set shortmess=aoOWtI
    set shortmess+=IWsa
    " noshow like '-- INSERT --' or '-- VISUAL LINE --'
    set noshowmode
    set cmdheight=1

	"通过使用: commands命令，告诉我们文件的哪一行被改变过 ( 不习惯 )
	" set report=1

	"在被分割的窗口间显示空白，便于阅读 (没看到效果)
	"stl:\       : 当前窗口状态栏显示'空格' ('\'转义字符)
	"stlnc:-     : 非当前窗口状态栏显示---
	"vert:\|     : 垂直分割线为|
	"fold:-      : 若设置折叠功能,折叠后显示---
	set fillchars=stl:\ ,stlnc:\ ,vert:\|,fold:-,diff:-

	"带有如下符号的单词不要被换行分割
	set iskeyword+=_,$,@,%,#

	" 保留历史记录
	set history=500

	" 英文单词在换行时不被截断
	set linebreak

	" 设置每行多少个字符自动换行，加上换行符
	set textwidth=106
	" 选中已有行执行 gq 可以自动换行 或者 gq=G 或者 gggqG
	" highlight column after 'textwidth'
	" set cc=+1
	" fo = formatoptions:
	" t：根据 textwidth 自动折行；
	" c：在（程序源代码中的）注释中自动折行，插入合适的注释起始字符；
	" r：插入模式下在注释中键入回车时，插入合适的注释起始字符；
	" q：允许使用“gq”命令对注释进行格式化；
	" n：识别编号列表，编号行的下一行的缩进由数字后的空白决定（与“2”冲突，需要“autoindent”）；
	" 2：使用一段的第二行的缩进来格式化文本；
	" l：在当前行长度超过 textwidth 时，不自动重新格式化；
	" m：在多字节字符处可以折行，对中文特别有效（否则只在空白字符处折行）；
	" M：在拼接两行时（重新格式化，或者是手工使用“J”命令），如果前一行的结尾或后一行的开头是多字节字符，则不插入空格，非常适合中文
	set fo+=Mm

	" 光标可以定位在没有实际字符的地方
	"set ve=block

	"显示匹配的括号([{和}])
	set showmatch

	" 短暂跳转到匹配括号的时(0.5s)
	set matchtime=1

	"多少个键被敲下后执行一次交换文件刷新
	"set updatecount=40  "设置敲入40个字符后执行

	"交换文件刷新后的超时时间
	set updatetime=500  "x毫秒秒后刷新
	":preserve "若设置的时间过长,该命令会手工的存入交换文件中.

	" When using make, where should it dump the file, please see ./bundle/.config/errormarker.vim_conf.vim
	" set makeprg=make\ -j4
	" set makeprg=ant
	set makeef=errors

	"lz 如果设置本选项,执行宏,寄存器和其它不通过输入的命令时屏幕不会重画.另外,窗口标题的刷新也被推迟.要强迫刷新,使用:redraw.
	"set lz "lazyredraw / 'lz'   (缺省关闭)
	" set redrawtime=4000

	"过长的行显示不全
	set display=lastline

	" horiz split new windows below current
	set splitbelow
	" vert split new windows to right of current
	set splitright

	" Ignore compiled files
	set wildignore=*.o,*~,*.pyc,*.sh,*.png,.git\*,.hg\*,.svn\*

	" 简单配置"}}}

    " 折叠功能"{{{
    " 折叠方式,可用选项 ‘foldmethod’ 来设定折叠方式：set fdm=***
    " 有 6 种方法来选定折叠：
    " manual           手工定义折叠
    " indent           更多的缩进表示更高级别的折叠
    " expr             用表达式来定义折叠
    " syntax           用语法高亮来定义折叠
    " diff             对没有更改的文本进行折叠
    " marker           对文中的标志折叠
    " 常用的折叠快捷键
    " zf  创建折叠 (marker 有效)
    " zo  打开折叠
    " zO  对所在范围内所有嵌套的折叠点展开
    " zc  关闭当前折叠
    " zC  对所在范围内所有嵌套的折叠点进行折叠
    " [z  到当前打开的折叠的开始处。
    " ]z  到当前打开的折叠的末尾处。
    " zM  关闭所有折叠 (我喜欢)
    " zr  打开所有折叠
    " zR  循环地打开所有折叠
    " zE  删除所有折叠
    " zd  删除当前折叠
    " zD  循环删除 (Delete) 光标下的折叠，即嵌套删除折叠
    " za  若当前打开则关闭，若当前关闭则打开  ( 这个就足够了)
    " zA  循环地打开/关闭当前折叠
    " zj  到下一折叠的开始处
    " zk  到上一折叠的末尾
    " set foldmethod=indent
    " set foldmarker={{{,}}}
    " 要想在{  } 代码块中折叠，按空格键
    " foldmethod=syntax 与 c.vim 中的 \cc 注释功能冲突
    " set foldenable            " 开始折叠
    " set foldopen=all
    " set foldclose=all          " 设置为自动关闭折叠
    set foldmethod=marker
    set nofoldenable            " telescope grep_string fold problem
    set foldcolumn=0            " 设置折叠区域的宽度
    set foldlevel=1             " 设置折叠层数为
    "vim折叠功能"}}}

    " Fx快捷键-- {{{
    nmap <unique> <silent> <F1>  :MyMarksBrowser<CR>
    nmap <unique> <silent> <F2>  :MyBufExplorer<CR>
    nmap <unique> <silent> <F3>  :NvimTreeToggle %:p:h<CR>
    nmap <unique> <silent> <F4>  :Lspsaga outline<CR>

    nmap <unique> <silent> <F8>  :<c-u>call MyTags()<CR>
    nmap <unique> <silent> <F9>  \m
    nmap <unique> <silent> <F10> :MyColColor<CR>
    nmap <unique> <silent> <F11> :WindowsMaximize<CR>

    imap <unique> <silent> <F9>   <ESC>\m
    imap <unique> <silent> <F11>  <ESC>:WindowsMaximize<CR>
    "-- }}}

    " 单词列表匹配"{{{
    set dictionary=~/.vim/dict/wordlist.txt
    set cpt=.,w,b,u,t,k,i
    " set cpt=.
    "    .	scan the current buffer ('wrapscan' is ignored)
    "    w	scan buffers from other windows
    "    b	scan other loaded buffers that are in the buffer list
    "    u	scan the unloaded buffers that are in the buffer list
    "    U	scan the buffers that are not in the buffer list
    "    k	scan the files given with the 'dictionary' option
    "    kspell  use the currently active spell checking |spell|
    "    k{dict}	scan the file {dict}.  Several "k" flags can be given,
    "       patterns are valid too.  For example: >
    "           :set cpt=k/usr/dict/*,k~/spanish
    "    s	scan the files given with the 'thesaurus' option
    "    s{tsr}	scan the file {tsr}.  Several "s" flags can be given, patterns
    "       are valid too.
    "    i	scan current and included files
    "    d	scan current and included files for defined name or macro
    "       |i_CTRL-X_CTRL-D|
    "    ]	tag completion
    "    t	same as "]"
    "单词列表匹配"}}}

    " 定义快捷键-- {{{
    nmap <silent> cd :lchdir %:p:h<CR>:MyDisplayPath<CR>
    imap <unique> <silent> <C-s> <ESC>:silent update!<CR>
    nmap <unique> <silent> <C-s> :silent update!<CR>

    "-- }}}

    " AutoCmd -- {{{
    function! s:OpenQuickfix(swb)
        let l:isloc = getwininfo(win_getid())[0]['loclist']
        let l:old_swb = &swb
        let l:qf_idx = line('.')
        execute 'set switchbuf=' . a:swb
        "goto :clist/llist index
        if l:isloc == 1
            execute l:qf_idx . 'll'
        else
            execute l:qf_idx . 'cc'
        endif
        execute 'set switchbuf=' . l:old_swb
    endfunction

    function! s:CloseAfterJump()
        lua require('lspsaga').config.outline.close_after_jump = true
        execute 'normal o'
        lua require('lspsaga').config.outline.close_after_jump = false
    endfunction
    augroup vimrc "{{{
        autocmd!
        autocmd VimLeave * wshada!
        autocmd FileType lua,python,go,cuda,c,c++,markdown,json,js,html,vim setlocal signcolumn=yes
        autocmd FileType qf nnoremap <buffer> v <C-w><Enter><C-w>L
        autocmd FileType qf nnoremap <buffer><silent> v :silent! call <SID>OpenQuickfix("vsplit")<CR>
        autocmd FileType qf nnoremap <buffer><silent> x :silent! call <SID>OpenQuickfix("split")<CR>
        autocmd FileType qf nnoremap <buffer><silent> t :silent! call <SID>OpenQuickfix("newtab")<CR>
        autocmd FileType qf nnoremap <buffer><silent> <Enter> :silent! call <SID>OpenQuickfix("useopen")<CR>
        " sagaoutline
        autocmd FileType sagaoutline nnoremap <buffer><silent> O :silent! call <SID>CloseAfterJump()<CR>
    augroup END "}}}

    augroup SaveOnEdit "{{{
        autocmd!
        autocmd FocusLost * silent! wall
        autocmd TabLeave * silent! wall
    augroup END "}}}

    " augroup CmdLine "{{{
    "     autocmd!
    "     autocmd CmdLineEnter * set cmdheight=1
    "     autocmd CmdLineLeave * set cmdheight=0
    " augroup END "}}}
    "}}}
]]

require("plugins").setup(false)

local function after_packer()
    vim.cmd(string.format('let g:ignore_filetypes = "%s"', table.concat(_G.ignore_filetypes, ",")))
    vim.cmd([[
        " autocmd BufRead,BufNewFile,BufEnter,BufWinEnter,BufNew * set signcolumn=yes
        augroup _window_quit_
            autocmd!
            execute "autocmd FileType " . g:ignore_filetypes . " nnoremap <buffer><silent>q :MyWindowClose<CR>"
        augroup END

        "设置高亮"{{{
        set cursorline
        " hi Special          guifg=#8B038D guibg=NONE     gui=NONE
        " hi SpecialKey       guifg=#d8a080 guibg=#e8e8e8  gui=NONE
        " hi CursorLine       gui=underline guibg=none
        hi ColorColumn      guibg=lightgray
        hi SignColumn       gui=bold guifg=NONE guibg=NONE
        hi CursorLineSign   gui=bold guifg=DarkBlue guibg=NONE
        hi Folded           guifg=#006699   guibg=#e0e0e0   gui=NONE
        hi Search           gui=bold guifg=black guibg=yellow
        hi CurSearch        gui=bold guifg=black guibg=yellow
        hi DiffAdd          gui=bold guibg=LightBlue
        hi DiffDelete       gui=bold guibg=Red
        hi DiffChange       gui=bold guibg=LightMagenta

        " SignColumn
        hi DiagnosticSignError  gui=NONE
        hi DiagnosticSignWarn   gui=NONE
        hi DiagnosticSignInfo   gui=NONE
        hi DiagnosticSignHint   gui=NONE
        "}}}

    ]])
    -- suppress "Pattern not found" when a search yields no results  
    -- https://github.com/neovim/neovim/issues/24059
    local function norm_unmapped( c )
        return vim.cmd{ cmd='norm', args={c}, bang=true }
    end
    vim.keymap.set( 'n', 'n', function() pcall( norm_unmapped, 'n' ) end )
    vim.keymap.set( 'n', 'N', function() pcall( norm_unmapped, 'N' ) end )
end
vim.defer_fn(after_packer, 2)

-- vim.inspect(_G.ignore_filetypes)
