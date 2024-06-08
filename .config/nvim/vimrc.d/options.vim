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
let &listchars='tab:│ ,lead:⚬,trail:⚬,extends:▶,precedes:◀,conceal: ,nbsp:◯,leadmultispace:┊ '
set number
let &showbreak='> '
set cmdheight=2
let &fillchars='foldopen:▼,foldclose:▶,diff:╱,lastline:▶'
set nowrap
set smoothscroll
set conceallevel=2

" 5. Syntax, highlighting and spelling
" ----------------------------------------------------------------------------
set cursorline
set spelloptions=camel

" 6. Multiple windows
" ----------------------------------------------------------------------------
set statusline=%!vimrc#get_statusline()
set splitright
set splitbelow

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
set dictionary+=/usr/share/dict/words

" 15. Folding
" ----------------------------------------------------------------------------
set foldcolumn=auto:9
set foldtext=

" 16. Mapping
" ----------------------------------------------------------------------------
set notimeout

" 20. Command line editing
" ----------------------------------------------------------------------------
set wildcharm=<C-z>
let &wildignore='.DS_Store,.tmp.drivedownload,.tmp.driveupload,Icon'

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
    set linespace=5
    " NOTE: Neovide doesn't render "PragmataPro Mono" correctly, for some reason
     set guifont=PragmataPro\ Mono\ Liga:h16
    "set guifont=Iosevka\ Term:h16
    let g:neovide_theme = 'auto'
    let g:neovide_input_macos_alt_is_meta = v:true
    let g:neovide_cursor_animation_length = 0
endif
