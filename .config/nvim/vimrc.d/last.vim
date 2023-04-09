autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=300, on_visual=true}

set background=light
colorscheme gruvbox

luafile <sfile>:h/last.lua

" It seems I have to do this here, and not in last.lua. Otherwise, the
" color gets overriden
" highlight link htmlH2 Function
