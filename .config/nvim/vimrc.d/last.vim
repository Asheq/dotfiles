colorscheme asheq-codedark

" TODO: Guard if colorizer module is not installed
lua require'colorizer'.setup()

autocmd TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=300, on_visual=true}
