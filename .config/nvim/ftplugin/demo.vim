if exists("b:did_ftplugin")
	finish
endif

let b:did_ftplugin = 1

" Buffer-local variable
let b:demo_var_vim = "This is b:demo_var_vim"

" Global Vimscript function
function! DemoFuncVim()
	echo "Hello from DemoFuncVim()"
endfunction

" Window-local option
setlocal relativenumber

" Buffer-local mappings
nnoremap <buffer> <leader>bv :call demo#hello()<CR>

" Buffer-local user command
command! -buffer DemoCmdVim echo "Hello from :DemoCmdVim"

let b:undo_ftplugin = join([
			\ 'unlet b:demo_var_vim',
			\ 'delfunction DemoFuncVim',
			\ 'setl relativenumber<',
			\ 'exe "nunmap <buffer> <leader>bv"',
			\ 'delcommand DemoCmdVim',
			\ ], ' | ')
