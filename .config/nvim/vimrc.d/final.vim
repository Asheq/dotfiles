" Highlight line before latest jump start
" ============================================================================
augroup highlight_line_before_latest_jump_start
    autocmd!
    autocmd WinScrolled * call HighlightLineBeforeLatestJumpStart()
    autocmd WinLeave * call HighlightLineBeforeLatestJumpStop()
augroup END

let s:match_id = 99
function! HighlightLineBeforeLatestJumpStart()
    if !s:contains_property(getmatches(), 'id', s:match_id)
        call matchadd("BeforeLastJump", ".*\\%''.*", 0, s:match_id)
    endif
endfunction

function! HighlightLineBeforeLatestJumpStop()
    if s:contains_property(getmatches(), 'id', s:match_id)
        call matchdelete(s:match_id)
    endif
endfunction

function! s:contains_property(list, key, value)
    for dict in a:list
        if has_key(dict, a:key) && dict[a:key] == a:value
            return 1
        endif
    endfor
    return 0
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
    highlight! link ScrollView Cursor

    if &background == 'dark'
        highlight! BeforeLastJump guibg=#45009e
        highlight! CursorLine guibg=#014575
        highlight! DiffChange gui=reverse guifg=#b16286 guibg=#282828
        highlight! DiffText gui=reverse guifg=#d3869b guibg=#282828
    else
        highlight! BeforeLastJump guibg=#e1d4f2
        highlight! CursorLine guibg=#d5e6f2
        highlight! DiffChange gui=reverse guifg=#d3869b guibg=#fbf1c7
        highlight! DiffText gui=reverse guifg=#8f3871 guibg=#fbf1c7

        " highlight! StatusLine gui=reverse   guifg=#d5c4a1 guibg=#3c3836
        " highlight! StatusLineNC gui=reverse guifg=#ebdbb2 guibg=#7c6f64
        highlight! StatusLine gui=reverse     guifg=#3c3836 guibg=#ebdbb2
        highlight! StatusLineNC gui=reverse   guifg=#d5c4a1 guibg=#3c3836
    endif

    highlight! Match guifg=white guibg=green
    highlight! Todo gui=bold,italic guibg=none guifg=none
endfunction

" Set colorscheme
" ============================================================================
set background=light
colorscheme gruvbox

" Run final.lua
" ============================================================================
luafile <sfile>:h/final.lua
