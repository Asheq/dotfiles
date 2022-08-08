" TODO: Detect whether system is in dark or light mode and choose theme accordingly
colorscheme asheq-codedark
set background=dark
" colorscheme default
" set background=light

" TODO: Guard if colorizer module is not installed
lua require'colorizer'.setup()

autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=300, on_visual=true}
