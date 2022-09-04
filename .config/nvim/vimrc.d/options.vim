" The options here are grouped and organized like :options

" 2. Moving around, searching and patterns
" ----------------------------------------------------------------------------
set nowrapscan
if exists("&inccommand")
    set inccommand=split
endif

" 4. Displaying text
" ----------------------------------------------------------------------------
set breakindent
set cmdheight=2
set list
set listchars=tab:·\ ,trail:￮,extends:▶,precedes:◀,nbsp:⏑
set number
set showbreak=└─▶
set fillchars=fold:\ 
set nowrap

" 5. Syntax, highlighting and spelling
" ----------------------------------------------------------------------------
set termguicolors
set nospell

" 6. Multiple windows
" ----------------------------------------------------------------------------
set statusline=%!vimrc#get_statusline()
" set splitright
" set splitbelow

" 9. Using the mouse
" ----------------------------------------------------------------------------
set mouse=a
set mousetime=0

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
let &wildignore='.DS_Store,Icon,.tmp.drivedownload'

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
    set guifont=Iosevka\ Term:h18
endif
