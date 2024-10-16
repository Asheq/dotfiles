function! navigate_block#down(vim_mode)
    let l:current_line = line('.')
    let l:next_line = l:current_line + 1
    let l:current_line_indent = indent(l:current_line)
    let l:next_line_indent = indent(l:next_line)

    let l:target_line = v:false

    if getline(l:current_line) == ''
        " On empty line
        let l:line = l:current_line
        while v:true
            if getline(l:line) != '' || l:line == line('$')
                let l:target_line = l:line
                break
            endif
            let l:line += 1
        endwhile
    elseif getline(l:current_line) != '' && getline(l:next_line) != '' && l:current_line_indent == l:next_line_indent 
        " Within a block
        let l:line = l:next_line + 1
        while v:true
            if getline(l:line) == '' || indent(l:line) != l:current_line_indent
                let l:target_line = l:line - 1
                break
            endif
            let l:line += 1
        endwhile
    else
        " At end of a block
        let l:line = l:next_line
        while v:true
            if indent(l:line) < l:current_line_indent && getline(l:line) != ''
                break
            endif

            if (indent(l:line) == l:current_line_indent && getline(l:line) != '') || l:line >= line('$')
                let l:target_line = l:line
                break
            endif

            let l:line += 1
        endwhile
    endif

    if l:target_line != v:false
        execute 'normal! ' . (l:target_line) . 'G'
    endif
endfunction

function! navigate_block#up(vim_mode) range
    let l:current_line = line('.')
    let l:prev_line = l:current_line - 1
    let l:current_line_indent = indent(l:current_line)
    let l:prev_line_indent = indent(l:prev_line)

    let l:target_line = v:false

    if getline(l:current_line) == ''
        " On empty line
        let l:line = l:current_line
        while v:true
            if getline(l:line) != '' || l:line == 0
                let l:target_line = l:line
                break
            endif
            let l:line -= 1
        endwhile
    elseif getline(l:current_line) != '' && getline(l:prev_line) != '' && l:current_line_indent == l:prev_line_indent 
        " Within a block
        let l:line = l:prev_line - 1
        while v:true
            if getline(l:line) == '' || indent(l:line) != l:current_line_indent
                let l:target_line = l:line + 1
                break
            endif
            let l:line -= 1
        endwhile
    else
        " At end of a block
        let l:line = l:prev_line
        while v:true
            if indent(l:line) < l:current_line_indent && getline(l:line) != ''
                break
            endif

            if (indent(l:line) == l:current_line_indent && getline(l:line) != '') || l:line <= 0
                let l:target_line = l:line 
                break
            endif

            let l:line -= 1
        endwhile
    endif

    if l:target_line != v:false
        execute 'normal! ' . (l:target_line) . 'G'
    endif
endfunction
