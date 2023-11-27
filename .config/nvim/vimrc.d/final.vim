augroup set_listchars
    autocmd!
    autocmd OptionSet tabstop call s:set_listchars()
augroup END

function! s:set_listchars()
    execute 'set listchars+=leadmultispace:┊' . repeat('\ ', &tabstop - 1)
endfunction

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
        highlight! CursorLine                               guibg=#014575
        highlight! DiffChange                               guibg=#410091
        highlight! DiffText                   guifg=#282828 guibg=#a576fe
        highlight! StatusLine     gui=reverse guifg=#ebdbb2 guibg=#3c3836
        highlight! StatusLineNC   gui=reverse guifg=#504945 guibg=#ebdbb2
        highlight! DiffAdd                                  guibg=#35491e
    else
        highlight! CursorLine                               guibg=#d5e6f2
        highlight! DiffChange                               guibg=#e1d4f2
        highlight! DiffText                   guifg=#fbf1c7 guibg=#815492
        highlight! StatusLine     gui=reverse guifg=#3c3836 guibg=#ebdbb2
        highlight! StatusLineNC   gui=reverse guifg=#d5c4a1 guibg=#3c3836
    endif

    highlight! Todo               gui=bold,italic guifg=none  guibg=none
    highlight! Match                              guifg=white guibg=green

    highlight! link TabLineFill  StatusLineNC
    highlight! link TabLine      StatusLineNC
    highlight! link TabLineSel   StatusLine

    " TODO-L:
    " Analyze and fine-tune the priority of the following highlights that change the background:
    "     - CursorLine
    "     - Diff*
    "     - Visual
    "     - Search
    "     - IncSearch
    "     - MatchParen
    "     - Match
    "     - Fold
    "
    "     - colorizer*?
endfunction

" Set colorscheme
" ============================================================================
try
    colorscheme gruvbox
catch
endtry

" Run final.lua
" ============================================================================
luafile <sfile>:h/final.lua
