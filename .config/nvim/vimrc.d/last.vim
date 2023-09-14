autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=300, on_visual=true}

set background=light
colorscheme gruvbox

luafile <sfile>:h/last.lua

