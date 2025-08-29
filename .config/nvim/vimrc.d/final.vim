" Set listchars
" ============================================================================
augroup set_listchars
    autocmd!
    autocmd OptionSet tabstop call s:set_listchars()
    autocmd BufWinEnter * call s:set_listchars()
augroup END

function! s:set_listchars()
    execute 'setlocal listchars-=' . escape(matchstr(&listchars, 'leadmultispace.\{-}\ze\($\|,\)'), ' ')
    execute 'setlocal listchars+=leadmultispace:┊' . repeat('\ ', &tabstop - 1)
endfunction

" Highlight yanked text
" ============================================================================
augroup highlight_yanked_text
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=300, on_visual=true}
augroup END

" Highlight Overrides
" ============================================================================
highlight! link CocMenuSel   PmenuSel
highlight! link CocListLine  PmenuSel

highlight! link MatchParen   CocBold

highlight! link WinBar       StatusLine
highlight! link WinBarNC     StatusLineNC

highlight! link TabLine      StatusLineNC
highlight! link TabLineSel   StatusLine

function! s:on_bg_change()
    if &background ==# 'light'
        highlight! StatusLineNC      guifg=NvimDarkGrey3 guibg=NvimLightGrey4
        highlight! Visual            guibg=#bda9b0
        highlight! Substitute        guifg=#ffffff guibg=#b16286
        " highlight! CursorLine        guibg=#c6d3cf

        " For transparency
         highlight! Normal            guifg=NvimDarkGrey2 guibg=NONE
    elseif &background ==# 'dark'
        highlight! StatusLineNC      guifg=NvimLightGrey3 guibg=NvimDarkGrey4
        highlight! Visual            guibg=#45353b
        highlight! Substitute        guifg=#ffffff guibg=#b16286
        " highlight! CursorLine        guibg=#32413c

        " For transparency
         highlight! Normal            guifg=NvimLightGrey2 guibg=NONE
    endif
endfunction

autocmd OptionSet background call s:on_bg_change()
call s:on_bg_change()

" Open Neovide in home directory
" ============================================================================
if exists('g:neovide')
    cd ~
endif

" Run final.lua
" ============================================================================
luafile <sfile>:h/final.lua

" Run final.local.vim if it exists
" ============================================================================
let s:final_local_file = expand('<sfile>:h') . '/final.local.vim'
if filereadable(s:final_local_file)
    execute 'source ' s:final_local_file
endif
