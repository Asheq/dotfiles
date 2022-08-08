" TODO: Detect whether system is in dark or light mode and choose theme accordingly
set background=dark
" colorscheme asheq-codedark
colorscheme gruvbox

" set background=light
" colorscheme default

" TODO: Guard if colorizer module is not installed
lua require'colorizer'.setup()

autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=300, on_visual=true}
