" This file is loaded when `:compiler democ` is executed

if exists("current_compiler")
  finish
endif

let current_compiler = "democ"

CompilerSet makeprg=rg\ --vimgrep\ dolor
CompilerSet errorformat=%f:%l:%c:%m
