function! navigate_block#down()
    let l:current_line = line('.')
    let l:next_line = l:current_line + 1
    let l:current_line_indent = indent(l:current_line)
    let l:next_line_indent = indent(l:next_line)

    if getline(l:current_line) == ''
        " On empty line
        let l:line = l:current_line
        while v:true
            if getline(l:line) != '' || l:line == line('$')
                execute 'normal!' (l:line).'G'
                break
            endif
            let l:line += 1
        endwhile
    elseif getline(l:current_line) != '' && getline(l:next_line) != '' && l:current_line_indent == l:next_line_indent 
        " Within a block
        let l:line = l:next_line + 1
        while v:true
            if getline(l:line) == '' || indent(l:line) != l:current_line_indent
                execute 'normal!' (l:line - 1).'G'
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
                execute 'normal!' (l:line).'G'
                break
            endif

            let l:line += 1
        endwhile
    endif
endfunction

function! navigate_block#up()
    let l:current_line = line('.')
    let l:prev_line = l:current_line - 1
    let l:current_line_indent = indent(l:current_line)
    let l:prev_line_indent = indent(l:prev_line)

    if getline(l:current_line) == ''
        " On empty line
        let l:line = l:current_line
        while v:true
            if getline(l:line) != '' || l:line == 0
                execute 'normal!' (l:line).'G'
                break
            endif
            let l:line -= 1
        endwhile
    elseif getline(l:current_line) != '' && getline(l:prev_line) != '' && l:current_line_indent == l:prev_line_indent 
        " Within a block
        let l:line = l:prev_line - 1
        while v:true
            if getline(l:line) == '' || indent(l:line) != l:current_line_indent
                execute 'normal!' (l:line + 1).'G'
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
                execute 'normal!' (l:line).'G'
                break
            endif

            let l:line -= 1
        endwhile
    endif
endfunction
