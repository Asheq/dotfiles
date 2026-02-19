function! GetDemoIndent()
	let lnum = v:lnum
	if lnum == 1
		return 0
	endif
	let prevline = getline(lnum - 1)
	let match = matchstr(prevline, '\d\+')
	if match != ''
		return min([str2nr(match), 80])
	else
		return 16
	endif
endfunction

setlocal indentexpr=GetDemoIndent()
