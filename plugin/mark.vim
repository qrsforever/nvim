function! s:RGB(r, g, b)
	return a:r * 36 + a:g * 6 + a:b + 16
endfunction

"	    0	    0	    Black
"	    1	    4	    DarkBlue
"	    2	    2	    DarkGreen
"	    3	    6	    DarkCyan
"	    4	    1	    DarkRed
"	    5	    5	    DarkMagenta
"	    6	    3	    Brown, DarkYellow
"	    7	    7	    LightGray, LightGrey, Gray, Grey
"	    8	    0*    DarkGray, DarkGrey
"	    9	    4*    Blue, LightBlue
"	    10	  2*	  Green, LightGreen
"	    11	  6*	  Cyan, LightCyan
"	    12	  1*	  Red, LightRed
"	    13	  5*	  Magenta, LightMagenta
"	    14	  3*	  Yellow, LightYellow
"	    15	  7*	  White

" default colors/groups
" you may define your own colors in you vimrc file, in the form as below:
function! s:SetColor()
    if &t_Co < 256
        hi MarkWord1 guifg=White ctermfg=White guibg=#FF0000 ctermbg=Red
        hi MarkWord2 guifg=Black ctermfg=Black guibg=#FFD700 ctermbg=Yellow
        hi MarkWord3 guifg=Black ctermfg=Black guibg=#5FD700 ctermbg=Green
        hi MarkWord4 guifg=Black ctermfg=Black guibg=#00D7FF ctermbg=Cyan
        hi MarkWord5 guifg=White ctermfg=White guibg=#0087FF ctermbg=Blue
        hi MarkWord6 guifg=White ctermfg=White guibg=#AF00FF ctermbg=Magenta
        hi MarkWord7 guifg=Black ctermfg=Black guibg=#E12672 ctermbg=Grey
        hi MarkWord8 guifg=Black ctermfg=Black guibg=#BCDDBD ctermbg=Brown
        hi MarkWord9 guifg=White ctermfg=White guibg=#D9D9D9 ctermbg=DarkBlue
    else
        exec "hi! MarkWord1 guifg=White ctermfg=White guibg=#FF0000 ctermbg=".s:RGB(5,0,0)
        exec "hi! MarkWord2 guifg=Black ctermfg=Black guibg=#FFD700 ctermbg=".s:RGB(5,4,0)
        exec "hi! MarkWord3 guifg=Black ctermfg=Black guibg=#5FD7A2 ctermbg=".s:RGB(1,4,6)
        exec "hi! MarkWord4 guifg=Black ctermfg=Black guibg=#00D7FF ctermbg=".s:RGB(0,4,5)
        exec "hi! MarkWord5 guifg=White ctermfg=White guibg=#0087FF ctermbg=".s:RGB(0,2,5)
        exec "hi! MarkWord6 guifg=White ctermfg=White guibg=#AF00FF ctermbg=".s:RGB(3,0,5)
        exec "hi! MarkWord7 guifg=Black ctermfg=Black guibg=#E12672 ctermbg=".s:RGB(2,5,2)
        exec "hi! MarkWord8 guifg=Black ctermfg=White guibg=#B21DBD ctermbg=".s:RGB(3,3,3)
        exec "hi! MarkWord9 guifg=White ctermfg=White guibg=#192939 ctermbg=".s:RGB(1,2,7)
    endif
endfunction

" Anti reinclusion guards
if exists('g:loaded_mark_vim') && !exists('g:force_reload_mark')
	finish
endif

let g:loaded_mark_vim = 1
call s:SetColor()

" Support for |line-continuation|
let s:save_cpo = &cpo
set cpo&vim

" Default bindings

if !hasmapto('<Plug>MarkSet', 'n')
	nmap <unique> <silent> \m <Plug>MarkSet
endif
if !hasmapto('<Plug>MarkSet', 'v')
	vmap <unique> <silent> \m <Plug>MarkSet
endif
if !hasmapto('<Plug>MarkRegex', 'n')
	nmap <unique> <silent> \M <Plug>MarkRegex
