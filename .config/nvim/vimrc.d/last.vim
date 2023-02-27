autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=300, on_visual=true}

luafile <sfile>:h/last.local.lua
