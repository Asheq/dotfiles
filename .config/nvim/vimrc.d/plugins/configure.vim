" markdown
" ----------------------------------------------------------------------------
let g:vim_markdown_folding_style_pythonic = 1
let g:vim_markdown_override_foldtext = 0

let g:vim_markdown_no_default_key_mappings = 1

let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0

" lion
" ----------------------------------------------------------------------------
let g:lion_squeeze_spaces = 1

" sandwich
" ----------------------------------------------------------------------------
" TODO-L: Add sandwich text objects without clobbering default as/is
let g:textobj_sandwich_no_default_key_mappings = 1

" highlighter
" ----------------------------------------------------------------------------
let HiKeywords = stdpath("config") . '/after/vim-highlighter'

" Run configure.lua
" ----------------------------------------------------------------------------
luafile <sfile>:h/configure.lua
