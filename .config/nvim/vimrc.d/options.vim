" The options here are grouped and organized like :options

" 2. Moving around, searching and patterns
" ----------------------------------------------------------------------------
set nowrapscan
set inccommand=split

" 4. Displaying text
" ----------------------------------------------------------------------------
set breakindent
set cmdheight=2
set list
set listchars=tab:△┈,leadmultispace:□┈┈┈,trail:·,multispace:˙,lead:\ ,extends:▶,precedes:◀,nbsp:‿
set number
set showbreak=└─▶
set fillchars=fold:\ 
set nowrap

" 5. Syntax, highlighting and spelling
" ----------------------------------------------------------------------------
set termguicolors
set cursorline

" 6. Multiple windows
" ----------------------------------------------------------------------------
set statusline=%!vimrc#get_statusline()
set splitright
set splitbelow

" 7. Multiple tab pages
" ----------------------------------------------------------------------------
set tabline=%!vimrc#get_tabline()

" 9. Using the mouse
" ----------------------------------------------------------------------------
set mouse=a

" 13. Editing text
" ----------------------------------------------------------------------------
set undofile

" 15. Folding
" ----------------------------------------------------------------------------
set foldcolumn=auto:9
set foldtext=vimrc#get_fold_text()

" 20. Command line editing
" ----------------------------------------------------------------------------
set wildcharm=<C-z>
let &wildignore='.DS_Store,.tmp.drivedownload'

" 22. Running make and jumping to errors
" ----------------------------------------------------------------------------
if executable('rg')
    set grepprg=rg\ --vimgrep
    set grepformat^=%f:%l:%c:%m
    set grepformat+=%f
endif

" Other
" ----------------------------------------------------------------------------
set jumpoptions=stack

" Generic GUI options
" ----------------------------------------------------------------------------
if exists('&guifont')
    set guifont=PragmataPro\ Mono:h18
endif
