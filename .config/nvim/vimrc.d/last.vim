autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=300, on_visual=true}

luafile <sfile>:h/last.local.lua

" It seems I have to do this here, and not in last.local.lua. Otherwise, the
" color gets overriden
highlight link htmlH2 Function
