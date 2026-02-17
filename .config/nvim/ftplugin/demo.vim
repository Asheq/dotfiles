" TODO: Convert to lua

if exists("b:did_ftplugin")
	finish
endif

let b:did_ftplugin = 1

" Buffer-local variable
let b:demo_var = "This is b:demo_var"

" Buffer-local ex command
command! -buffer DemoCmd echo "Hello from :DemoCmd"

" Global function
function! DemoFunc()
	echo "Hello from DemoFunc()"
endfunction

" Buffer-local mappings
nnoremap <buffer> <leader>b :lua require('demo').hello()<CR>

" Buffer-local option
setlocal relativenumber

let b:undo_ftplugin = join([
      \ 'unlet b:demo_var',
      \ 'delcommand DemoCmd',
      \ 'delfunction DemoFunc',
      \ 'exe "nunmap <buffer> <leader>b"',
      \ 'setl relativenumber<',
      \ ], ' | ')
