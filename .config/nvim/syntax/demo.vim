if exists("b:current_syntax")
	finish
endif

syntax keyword demo demo
syntax match whatever /\v\c<(whatever)>/

highlight default demo guifg=Black guibg=Yellow
highlight default link whatever Special

let b:current_syntax = "demo"
