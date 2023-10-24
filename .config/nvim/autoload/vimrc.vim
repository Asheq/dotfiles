" TODO-L: Organize and refactor

function! vimrc#get_command_output(command)
    let temp = getreg("v")
    redir @v
    execute 'silent ' . a:command
    let output = getreg("v")
    redir END
    call setreg("v", temp)
    return output
endfunction

function! vimrc#better_ctrl_g()
    let original_ctrl_g_output = vimrc#get_command_output('file')
    return noscrollbar#statusline(&columns,'■','◫',['◧'],['◨']) . substitute(original_ctrl_g_output, '\n', '', '')
endfunction

function! vimrc#maybe_toggle_fold()
    if foldlevel('.')
        normal za
    else
        execute "normal! \<Enter>"
    endif
endfunction

function! vimrc#redraw_screen()
    nohlsearch
    diffupdate
    execute "normal! \<C-l>"
endfunction

function! vimrc#echo_highlight_info()
    echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
                \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
                \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"
endfunction

function! vimrc#get_statusline()
    let window_cwd = vimrc#get_window_cwd(g:statusline_winid)

    if window_cwd != ""
        let window_cwd_string = "[" . vimrc#get_window_cwd(g:statusline_winid) . "]"
    else
        let window_cwd_string = ""
    endif

    return ""
                \ . "%{expand('%:p:~:.')}"
                \ . "  %h%w%m%r[%P]"
                \ . "%="
                \ . window_cwd_string
endfunction

function! MyTabLabelBufName(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let bname = bufname(buflist[winnr - 1])

    let bname_modified = ""
    if bname == ""
        return a:n
    elseif bname[strlen(bname) - 1] == '/'
        let minus_the_slash = bname[0:strlen(bname) - 2]
        let tail = fnamemodify(minus_the_slash, ":t")
        let bname_modified = tail . "/"
    else
        let bname_modified = fnamemodify(bname, ":t")
    endif

    return a:n . " " . bname_modified
endfunction

function! MyTabLabelCWD(n)
    let cwd = vimrc#get_tab_cwd(a:n)
    if cwd == ''
        return ''
    else
        return pathshorten(fnamemodify(cwd, ":~"))
    endif
endfunction

function! vimrc#get_tabline()
    let s = ''
    for i in range(tabpagenr('$'))
        " select the highlighting
        if i + 1 == tabpagenr()
            let s ..= '%#TabLineSel#'
        else
            let s ..= '%#TabLine#'
        endif

        " set the tab page number (for mouse clicks)
        let s ..= '%' .. (i + 1) .. 'T'

        " the label is made by MyTabLabel()
        let s ..= ' %{MyTabLabelBufName(' .. (i + 1) .. ')}%( [%{MyTabLabelCWD(' .. (i + 1) .. ')}]%)▕'
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s ..= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s ..= '%=%#TabLine#%999Xclose'
    endif

    return s
endfunction

function! vimrc#get_fold_text()
    return getline(v:foldstart)
endfunction

function! vimrc#read_aloud(keyword)
    10split +terminal
    let temp = getreg("v")
    let @v = "say " . shellescape(a:keyword) . " -i -r " . g:say_speed
    normal! "vpi
    call setreg("v", temp)
    call feedkeys("\<Enter>exit\<Enter>", 'n')
endfunction

function! vimrc#open_in_shell(item, ...)
    let application = get(a:, 1, 0)

    let prefix = 'silent !open '
    if application isnot 0
        let prefix = prefix . '-a "' . application . '" '
    endif

    execute prefix . shellescape(a:item, 1)
endfunction

function! vimrc#url_encode(str)
    return substitute(iconv(a:str, 'latin1', 'utf-8'),'[^A-Za-z0-9_.~-]','\="%".printf("%02X",char2nr(submatch(0)))','g')
endfunction

function! vimrc#define(keyword)
    call vimrc#open_in_shell('dict://' . vimrc#url_encode(a:keyword))
endfunction

function! vimrc#browse(item)
    if match(a:item, '^https\?://') > -1
        " The item is already a URL
        let url = a:item
    else
        " The item is a keyword, so let's generate a DuckDuckGo URL
        let url = 'https://duckduckgo.com/?q=' . vimrc#url_encode(a:item)
    endif
    let @* = url
    echo 'Copied' url
endfunction

command! -nargs=1 Define call vimrc#define(<f-args>)
command! -nargs=1 Browse call vimrc#browse(<f-args>)

function! vimrc#get_selection_text()
    let temp = getreg("v")
    silent normal! gv"vy
    let raw_text = getreg("v")
    call setreg("v", temp)
    return raw_text
endfunction

function! vimrc#create_toggle_maps(letter, test, off, on)
    execute 'nnoremap <unique> [o' . a:letter . ' :' . a:on . '<Enter>'
    execute 'nnoremap <unique> ]o' . a:letter . ' :' . a:off . '<Enter>'
    execute 'nnoremap <unique> co' . a:letter . ' :' . '<C-r>=' . a:test . '?"' . a:off . '":"' . a:on . '"<Enter><Enter>'
endfunction

function! vimrc#get_global_cwd()
    return getcwd(-1, -1)
endfunction

function! vimrc#get_tab_cwd(tabnr)
    if haslocaldir(-1, a:tabnr)
        return getcwd(-1, a:tabnr)
    endif
    return ''
endfunction

function! vimrc#get_window_cwd(winid)
    if haslocaldir(a:winid)
        return getcwd(a:winid)
    endif
    return ''
endfunction

function! vimrc#mru_dirvish()
    wshada
    rshada!
    enew
    silent 0put=v:oldfiles
    silent keeppatterns %s/\v(.*)/\=fnamemodify(submatch(1),':p')/
    keepjumps 0
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
    setlocal conceallevel=0
    set ft=dirvish
    nunmap <buffer> /
    nunmap <buffer> ?
endfunction
