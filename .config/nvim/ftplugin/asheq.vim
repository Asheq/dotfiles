if exists("b:did_ftplugin")
	finish
endif

let b:did_ftplugin = 1

" Buffer-local variable
let b:asheq_var = "This is a buffer-local variable"

" Buffer-local ex command
command! -buffer AsheqCmd echo "Hello from AsheqCmd"

" Buffer-local mapping
nnoremap <buffer> <leader>b :echo AsheqFunc()<CR>

" Global function
function! AsheqFunc()
	return "Hello from AsheqFunc"
endfunction

" Buffer-local option
setlocal relativenumber

let b:undo_ftplugin = join([
      \ 'unlet b:asheq_var',
      \ 'delcommand AsheqCmd',
      \ 'delfunction AsheqFunc',
      \ 'exe "nunmap <buffer> <leader>b"',
      \ 'setl relativenumber<',
      \ ], ' | ')
