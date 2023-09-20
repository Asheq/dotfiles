if exists("b:current_syntax")
    finish
endif

syntax match asheqName /\v\c<(asheq)>/

highlight default link asheqName Special

let b:current_syntax = "asheq"
