" The options here are grouped and organized like :options

" 2. Moving around, searching and patterns
" ----------------------------------------------------------------------------
set nowrapscan
set inccommand=split
set jumpoptions=stack

" 4. Displaying text
" ----------------------------------------------------------------------------
set breakindent
set cmdheight=2
set list
let &listchars='tab:│ ,space: ,multispace: ,lead:⚬,leadmultispace:┊ ,trail:⚬,extends:▶,precedes:◀,conceal: ,nbsp:◯'
set number
set showbreak=↪

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

" Generic GUI options
" ----------------------------------------------------------------------------
if exists('&guifont')
    set guifont=PragmataPro\ Mono:h18
endif
