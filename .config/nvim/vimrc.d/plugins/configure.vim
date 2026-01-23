" markdown
" ----------------------------------------------------------------------------
let g:markdown_folding = 1

" indentwise
" ----------------------------------------------------------------------------
let g:indentwise_suppress_keymaps = 1

" sandwich
" ----------------------------------------------------------------------------
" TODO-L: Add sandwich text objects without clobbering default as/is
let g:textobj_sandwich_no_default_key_mappings = 1

" highlighter
" ----------------------------------------------------------------------------
let HiKeywords = stdpath("config") . '/after/vim-highlighter'

" markdown-preview.nvim
" ----------------------------------------------------------------------------
function OpenMarkdownPreview (url)
	execute "silent ! open -a Firefox -n --args --new-window " . a:url
endfunction
let g:mkdp_browserfunc = 'OpenMarkdownPreview'

" Run configure.lua
" ----------------------------------------------------------------------------
luafile <sfile>:h/configure.lua
