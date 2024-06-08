" Set listchars
" ============================================================================
augroup set_listchars
    autocmd!
    autocmd OptionSet tabstop call s:set_listchars()
    autocmd BufWinEnter * call s:set_listchars()
augroup END

function! s:set_listchars()
    execute 'set listchars-=' . escape(matchstr(&listchars, 'leadmultispace.\{-}\ze\($\|,\)'), ' ')
    execute 'set listchars+=leadmultispace:┊' . repeat('\ ', &tabstop - 1)
endfunction

" Highlight yanked text
" ============================================================================
augroup highlight_yanked_text
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=300, on_visual=true}
augroup END

" Highlights
" ============================================================================
highlight! link CocMenuSel   PmenuSel
highlight! link CocListLine  PmenuSel
highlight! link StatusLineNC Visual

" Run final.lua
" ============================================================================
luafile <sfile>:h/final.lua
