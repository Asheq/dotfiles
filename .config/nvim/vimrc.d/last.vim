augroup highlight_yanked_text
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=300, on_visual=true}
augroup END

augroup highlight_line_before_latest_jump
    autocmd!
    autocmd WinEnter * call s:highlight_line_before_latest_jump_start()
    autocmd WinLeave * call s:highlight_line_before_latest_jump_stop()
augroup END

function! s:highlight_line_before_latest_jump_start()
    match BeforeLastJump /.*\%''.*/
endfunction

function! s:highlight_line_before_latest_jump_stop()
    match BeforeLastJump //
endfunction

call s:highlight_line_before_latest_jump_start()

augroup override_colorscheme
    autocmd!
    autocmd ColorScheme * call s:override_colorscheme()
augroup END

function! s:override_colorscheme()
    highlight link ScrollView Search
    highlight BeforeLastJump guifg=white guibg=purple
    highlight Match guifg=white guibg=green
endfunction

set background=light
colorscheme gruvbox

luafile <sfile>:h/last.lua
