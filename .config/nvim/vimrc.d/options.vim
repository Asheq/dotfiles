" The options here are grouped and organized like :options

" 2. Moving around, searching and patterns
" ----------------------------------------------------------------------------
set nowrapscan
set jumpoptions=stack

" 4. Displaying text
" ----------------------------------------------------------------------------
set breakindent
set breakindentopt=list:-1
set list
let &listchars='tab:│ ,lead:⚬,leadmultispace:┊ ,trail:⚬,extends:▶,precedes:◀,conceal: ,nbsp:◯'
set number
let &showbreak='↪ '
set cmdheight=2
let &fillchars='foldopen:▼,foldclose:▶,diff:╱,lastline:▶'
set nowrap
set smoothscroll

" 5. Syntax, highlighting and spelling
" ----------------------------------------------------------------------------
set termguicolors
set cursorline
set spelloptions=camel

" 6. Multiple windows
" ----------------------------------------------------------------------------
set statusline=%!vimrc#get_statusline()

" 7. Multiple tab pages
" ----------------------------------------------------------------------------
set tabline=%!vimrc#get_tabline()

" 10. Messages and info
" ----------------------------------------------------------------------------
set noruler
set report=1

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

" GUI options
" ----------------------------------------------------------------------------
if exists('g:neovide')
    " NOTE: Neovide doesn't render "PragmataPro Mono", for some reason
    set guifont=Iosevka\ Term:h18

    silent !defaults read -g AppleInterfaceStyle &> /dev/null
    if v:shell_error == 0
        set background=dark
    else
        set background=light
    endif
endif
