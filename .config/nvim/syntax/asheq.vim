if exists("b:current_syntax")
	finish
endif

syntax keyword aashiqName Aashiq
syntax match asheqName /\v\c<(asheq)>/

highlight default aashiqName guifg=Black guibg=Yellow
highlight default link asheqName Special

let b:current_syntax = "asheq"
