" If syntax already loaded, skip
if exists("b:current_syntax")
	finish
endif

" Keyword
syntax keyword aashiqName Aashiq

" Match
syntax match asheqName /\v\c<(asheq)>/

" Custom highlight group
highlight default aashiqName guifg=Black guibg=Yellow

" Link to built-in highlight group
highlight default link asheqName Special

" Set current syntax
let b:current_syntax = "asheq"
