command! PrintGeneralOptions call print_stuff#print_general()

command! PrintFormattingOptions call print_stuff#print_formatting()

command! PrintIndentingOptions call print_stuff#print_indenting()

command! PrintFoldingOptions call print_stuff#print_folding()

" TODO: Add Print... command for buffer-local mappings
" TODO: Add Print... command for buffer-local variables (and window-local variables)
" TODO: Add Print... command for buffer-local options

" TODO: Add Print... commands for:
" path
" suffixesadd
"
" suffixes
"
" iskeyword
" isfname
"
" keywordprg
"
" omnifunc
"
" matchpairs
"
" define
" include
" includeexpr
