" Highlight line before latest jump start
" ============================================================================
augroup highlight_line_before_latest_jump_start
    autocmd!
    autocmd WinScrolled * call StartHighlightLineBeforeLatestJump(expand("<amatch>"))
    autocmd WinLeave * call StopHighlightLineBeforeLatestJump()
    autocmd CursorMoved * call StopHighlightLineBeforeLatestJump()
augroup END

let s:match_id = 99
function! StartHighlightLineBeforeLatestJump(winid)
    " If the window that scrolled is not the current window, ignore it
    if a:winid != win_getid()
        return
    endif

    try
        call matchadd("BeforeLastJump", ".*\\%''.*", 0, s:match_id)
    catch
    endtry
endfunction

function! StopHighlightLineBeforeLatestJump()
    try
        call matchdelete(s:match_id)
    catch
    endtry
endfunction

" Auto close terminal on exit
" ============================================================================
augroup auto_close_terminal_on_exit
    autocmd!
    autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif
augroup END

" Highlight yanked text
" ============================================================================
augroup highlight_yanked_text
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=300, on_visual=true}
augroup END

" Override colorscheme
" ============================================================================
augroup override_colorscheme
    autocmd!
    autocmd ColorScheme * call s:override_colorscheme()
augroup END

function! s:override_colorscheme()
    if &background == 'dark'
        " Reference:
        " StatusLine     gui=reverse guifg=#504945 guibg=#ebdbb2
        " StatusLineNC   gui=reverse guifg=#3c3836 guibg=#a89984

        highlight! BeforeLastJump guibg=#45009e
        highlight! CursorLine     guibg=#014575
        highlight! DiffChange     gui=reverse   guifg=#b16286 guibg=#282828
        highlight! DiffText       gui=reverse   guifg=#d3869b guibg=#282828
        highlight! StatusLine     gui=reverse   guifg=#ebdbb2 guibg=#3c3836
        highlight! StatusLineNC   gui=reverse   guifg=#504945 guibg=#ebdbb2
    else
        " Reference:
        " StatusLine     gui=reverse guifg=#d5c4a1 guibg=#3c3836
        " StatusLineNC   gui=reverse guifg=#ebdbb2 guibg=#7c6f64

        highlight! BeforeLastJump guibg=#e1d4f2
        highlight! CursorLine     guibg=#d5e6f2
        highlight! DiffChange     gui=reverse   guifg=#d3869b guibg=#fbf1c7
        highlight! DiffText       gui=reverse   guifg=#8f3871 guibg=#fbf1c7
        highlight! StatusLine     gui=reverse   guifg=#3c3836 guibg=#ebdbb2
        highlight! StatusLineNC   gui=reverse   guifg=#d5c4a1 guibg=#3c3836
    endif

    highlight! link ScrollView Cursor
    highlight! Todo gui=bold,italic guibg=none guifg=none
    highlight! Match guifg=white guibg=green

    " TODO-L:
    " Analyze and fine-tune the priority of the following highlights that change the background:
    "     - Search
    "     - IncSearch
    "     - CursorLine
    "     - MatchParen
    "     - Visual
    "     - Diff*
    "     - Fold
    "     - Match
    "     - BeforeLastJump
    "     - colorizer*
endfunction

" Set colorscheme
" ============================================================================
colorscheme gruvbox

" Run final.lua
" ============================================================================
luafile <sfile>:h/final.lua
