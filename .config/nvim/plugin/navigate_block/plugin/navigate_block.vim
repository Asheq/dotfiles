function! <SID>navigate_block_down(vim_mode) range
    if a:vim_mode == "v"
        normal! gv
    endif

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

function! <SID>navigate_block_up(vim_mode) range
    if a:vim_mode == "v"
        normal! gv
    endif

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

nnoremap <silent> <Plug>(NavigateBlockDown)    :<C-U>call <SID>navigate_block_down("n")<CR>
vnoremap <silent> <Plug>(NavigateBlockDown)         :call <SID>navigate_block_down("v")<CR>
onoremap <silent> <Plug>(NavigateBlockDown)   V:<C-U>call <SID>navigate_block_down("o")<CR>

nnoremap <silent> <Plug>(NavigateBlockUp)     :<C-U>call <SID>navigate_block_up("n")<CR>
vnoremap <silent> <Plug>(NavigateBlockUp)          :call <SID>navigate_block_up("v")<CR>
onoremap <silent> <Plug>(NavigateBlockUp)    V:<C-U>call <SID>navigate_block_up("o")<CR>
