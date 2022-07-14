" TODO: Change colorscheme and background based on Mac theme
colorscheme asheq-codedark
set background=dark

" TODO: Guard if colorizer module is not installed
lua require'colorizer'.setup()

autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=300, on_visual=true}
