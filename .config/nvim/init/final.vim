" Highlight yanked text
" ============================================================================
augroup highlight_yanked_text
    autocmd!
    autocmd TextYankPost * silent! lua vim.hl.on_yank {higroup="IncSearch", timeout=300, on_visual=true}
augroup END

" Highlight Overrides
" ============================================================================
" TODO-L: Submit issue to coc.nvim: CocMenuSel is difficult to read when
" bg=light. Low priority, especially since I will stop using Coc.
highlight! link CocMenuSel   PmenuSel

highlight! link MatchParen   CocBold

highlight! link WinBar       StatusLine
highlight! link WinBarNC     StatusLineNC

highlight! link TabLineSel   StatusLine
highlight! link TabLine      StatusLineNC

highlight! link @markup.heading.1.markdown CocListBlackYellow
highlight! link @markup.heading.2.markdown CocListBlackCyan
highlight! link @markup.heading.3.markdown CocListBlackBlue
highlight! link @markup.heading.4.markdown CocListBlackWhite

function! s:on_bg_change()

    if &background ==# 'light'
        highlight! Visual            guibg=#bda9b0
        highlight! Substitute        guifg=#ffffff guibg=#b16286
        highlight! CursorLine        guibg=#c6d3cf

        " For transparency in terminal
        if !exists('g:neovide')
            highlight! Normal            guifg=NvimDarkGrey2 guibg=NONE
        endif
    elseif &background ==# 'dark'
        highlight! Visual            guibg=#45353b
        highlight! Substitute        guifg=#ffffff guibg=#b16286
        highlight! CursorLine        guibg=#32413c

        " For transparency in terminal
        if !exists('g:neovide')
            highlight! Normal            guifg=NvimLightGrey2 guibg=NONE
        endif
    endif
endfunction

autocmd OptionSet background call s:on_bg_change()
call s:on_bg_change()

" Open Neovide in home directory
" ============================================================================
if exists('g:neovide')
    cd ~
endif
