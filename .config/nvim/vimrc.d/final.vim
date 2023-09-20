" TODO: Verify that you are writing these augroups correctly
" TODO: Move the augroups/autocmds to a file called simple-autocmds.vim

" Auto-close terminal on exit
" TODO: Put in augroup
autocmd TermClose * if !v:event.status | exe 'bdelete! '..expand('<abuf>') | endif

augroup highlight_yanked_text
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=300, on_visual=true}
augroup END

augroup highlight_line_before_latest_jump
    autocmd!
    autocmd WinLeave * call HighlightLineBeforeLatestJumpStop()
    autocmd WinScrolled * call HighlightLineBeforeLatestJumpStart()
augroup END

function! HighlightLineBeforeLatestJumpStart()
    " TODO: Only call match if group "BeforeLastJump" doesn't already exist?
    " TODO: Make it take less priority than Search, IncSearch, TODO etc. (similar to CursorLine,). See highlighter plugin implementation.
    match BeforeLastJump /.*\%''.*/
endfunction

function! HighlightLineBeforeLatestJumpStop()
    " TODO: Use "match none"?
    match BeforeLastJump //
endfunction

call HighlightLineBeforeLatestJumpStart()

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
    endif

    " TODO: Set color based on &background
    highlight! Match guifg=white guibg=green
    highlight! Todo gui=bold,italic guibg=none guifg=none
endfunction

set background=light
colorscheme gruvbox

luafile <sfile>:h/final.lua
