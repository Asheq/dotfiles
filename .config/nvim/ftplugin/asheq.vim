if exists("b:did_ftplugin")
	finish
endif

let b:did_ftplugin = 1

" Buffer-local variable
let b:asheq_var = "This is a buffer-local variable"

" Buffer-local ex command
command! -buffer AsheqCmd echo "Hello from command!"

" Buffer-local mapping
nnoremap <buffer> <leader>b :call AsheqFunc()<CR>

" Global function
function! AsheqFunc()
  echo "Hello from function!"
endfunction

" Buffer-local option
setlocal relativenumber
" - formatting options
"     - `'formatprg'`
"     - `'formatexpr'`
"     - `'textwidth'`
"     - `'formatoptions'`
"     - `'formatlistpath'`
" - `'keywordprg'`
" - `'comments'`
" - `'commentstring'`
" - `'path'`
" - `'suffixes'`
" - `'suffixesadd'`
" - `'includeexpr'`
" - `'omnifunc'`

let b:undo_ftplugin = join([
      \ 'unlet b:asheq_var',
      \ 'delcommand AsheqCmd',
      \ 'delfunction AsheqFunc',
      \ 'setl relativenumber<',
      \ ], ' | ')

" I would like to include the following in b:undo_ftplugin, however it does not work and throws an error:
"     nunmap <buffer> <leader>b
" Manually removing the mapping works though.
