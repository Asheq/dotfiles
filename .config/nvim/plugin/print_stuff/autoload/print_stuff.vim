function! print_stuff#print_general()
	echo noscrollbar#statusline(&columns,'■','◫',['◧'],['◨'])

	call s:print_values([
				\ {
				\   'title': 'Basic',
				\   'items': [
				\     {'label': 'Working Directory', 'value': getcwd()},
				\     {'label': 'File', 'value': expand('%:.')},
				\     s:option_info('filetype'),
				\   ]
				\ },
				\ {
				\   'title': 'Encoding and format',
				\   'items': [
				\     s:option_info('fileencoding'),
				\     s:option_info('fileformat'),
				\   ]
				\ },
				\ {
				\   'title': 'Comments',
				\   'items': [
				\     s:option_info('comments'),
				\     s:option_info('commentstring'),
				\   ]
				\ },
				\ {
				\   'title': 'UI',
				\   'items': [
				\     s:option_info('tabline'),
				\     s:option_info('statusline'),
				\     s:option_info('winbar'),
				\   ]
				\ }
				\ ])
endfunction

function! print_stuff#print_formatting()
	call s:print_values([
				\ {
				\   'title': 'Formatting methods for gq/gw operator (ascending priority)',
				\   'items': [
				\     {'label': '[internal formatting]', 'value': '[N/A]'},
				\     s:option_info('formatprg'),
				\     s:option_info('formatexpr'),
				\   ]
				\ },
				\ {
				\   'title': 'For internal formatting',
				\   'items': [
				\     s:option_info('textwidth'),
				\     s:option_info('formatoptions'),
				\     s:option_info('formatlistpat'),
				\   ]
				\ }
				\ ])
endfunction

function! print_stuff#print_indenting()
	call s:print_values([
				\ {
				\   'title': 'Tabs',
				\   'items': [
				\     s:option_info('expandtab'),
				\     s:option_info('tabstop'),
				\     s:option_info('shiftwidth'),
				\     s:option_info('smarttab'),
				\     s:option_info('softtabstop'),
				\     s:option_info('copyindent'),
				\     s:option_info('preserveindent'),
				\   ]
				\ },
				\ {
				\   'title': 'Indenting methods (ascending priority)',
				\   'items': [
				\     s:option_info('autoindent'),
				\     s:option_info('smartindent'),
				\     s:option_info('cindent'),
				\     s:option_info('indentexpr'),
				\   ]
				\ },
				\ {
				\   'title': 'For cindent',
				\   'items': [
				\     s:option_info('cinoptions'),
				\     s:option_info('cinkeys'),
				\     s:option_info('cinwords'),
				\   ]
				\ },
				\ {
				\   'title': 'For indentexpr',
				\   'items': [
				\     s:option_info('indentkeys'),
				\   ]
				\ },
				\ ])
endfunction

function! print_stuff#print_folding()
	call s:print_values([
				\ {
				\   'title': 'Basic',
				\   'items': [
				\     s:option_info('foldenable'),
				\     s:option_info('foldlevelstart'),
				\     s:option_info('foldlevel'),
				\     s:option_info('foldmethod'),
				\     s:option_info('foldexpr'),
				\     s:option_info('foldmarker'),
				\   ]
				\ },
				\ {
				\   'title': 'Other',
				\   'items': [
				\     s:option_info('foldtext'),
				\     s:option_info('foldopen'),
				\     s:option_info('foldclose'),
				\     s:option_info('foldcolumn'),
				\     s:option_info('foldignore'),
				\     s:option_info('foldminlines'),
				\     s:option_info('foldnestmax'),
				\   ]
				\ }
				\ ])
endfunction

function! s:option_info(optname) abort
	return {
				\ 'label': a:optname,
				\ 'value': eval('&' . a:optname),
				\ 'secondary': s:last_set(a:optname)
				\ }
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

function! s:print_values(categories) abort
	let all_items = []
	for category in a:categories
		let all_items = all_items + category.items
	endfor
	let max_item_label_length = max(map(all_items, 'len(v:val.label)'))

	for category in a:categories
		call s:echo_hi(category.title, 'Underlined', 'echo')

		for item in category.items
			echo repeat(' ', max_item_label_length - len(item.label) + 4)
			call s:echo_hi(item.label . ': ', 'String', 'echon')
			if exists('item.value')
				echon item.value
			endif
			if exists('item.secondary')
				call s:echo_hi(item.secondary, 'NonText', 'echon')
			endif
		endfor
	endfor
endfunction

function! s:echo_hi(msg, hi_grp, echo_cmd) abort
	execute "echohl " . a:hi_grp
	execute a:echo_cmd . " '" . a:msg . "'"
	echohl None
endfunction
