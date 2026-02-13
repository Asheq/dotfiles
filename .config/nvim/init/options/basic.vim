" Global
" ----------------------------------------------------------------------------
set tabline=%!vimrc#get_tabline()
set noruler
set jumpoptions=stack
set notimeout
set nowrapscan
set report=1
set splitbelow
set splitright
set wildcharm=<C-z>
let &wildignore='.DS_Store,.tmp.drivedownload,.tmp.driveupload'
let &guifont='PragmataPro Mono:h22'
set linespace=5

" Tab [+ Global]
" ----------------------------------------------------------------------------
set cmdheight=2

" Window [+ Global]
" ----------------------------------------------------------------------------
set statusline=%!vimrc#get_statusline()
set cursorline
set number
set conceallevel=2
set smoothscroll
set foldcolumn=auto:9
set foldexpr=v:lua.vim.treesitter.foldexpr()
set foldmethod=expr
set foldtext=

" Buffer [+ Global]
" ----------------------------------------------------------------------------
set spelloptions=camel
set undofile
set dictionary+=/usr/share/dict/words
let &grepprg='rg --vimgrep'
