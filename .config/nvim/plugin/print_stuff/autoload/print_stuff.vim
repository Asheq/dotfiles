function! print_stuff#print_general()
    call s:print_values([
                \ {
                \   'title': 'Basic',
                \   'items': [
                \     {'label': 'CWD', 'value': getcwd()},
                \     {'label': 'File', 'value': expand('%:.')},
                \     {'label': 'Git branch', 'value': FugitiveHead()},
                \     {'label': 'filetype', 'value': &filetype, 'secondary': s:last_set('filetype')},
                \   ]
                \ },
                \ {
                \   'title': 'Tabs',
                \   'items': [
                \     {'label': 'expandtab', 'value': &expandtab, 'secondary': s:last_set('expandtab')},
                \     {'label': 'tabstop', 'value': &tabstop, 'secondary': s:last_set('tabstop')},
                \     {'label': 'shiftwidth', 'value': &shiftwidth, 'secondary': s:last_set('shiftwidth')},
                \     {'label': 'smarttab', 'value': &smarttab, 'secondary': s:last_set('smarttab')},
                \   ]
                \ },
                \ {
                \   'title': 'Encoding and format',
                \   'items': [
                \     {'label': 'fileencoding', 'value': &fileencoding, 'secondary': s:last_set('fileencoding')},
                \     {'label': 'fileformat (EOL)', 'value': &fileformat, 'secondary': s:last_set('fileformat')},
                \   ]
                \ },
                \ {
                \   'title': 'Comments',
                \   'items': [
                \     {'label': 'comments', 'value': &comments, 'secondary': s:last_set('comments')},
                \     {'label': 'commentstring', 'value': &commentstring, 'secondary': s:last_set('commentstring')},
                \   ]
                \ }
                \ ])
endfunction

function! print_stuff#print_formatting()
    call s:print_values([
                \ {
                \   'title': 'Formatting methods for gq/gw operator',
                \   'items': [
                \     {'label': '[internal formatting]', 'value': '[N/A]'},
                \     {'label': 'formatprg', 'value': &formatprg, 'secondary': s:last_set('formatprg')},
                \     {'label': 'formatexpr', 'value': &formatexpr, 'secondary': s:last_set('formatexpr')},
                \   ]
                \ },
                \ {
                \   'title': 'For internal formatting',
                \   'items': [
                \     {'label': 'textwidth', 'value': &textwidth, 'secondary': s:last_set('textwidth')},
                \     {'label': 'formatoptions', 'value': &formatoptions, 'secondary': s:last_set('formatoptions')},
                \     {'label': 'formatlistpat', 'value': &formatlistpat, 'secondary': s:last_set('formatlistpat')},
                \   ]
                \ }
                \ ])
endfunction

function! print_stuff#print_indenting()
    call s:print_values([
                \ {
                \   'title': 'Indenting methods',
                \   'items': [
                \     {'label': 'autoindent', 'value': &autoindent, 'secondary': s:last_set('autoindent')},
                \     {'label': 'smartindent', 'value': &smartindent, 'secondary': s:last_set('smartindent')},
                \     {'label': 'cindent', 'value': &cindent, 'secondary': s:last_set('cindent')},
                \     {'label': 'indentexpr', 'value': &indentexpr, 'secondary': s:last_set('indentexpr')},
                \   ]
                \ },
                \ {
                \   'title': 'For cindent',
                \   'items': [
                \     {'label': 'cinoptions', 'value': &cinoptions, 'secondary': s:last_set('cinoptions')},
                \     {'label': 'cinkeys', 'value': &cinkeys, 'secondary': s:last_set('cinkeys')},
                \     {'label': 'cinwords', 'value': &cinwords, 'secondary': s:last_set('cinwords')},
                \   ]
                \ },
                \ {
                \   'title': 'For indentexpr',
                \   'items': [
                \     {'label': 'indentkeys', 'value': &indentkeys, 'secondary': s:last_set('indentkeys')},
                \   ]
                \ },
                \ ])
endfunction

function! s:last_set(option)
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

function! s:print_values(categories)
    let all_items = []
    for category in a:categories
        let all_items = all_items + category.items
    endfor
    let max_item_label_length = max(map(all_items, 'len(v:val.label)'))

    for category in a:categories
        call s:echo_hi(category.title, 'htmlH1', 'echo')

        for item in category.items
            echo repeat(' ', max_item_label_length - len(item.label) + 4)
            call s:echo_hi(item.label . ': ', 'Statement', 'echon')
            if exists('item.value')
                echon item.value
            endif
            if exists('item.secondary')
                call s:echo_hi(item.secondary, 'NonText', 'echon')
            endif
        endfor
    endfor
endfunction

function! s:echo_hi(msg, hi_grp, echo_cmd)
    execute "echohl " . a:hi_grp
    execute a:echo_cmd . " '" . a:msg . "'"
    echohl None
endfunction
