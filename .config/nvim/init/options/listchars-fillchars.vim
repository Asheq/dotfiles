" listchars
" ----------------------------------------------------------------------------
set list
let &listchars='tab:│ ,lead:࿁,nbsp:▢,trail:࿁,extends:➤,precedes:⮜'

" NOTE: I am setting the value of "leadmultispace" within 'listchars' in an
" autocommand below, since it depends on the value of "tabstop" which could be
" different for different buffers and can change on the fly.
augroup set_listchars
    autocmd!
    autocmd OptionSet tabstop call s:set_listchars()
    autocmd BufWinEnter * call s:set_listchars()
augroup END

function! s:set_listchars()
    execute 'setlocal listchars-=' . escape(matchstr(&listchars, 'leadmultispace.\{-}\ze\($\|,\)'), ' ')
    execute 'setlocal listchars+=leadmultispace:┊' . repeat('\ ', &tabstop - 1)
endfunction

call s:set_listchars()

" fillchars
" ----------------------------------------------------------------------------
let &fillchars='foldopen:▽,foldclose:▶,diff:╱,lastline:➤'
