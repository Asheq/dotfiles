" TODO: Verify that this is the correct structure for this file

if exists("b:current_syntax")
    finish
endif

syntax match myName /\v\c<(asheq)>/

" TODO": I'm not sure if the highlight belongs here or in another file
highlight default link myName Special

let b:current_syntax = "asheq"
