" context
" ----------------------------------------------------------------------------
let g:context_enabled = 0

" dirvish
" ----------------------------------------------------------------------------
" Uncomment this line to sort directories first
" let g:dirvish_mode = ':sort ,^.*[\/],'

augroup dirvish_config
    autocmd!

    " Map `t` to open in new tab
    autocmd FileType dirvish
                \  nnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
                \ |xnoremap <silent><buffer> t :call dirvish#open('tabedit', 0)<CR>
augroup END

" markdown
" ----------------------------------------------------------------------------
let g:vim_markdown_folding_style_pythonic = 1

" scrollview
" ----------------------------------------------------------------------------
let g:scrollview_base='left'
let g:scrollview_column=1
let g:scrollview_auto_mouse=0
