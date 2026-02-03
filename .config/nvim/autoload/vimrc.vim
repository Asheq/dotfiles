" General utilities
" ============================================================================
function! vimrc#get_command_output(command)
    let temp = getreg("v")
    redir @v
    execute 'silent ' . a:command
    let output = getreg("v")
    redir END
    call setreg("v", temp)
    return output
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

function! vimrc#get_selection_text()
    let temp = getreg("v")
    silent normal! gv"vy
    let raw_text = getreg("v")
    call setreg("v", temp)
    return raw_text
endfunction

" Read aloud
" ============================================================================
function! vimrc#read_aloud(keyword)
    10split +terminal
    let temp = getreg("v")
    let @v = "say " . shellescape(a:keyword) . " -i -r " . g:say_speed
    normal! "vpi
    call setreg("v", temp)
    call feedkeys("\<Enter>exit\<Enter>", 'n')
endfunction

" Define and Browse
" ============================================================================
function! vimrc#define(keyword)
    call vimrc#open_in_shell('dict://' . vimrc#url_encode(a:keyword))
endfunction

function! vimrc#browse(keyword)
    call vimrc#open_in_shell('https://www.google.com/search?q=' . vimrc#url_encode(a:keyword))
endfunction

command! -nargs=1 Define call vimrc#define(<f-args>)
command! -nargs=1 Browse call vimrc#browse(<f-args>)

" Get current working directory
" ============================================================================
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

" Statusline
" ============================================================================
function! vimrc#get_statusline()
	return ""
				\ . "%{vimrc#get_statusline_file_name()}  "
				\ . "%h%w%m%r%=[%P %{noscrollbar#statusline(10,'■','◫',['◧'],['◨'])} %L]"
				\ . "%{vimrc#get_statusline_win_cwd_string()}"
endfunction

function! vimrc#get_statusline_file_name()
	" In this context, win_getid() returns the window of the statusline that
	" is being drawn (a.k.a. the statusline window), not the active window.
	let winid = win_getid()

	let bufnr = winbufnr(winid)
	let bufname = bufname(bufnr)

	if bufname == ""
		return "[No Name]"
	endif

	let bufpath = fnamemodify(bufname, ':p')

	" Get the effective CWD for the statusline window
	let win_cwd_path = fnamemodify(getcwd(winid), ':p')

	"If file is under the CWD of the statusline window, make path relative to it
	if stridx(bufpath, win_cwd_path) == 0
		let relative_bufname = bufpath[len(win_cwd_path):]
		return relative_bufname != "" ? relative_bufname : bufpath
	endif

	" Otherwise, shorten with home directory (~)
	return fnamemodify(bufpath, ':~')
endfunction

function! vimrc#get_statusline_win_cwd_string()
	let winid = win_getid()
	let window_cwd = vimrc#get_window_cwd(winid)

	if window_cwd != ""
		return "[" . pathshorten(fnamemodify(window_cwd, ":~")) . "]"
	else
		return ""
	endif
endfunction

" Tabline
" ============================================================================
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
        let s ..= ' %{vimrc#get_tabline_tab_label(' .. (i + 1) .. ')}%( [%{vimrc#get_tabline_tab_cwd(' .. (i + 1) .. ')}]%)▕'
    endfor

    " after the last tab fill with TabLineFill and reset tab page nr
    let s ..= '%#TabLineFill#%T'

    " right-align the label to close the current tab page
    if tabpagenr('$') > 1
        let s ..= '%=%#TabLine#%999Xclose'
    endif

    return s
endfunction

function! vimrc#get_tabline_tab_label(n)
    return a:n
endfunction

function! vimrc#get_tabline_tab_cwd(n)
    let cwd = vimrc#get_tab_cwd(a:n)
    if cwd == ''
        return ''
    else
        return pathshorten(fnamemodify(cwd, ":~"))
    endif
endfunction