endif
if !hasmapto('<Plug>MarkRegex', 'v')
	vmap <unique> <silent> \M <Plug>MarkRegex
endif
if !hasmapto('<Plug>MarkClear', 'n')
	nmap <unique> <silent> \x <Plug>MarkClear
endif

nnoremap <silent> <Plug>MarkSet   :call
	\ <sid>MarkCurrentWord()<cr>
vnoremap <silent> <Plug>MarkSet   <c-\><c-n>:call
	\ <sid>DoMark(<sid>GetVisualSelectionEscaped("enV"))<cr>
nnoremap <silent> <Plug>MarkRegex :call
	\ <sid>MarkRegex()<cr>
vnoremap <silent> <Plug>MarkRegex <c-\><c-n>:call
	\ <sid>MarkRegex(<sid>GetVisualSelectionEscaped("N"))<cr>
" nnoremap <silent> <Plug>MarkClear :call
" 	\ <sid>DoMark(<sid>CurrentMark())<cr>
nnoremap <silent> <Plug>MarkClear :call
	\ <sid>DoMark('')<cr>

" SEARCHING
"
" Here is a sumerization of the following keys' behaviors:
" 
" First of all, \#, \? and # behave just like \*, \/ and *, respectively,
" except that \#, \? and # search backward.
"
" \*, \/ and *'s behaviors differ base on whether the cursor is currently
" placed over an active mark:
"
"       Cursor over mark                  Cursor not over mark
" ---------------------------------------------------------------------------
"  \*   jump to the next occurrence of    jump to the next occurrence of
"       current mark, and remember it     "last mark".
"       as "last mark".
"
"  \/   jump to the next occurrence of    same as left
"       ANY mark.
"
"   *   if \* is the most recently used,  do VIM's original *
"       do a \*; otherwise (\/ is the
"       most recently used), do a \/.

