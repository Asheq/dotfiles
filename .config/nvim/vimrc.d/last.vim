autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=300, on_visual=true}

set background=light
colorscheme gruvbox

luafile <sfile>:h/last.lua

augroup highlight_position_before_latest_jump
    autocmd!
    autocmd WinEnter * call s:highlight_position_before_latest_jump_start()
    autocmd WinLeave * call s:highlight_position_before_latest_jump_stop()
augroup END

function! s:highlight_position_before_latest_jump_start()
    match BeforeLastJump /.*\%''.*/
endfunction

function! s:highlight_position_before_latest_jump_stop()
    match BeforeLastJump //
endfunction

call s:highlight_position_before_latest_jump_start()
