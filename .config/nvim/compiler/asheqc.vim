" This file is loaded when `:compiler asheqc` is executed

if exists("current_compiler")
  finish
endif

let current_compiler = "asheqc"

" Copied from $VIMRUNTIME/compiler/go.vim
CompilerSet makeprg=go\ build
CompilerSet errorformat=
    \%-G#\ %.%#,
    \%A%f:%l:%c:\ %m,
    \%A%f:%l:\ %m,
    \%C%*\\s%m,
    \%-G%.%#
