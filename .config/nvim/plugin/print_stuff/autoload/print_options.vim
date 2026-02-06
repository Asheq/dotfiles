function! print_options#all_nondefault_options()
	let set_output = execute('silent set!')
	let lines = split(set_output, "\n")

	let seen = {}
	let options = []
	for line in lines
		let line = trim(line)
		if empty(line)
			continue
		endif

		let optname = ''
		if line =~# '='
			let optname = matchstr(line, '^[^=]*')
		elseif exists('&' . line)
			let optname = line
		elseif line =~# '^no' && exists('&' . line[2:])
			let optname = line[2:]
		elseif line =~# '^inv' && exists('&' . line[3:])
			let optname = line[3:]
		endif

		if empty(optname) || has_key(seen, optname)
			continue
		endif
		let seen[optname] = 1
		call add(options, optname)
	endfor

	call sort(options)

	call s:print_options_groups([
				\ {
				\   'title': 'Non-default options',
				\   'options': options,
				\ }
				\ ])
endfunction

function! print_options#general()
	call s:print_options_groups([
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

function! print_options#formatting()
	call s:print_options_groups([
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

function! print_options#indenting()
	call s:print_options_groups([
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

function! print_options#folding()
	call s:print_options_groups([
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

function! s:last_set(option) abort
	let temp = getreg("l")
	redir @l
	execute 'silent verbose set ' . a:option . '?'
	redir END
	let full_value = getreg("l")
	call setreg("l", temp)

	let idx = match(full_value, 'Last set from ')
	if (idx != -1)
		let file = substitute(full_value[idx:], 'Last set from ', '', '')
		let file = substitute(file, '\vline \d+$', '', '')
		return ' => ' . substitute(file, $VIMRUNTIME, '$VIMRUNTIME', 'g')
	else
		return ''
	endif
endfunction

function! s:print_options_groups(categories) abort
	let all_opt_names = []
	for category in a:categories
		let all_opt_names = all_opt_names + category.options
	endfor
	let max_opt_name_len = empty(all_opt_names) ? 0 : max(map(copy(all_opt_names), 'len(v:val)'))

	for category in a:categories
		if !empty(category.title)
			call s:echo_hi(category.title, 'Underlined', 'echo')
		endif

		for optname in category.options
			let label = optname
			let value = eval('&' . optname)
			let lastSet = s:last_set(optname)

			echo repeat(' ', max_opt_name_len - len(label) + 4)
			call s:echo_hi(label . ': ', 'String', 'echon')
			echon value
			if !empty(lastSet)
				call s:echo_hi(lastSet, 'NonText', 'echon')
			endif
		endfor
	endfor
endfunction

function! s:echo_hi(msg, hi_grp, echo_cmd) abort
	execute "echohl " . a:hi_grp
	execute a:echo_cmd . " '" . a:msg . "'"
	echohl None
endfunction
