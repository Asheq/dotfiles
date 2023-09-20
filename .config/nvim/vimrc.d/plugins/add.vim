" Add third-party plugins via vim-plug
" ============================================================================
call plug#begin('~/.vim/plugged')

" Folding
" NOTE: I'm just using context to refresh the screen (via CursorMoved autocmd?)
" ---------------------------------------------------------------------------
Plug 'wellle/context.vim'

" Text editing
" ---------------------------------------------------------------------------
" Pure operators
Plug 'tommcdo/vim-lion'
Plug 'arthurxavierx/vim-caser'

" Pure motions
Plug 'jeetsukumaran/vim-indentwise'

" Pure text objects
" NONE

" Mix of some of ex commands, operators, and text objects
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'machakann/vim-sandwich'


" Auto-set options
" ----------------------------------------------------------------------------
" TODO: Remove now that neovim adds support for editorconfig by default?
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-projectionist'

" Integration with git and GitHub
" ----------------------------------------------------------------------------
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Scrollbar
" ----------------------------------------------------------------------------
Plug 'dstein64/nvim-scrollview'

" Directory explorer
" ----------------------------------------------------------------------------
Plug 'justinmk/vim-dirvish'

" Undo tree
" ----------------------------------------------------------------------------
Plug 'mbbill/undotree'

" Highlighting
" ----------------------------------------------------------------------------
Plug 'norcalli/nvim-colorizer.lua'
Plug 'azabiong/vim-highlighter'

" Buffer/window/tab management
" ----------------------------------------------------------------------------
Plug 'Asheq/close-buffers.vim'

" Markdown preview
" ----------------------------------------------------------------------------
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }

" Filetype plugins
" ----------------------------------------------------------------------------
" Various
Plug 'tpope/vim-apathy'

" Markdown
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'

" JavaScript
Plug 'pangloss/vim-javascript'

" TypeScript
Plug 'leafgarland/typescript-vim'

" JSX
Plug 'MaxMEllon/vim-jsx-pretty'

" TSX
Plug 'peitalin/vim-jsx-typescript'

" Git
Plug 'tpope/vim-git'

" Character info
" ----------------------------------------------------------------------------
Plug 'tpope/vim-characterize'

" Colorschemes
" ----------------------------------------------------------------------------
Plug 'ellisonleao/gruvbox.nvim'

" Language Server
" ----------------------------------------------------------------------------
if executable('node')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

" plug#end() automatically executes:
"   1. 'filetype plugin indent on'
"   2. 'syntax enable'
call plug#end()

" Add first-party plugins (those included in vim distro)
" ============================================================================
packadd cfilter
