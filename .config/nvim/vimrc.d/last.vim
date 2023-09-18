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
    " TODO: Make sure it takes less priority than Search, IncSearch, TODO etc. (similar to CursorLine)
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
    highlight! link ScrollView Search

    if &background == 'dark'
        highlight! BeforeLastJump guibg=#45009e
        highlight! CursorLine guibg=#014575
    else
        highlight! BeforeLastJump guibg=#e1d4f2
        highlight! CursorLine guibg=#d5e6f2
    endif

    " TODO Set color based on &background
    highlight! Match guifg=white guibg=green
endfunction

set background=light
colorscheme gruvbox

luafile <sfile>:h/last.lua