nnoremap <unique> <silent> \n  :call <sid>SearchCurrentMark()<cr>
nnoremap <unique> <silent> \p  :call <sid>SearchCurrentMark("b")<cr>
nnoremap <unique> <silent> \N  :call <sid>SearchAnyMark()<cr>
nnoremap <unique> <silent> \P  :call <sid>SearchAnyMark("b")<cr>
nnoremap <unique> <silent> \]  :call <sid>SearchCurrentMark()<cr>
nnoremap <unique> <silent> \[  :call <sid>SearchCurrentMark("b")<cr>
nnoremap <unique> <silent> \}  :call <sid>SearchAnyMark()<cr>
nnoremap <unique> <silent> \{  :call <sid>SearchAnyMark("b")<cr>
nnoremap          <silent> *   :if !<sid>SearchNext()<bar>execute "norm! *"<bar>endif<cr>
nnoremap          <silent> #   :if !<sid>SearchNext("b")<bar>execute "norm! #"<bar>endif<cr>

command! -nargs=? Mark call s:DoMark(<f-args>)

" autocmd! BufWinEnter,WinEnter * silent call s:UpdateMark()
autocmd! WinEnter * silent call s:UpdateMark()

" Functions

function! s:MarkCurrentWord()
	let w = s:PrevWord()
	if w != ""
		call s:DoMark('\<' . w . '\>')
	endif
endfunction

function! s:GetVisualSelection()
	let save_unamed = getreg('"')
	silent normal! gv""y
	let res = getreg('"')
	call setreg('"', save_unamed)
	return res
endfunction

function! s:GetVisualSelectionEscaped(flags)
	" flags:
	"  "e" \  -> \\  
	"  "n" \n -> \\n  for multi-lines visual selection
	"  "N" \n removed
	"  "V" \V added   for marking plain ^, $, etc.
	let result = s:GetVisualSelection()
	let i = 0
	while i < strlen(a:flags)
		if a:flags[i] ==# "e"
			let result = escape(result, '\')
		elseif a:flags[i] ==# "n"
			let result = substitute(result, '\n', '\\n', 'g')
		elseif a:flags[i] ==# "N"
			let result = substitute(result, '\n', '', 'g')
		elseif a:flags[i] ==# "V"
			let result = '\V' . result
		endif
		let i = i + 1
	endwhile
	return result
endfunction

" manually input a regular expression
function! s:MarkRegex(...) " MarkRegex(regexp)
	let regexp = ""
	if a:0 > 0
		let regexp = a:1
	endif
  let r = MyFun_input("@", regexp, '')
	if r != ""
		call s:DoMark(r)
	endif
endfunction

" define variables if they don't exist
function! s:InitMarkVariables()
	if !exists("g:mw_state")
		let g:mw_state = 0
	endif
	if !exists("g:MW_HIST_ADD")
		let g:MW_HIST_ADD = "/@"
	endif
	if !exists("g:MW_CYCLE_MAX")
		let i = 1
		while hlexists("MarkWord" . i)
			let i = i + 1
		endwhile
		let g:MW_CYCLE_MAX = i - 1
	endif
	if !exists("g:MW_CYCLE")
		let g:MW_CYCLE = 1
	endif
	let i = 1
	while i <= g:MW_CYCLE_MAX
		if !exists("g:MW_WORD" . i)
			let g:MW_WORD{i} = ""
		endif
		let i = i + 1
	endwhile
	if !exists("g:MW_LAST_SEARCHED")
		let g:MW_LAST_SEARCHED = ""
	endif
endfunction

" return the word under or before the cursor
function! s:PrevWord()
	let line = getline(".")
	if line[col(".") - 1] =~ '\w'
		return expand("<cword>")
	else
		return substitute(strpart(line, 0, col(".") - 1), '^.\{-}\(\w\+\)\W*$', '\1', '')
	endif
endfunction

" mark or unmark a regular expression
function! s:DoMark(...) " DoMark(regexp)
    " TODO lidong for neovim colorschema hi clear
    if !exists('g:mark_vim_setcolor')
        call s:SetColor()
        let g:mark_vim_setcolor = 1
    endif
	" define variables if they don't exist
	call s:InitMarkVariables()

	" clear all marks if g:mw_state is 0 (i.e. muted) and regexp is not null
	let regexp = ""
	if a:0 > 0
		let regexp = a:1
	endif
	if regexp == ""
    " lidong clear search item workaround
    if g:mw_state > 0
      let g:mw_state = 0
      call s:UpdateMark()
    endif
    execute 'let @/ = "reverofsrq"'
		return 0
	elseif g:mw_state <= 0 && regexp != ""
		let g:mw_state = 1
		let i = 1
		while i <= g:MW_CYCLE_MAX
			if g:MW_WORD{i} != ""
				let g:MW_WORD{i} = ""
				let lastwinnr = winnr()
				if exists("*winsaveview")
					let winview = winsaveview()
				endif
				if exists("*matchdelete")
					windo silent! call matchdelete(3333 + i)
				else
					exe "windo syntax clear MarkWord" . i
				endif
				exe lastwinnr . "wincmd w"
				if exists("*winrestview")
					call winrestview(winview)
				endif
			endif
			let i = i + 1
		endwhile
	endif

	" clear the mark if it has been marked
	let i = 1
	while i <= g:MW_CYCLE_MAX
		if regexp == g:MW_WORD{i}
			if g:MW_LAST_SEARCHED == g:MW_WORD{i}
				let g:MW_LAST_SEARCHED = ""
			endif
			let g:MW_WORD{i} = ""
			let lastwinnr = winnr()
			if exists("*winsaveview")
				let winview = winsaveview()
			endif
			if exists("*matchdelete")
				windo silent! call matchdelete(3333 + i)
			else
				exe "windo syntax clear MarkWord" . i
			endif
			exe lastwinnr . "wincmd w"
			if exists("*winrestview")
				call winrestview(winview)
			endif
			return 0
		endif
		let i = i + 1
	endwhile

	" add to history
	if stridx(g:MW_HIST_ADD, "/") >= 0
		call histadd("/", regexp)
	endif
	if stridx(g:MW_HIST_ADD, "@") >= 0
		call histadd("@", regexp)
	endif

	" quote regexp with / etc. e.g. pattern => /pattern/
	let quote = "/?~!@#$%^&*+-=,.:"
	let i = 0
	while i < strlen(quote)
		if stridx(regexp, quote[i]) < 0
			let quoted_regexp = quote[i] . regexp . quote[i]
			break
		endif
		let i = i + 1
	endwhile
	if i >= strlen(quote)
		return -1
	endif

	" choose an unused mark group
	let i = 1
	while i <= g:MW_CYCLE_MAX
		if g:MW_WORD{i} == ""
			let g:MW_WORD{i} = regexp
			if i < g:MW_CYCLE_MAX
				let g:MW_CYCLE = i + 1
			else
				let g:MW_CYCLE = 1
			endif
			let lastwinnr = winnr()
			if exists("*winsaveview")
				let winview = winsaveview()
			endif
			if exists("*matchadd")
				windo silent! call matchdelete(3333 + i)
				windo silent! call matchadd("MarkWord" . i, g:MW_WORD{i}, -10, 3333 + i)
			else
				exe "windo syntax clear MarkWord" . i
				" suggested by Marc Weber, use .* instead off ALL
				exe "windo syntax match MarkWord" . i . " " . quoted_regexp . " containedin=.*"
			endif
			exe lastwinnr . "wincmd w"
			if exists("*winrestview")
				call winrestview(winview)
			endif
			return i
		endif
		let i = i + 1
	endwhile

	" choose a mark group by cycle
	let i = 1
	while i <= g:MW_CYCLE_MAX
		if g:MW_CYCLE == i
			if g:MW_LAST_SEARCHED == g:MW_WORD{i}
				let g:MW_LAST_SEARCHED = ""
			endif
			let g:MW_WORD{i} = regexp
			if i < g:MW_CYCLE_MAX
				let g:MW_CYCLE = i + 1
			else
				let g:MW_CYCLE = 1
			endif
			let lastwinnr = winnr()
			if exists("*winsaveview")
				let winview = winsaveview()
			endif
			if exists("*matchadd")
				windo silent! call matchdelete(3333 + i)
				windo silent! call matchadd("MarkWord" . i, g:MW_WORD{i}, -10, 3333 + i)
			else
				exe "windo syntax clear MarkWord" . i
				" suggested by Marc Weber, use .* instead off ALL
				exe "windo syntax match MarkWord" . i . " " . quoted_regexp . " containedin=.*"
			endif
			exe lastwinnr . "wincmd w"
			if exists("*winrestview")
				call winrestview(winview)
			endif
			return i
		endif
		let i = i + 1
	endwhile
endfunction

" update mark colors
function! s:UpdateMark()
	" define variables if they don't exist
	call s:InitMarkVariables()

	let i = 1
	while i <= g:MW_CYCLE_MAX
		exe "syntax clear MarkWord" . i
		if g:mw_state >= 1 && g:MW_WORD{i} != ""
			" quote regexp with / etc. e.g. pattern => /pattern/
			let quote = "/?~!@#$%^&*+-=,.:"
			let j = 0
			while j < strlen(quote)
				if stridx(g:MW_WORD{i}, quote[j]) < 0
					let quoted_regexp = quote[j] . g:MW_WORD{i} . quote[j]
					break
				endif
				let j = j + 1
			endwhile
			if j >= strlen(quote)
				continue
			endif

			let lastwinnr = winnr()
			if exists("*winsaveview")
				let winview = winsaveview()
			endif
			if exists("*matchadd")
				windo silent! call matchdelete(3333 + i)
				windo silent! call matchadd("MarkWord" . i, g:MW_WORD{i}, -10, 3333 + i)
			else
				exe "windo syntax clear MarkWord" . i
				" suggested by Marc Weber, use .* instead off ALL
				exe "windo syntax match MarkWord" . i . " " . quoted_regexp . " containedin=.*"
			endif
			exe lastwinnr . "wincmd w"
			if exists("*winrestview")
				call winrestview(winview)
			endif
		elseif g:MW_WORD{i} != ""
			let lastwinnr = winnr()
			if exists("*winsaveview")
				let winview = winsaveview()
			endif
			if exists("*matchdelete")
				windo silent! call matchdelete(3333 + i)
			else
				exe "windo syntax clear MarkWord" . i
			endif
			exe lastwinnr . "wincmd w"
			if exists("*winrestview")
				call winrestview(winview)
			endif
		endif
		let i = i + 1
	endwhile
endfunction

" return the mark string under the cursor
function! s:CurrentMark()
	" define variables if they don't exist
	call s:InitMarkVariables()

	let saved_line = line(".")
	let saved_col  = col(".")
	let search_begin = saved_line>100?saved_line-100:1
	let search_end   = saved_line+100<line("$")?saved_line+100:line("$")

	let result = 0
	let i = 1
	while i <= g:MW_CYCLE_MAX
		if g:mw_state >= 1 && g:MW_WORD{i} != ""
			call cursor(search_begin, 1)
			let end_line = 0
			let end_col  = 0
			while !(end_line > saved_line || end_line == saved_line && end_col >= saved_col)
				let fwd = search(g:MW_WORD{i}, "eW", search_end)
				if fwd == 0 || end_line == line(".") && end_col == col(".")
					break
				endif
				let end_line = line(".")
				let end_col  = col(".")
			endwhile
			if !(end_line > saved_line || end_line == saved_line && end_col >= saved_col)
				let i = i + 1
				continue
			endif
			call cursor(end_line, end_col)
			let bwd = search(g:MW_WORD{i}, "cbW", search_begin)
			if bwd == 0
				let i = i + 1
				continue
			endif
			let begin_line = line(".")
			let begin_col  = col(".")
			if begin_line < saved_line || begin_line == saved_line && begin_col <= saved_col
				let s:current_mark_position = begin_line . "_" . begin_col
				let result = i
				break
			endif
		endif
		let i = i + 1
	endwhile

	call cursor(saved_line, saved_col)
	if result > 0
		return g:MW_WORD{result}
	endif
	return ""
endfunction

" search current mark
function! s:SearchCurrentMark(...) " SearchCurrentMark(flags)
	let flags = ""
	if a:0 > 0
		let flags = a:1
	endif
	let w = s:CurrentMark()
	if w != ""
		let p = s:current_mark_position
		call search(w, flags)
		call s:CurrentMark()
		if exists("s:current_mark_position") && p == s:current_mark_position
			call search(w, flags)
		endif
		let g:MW_LAST_SEARCHED = w
	else
		if g:MW_LAST_SEARCHED != ""
			call search(g:MW_LAST_SEARCHED, flags)
		else
			call s:SearchAnyMark(flags)
			let g:MW_LAST_SEARCHED = s:CurrentMark()
		endif
	endif
endfunction

" combine all marks into one regexp
function! s:AnyMark()
	" define variables if they don't exist
	call s:InitMarkVariables()

	let w = ""
	let i = 1
	while i <= g:MW_CYCLE_MAX
		if g:mw_state >= 1 && g:MW_WORD{i} != ""
			if w != ""
				let w = w . '\|' . g:MW_WORD{i}
			else
				let w = g:MW_WORD{i}
			endif
		endif
		let i = i + 1
	endwhile
	return w
endfunction

" search any mark
function! s:SearchAnyMark(...) " SearchAnyMark(flags)
	let flags = ""
	if a:0 > 0
		let flags = a:1
	endif
	let w = s:CurrentMark()
	if w != ""
		let p = s:current_mark_position
	else
		let p = ""
	endif
	let w = s:AnyMark()
	call search(w, flags)
	call s:CurrentMark()
	if exists("s:current_mark_position") && p == s:current_mark_position
		call search(w, flags)
	endif
	let g:MW_LAST_SEARCHED = ""
endfunction

" search last searched mark
function! s:SearchNext(...) " SearchNext(flags)
	let flags = ""
	if a:0 > 0
		let flags = a:1
	endif
	let w = s:CurrentMark()
	if w != ""
		if g:MW_LAST_SEARCHED != ""
			call s:SearchCurrentMark(flags)
		else
			call s:SearchAnyMark(flags)
		endif
		return 1
	else
		return 0
	endif
endfunction

" Restore previous 'cpo' value
let &cpo = s:save_cpo

" vim: ts=2 sw=2
