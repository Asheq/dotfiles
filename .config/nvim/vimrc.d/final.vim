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

highlight! link htmlH1       CocListBlackGreen
highlight! link htmlH2       CocListBlackBlue
highlight! link htmlH3       CocListBlackWhite
highlight! link htmlH4       CocListBlackGrey

highlight! link MatchParen   CocBold

highlight! link WinBar       StatusLine
highlight! link WinBarNC     StatusLineNC

highlight! Substitute        guifg=#ffffff guibg=#b16286

highlight! StatusLineNC      guifg=NvimDarkGrey3 guibg=NvimLightGrey4
highlight! Visual            guibg=#bda9b0
highlight! CursorLine        guibg=#c6d3cf

" Open Neovide in home directory
" ============================================================================
if exists('g:neovide')
    cd ~
endif

" Run final.lua
" ============================================================================
luafile <sfile>:h/final.lua
"
" Run final.local.vim if it exists
" ============================================================================
if filereadable(expand('<sfile>:h') . '/final.local.vim')
    source <sfile>:h/final.local.vim
endif
