function! print_options#print_updated() abort
	let lines = split(execute('silent set!'), "\n")

	let seen = {}
	let options = []
	for line in lines
		let optname = s:extract_optname(line)
		if empty(optname) || has_key(seen, optname)
			continue
		endif
		let seen[optname] = 1
		call add(options, optname)
	endfor

	call sort(options)

	call s:print_option_groups([
				\ {
				\   'title': 'Non-default options',
				\   'options': options,
				\ }
				\ ])
endfunction

function! print_options#print_general() abort
	call s:print_option_groups([
				\ {
				\   'title': 'Filetype',
				\   'options': [
				\     'filetype',
				\   ]
				\ },
				\ {
				\   'title': 'Encoding and format',
				\   'options': [
				\     'fileencoding',
				\     'fileformat',
				\   ]
				\ },
				\ {
				\   'title': 'Comments',
				\   'options': [
				\     'comments',
				\     'commentstring',
				\   ]
				\ },
				\ {
				\   'title': 'UI',
				\   'options': [
				\     'tabline',
				\     'statusline',
				\     'winbar',
				\   ]
				\ }
				\ ])
endfunction

function! print_options#print_formatting() abort
	call s:print_option_groups([
				\ {
				\   'title': 'Formatting methods for gq/gw operator (ascending priority)',
				\   'options': [
				\     'formatprg',
				\     'formatexpr',
				\   ]
				\ },
				\ {
				\   'title': 'For internal formatting',
				\   'options': [
				\     'textwidth',
				\     'formatoptions',
				\     'formatlistpat',
				\   ]
				\ }
				\ ])
endfunction

function! print_options#print_indenting() abort
	call s:print_option_groups([
				\ {
				\   'title': 'Tabs',
				\   'options': [
				\     'expandtab',
				\     'tabstop',
				\     'shiftwidth',
				\     'smarttab',
				\     'softtabstop',
				\     'copyindent',
				\     'preserveindent',
				\   ]
				\ },
				\ {
				\   'title': 'Indenting methods (ascending priority)',
				\   'options': [
				\     'autoindent',
				\     'smartindent',
				\     'cindent',
				\     'indentexpr',
				\   ]
				\ },
				\ {
				\   'title': 'For cindent',
				\   'options': [
				\     'cinoptions',
				\     'cinkeys',
				\     'cinwords',
				\   ]
				\ },
				\ {
				\   'title': 'For indentexpr',
				\   'options': [
				\     'indentkeys',
				\   ]
				\ },
				\ ])
endfunction

function! print_options#print_folding() abort
	call s:print_option_groups([
				\ {
				\   'title': 'Basic',
				\   'options': [
				\     'foldenable',
				\     'foldlevelstart',
				\     'foldlevel',
				\     'foldmethod',
				\     'foldexpr',
				\     'foldmarker',
				\   ]
				\ },
				\ {
				\   'title': 'Other',
				\   'options': [
				\     'foldtext',
				\     'foldopen',
				\     'foldclose',
				\     'foldcolumn',
				\     'foldignore',
				\     'foldminlines',
				\     'foldnestmax',
				\   ]
				\ }
				\ ])
endfunction

function! s:extract_optname(line) abort
	let line = trim(a:line)
	if empty(line)
		return ''
	endif

	if line =~# '='
		return matchstr(line, '^[^=]*')
	endif
	if exists('&' . line)
		return line
	endif
	if line =~# '^no' && exists('&' . line[2:])
		return line[2:]
	endif
	if line =~# '^inv' && exists('&' . line[3:])
		return line[3:]
	endif

	return ''
endfunction

function! s:nondefault_option_set() abort
	let lines = split(execute('silent set!'), "\n")
	let nondefault = {}
	for line in lines
		let optname = s:extract_optname(line)
		if !empty(optname)
			let nondefault[optname] = 1
		endif
	endfor
	return nondefault
endfunction

function! s:last_set(option) abort
	let full_value = execute('silent verbose set ' . a:option . '?')

	let idx = match(full_value, 'Last set from ')
	if (idx != -1)
		let file = substitute(full_value[idx:], 'Last set from ', '', '')
		let file = substitute(file, '\vline \d+$', '', '')
		return trim(file)
	else
		return ''
	endif
endfunction

function! s:print_option_groups(groups) abort
	let nondefault = s:nondefault_option_set()

	let all_opt_names = []
	for group in a:groups
		let all_opt_names = all_opt_names + group.options
	endfor
	let max_opt_name_len = empty(all_opt_names) ? 0 : max(map(copy(all_opt_names), 'len(v:val)'))

	for group in a:groups
		if !empty(group.title)
			call s:echo_hi(group.title, 'Underlined', 'echo')
		endif

		for optname in group.options
			let label = optname
			let value = eval('&' . optname)
			let last_set = s:last_set(optname)
			let label_hi = has_key(nondefault, optname) ? 'DiagnosticError' : 'Normal'

			echo repeat(' ', max_opt_name_len - len(label) + 4)
			call s:echo_hi(label . ': ', label_hi, 'echon')
			echon value
			if !empty(last_set)
				call s:echo_hi(' ➤ ', 'NonText', 'echon')

				let runtime_path = $VIMRUNTIME
				let config_path_abs = stdpath('config')
				let config_path_short = fnamemodify(config_path_abs, ':~')

				if stridx(last_set, runtime_path) == 0
					let tail = substitute(last_set, '\V' . escape(runtime_path, '\\') . '/', '', '')
					call s:echo_hi('$VIMRUNTIME/', 'Function', 'echon')
					call s:echo_hi(tail, 'NonText', 'echon')
				elseif stridx(last_set, config_path_abs) == 0
					let tail = substitute(last_set, '\V' . escape(config_path_abs, '\\') . '/', '', '')
					call s:echo_hi(config_path_short . '/', 'String', 'echon')
					call s:echo_hi(tail, 'NonText', 'echon')
				elseif !empty(config_path_short) && stridx(last_set, config_path_short) == 0
					let tail = substitute(last_set, '\V' . escape(config_path_short, '\\') . '/', '', '')
					call s:echo_hi(config_path_short . '/', 'String', 'echon')
					call s:echo_hi(tail, 'NonText', 'echon')
				else
					call s:echo_hi(last_set, 'NonText', 'echon')
				endif
			endif
		endfor
	endfor
endfunction

function! s:echo_hi(msg, hi_grp, echo_cmd) abort
	execute "echohl " . a:hi_grp
	execute a:echo_cmd . ' ' . string(a:msg)
	echohl None
endfunction
