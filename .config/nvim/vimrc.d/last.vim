" TODO: Guard if colorizer module is not installed
lua require'colorizer'.setup()

autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=300, on_visual=true}

source <sfile>:h/last.local.vim

" TODO: Move to permanent location
function MyTabLabelBufName(n)
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

function MyTabLabelCWD(n)
    let cwd = vimrc#get_tab_cwd(a:n)
    if cwd == ''
        return ''
    else
        return pathshorten(fnamemodify(cwd, ":~"))
    endif
endfunction

function MyTabLine()
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
	    let s ..= ' %{MyTabLabelBufName(' .. (i + 1) .. ')} %([%{MyTabLabelCWD(' .. (i + 1) .. ')}] %)|'
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s ..= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s ..= '%=%#TabLine#%999Xclose'
    endif

    return s
endfunction

set tabline=%!MyTabLine()
