" Load third-party plugins via vim-plug
" ============================================================================
" TODO-L: Choose a neovim directory
call plug#begin('~/.vim/plugged')

" Text editing
" ---------------------------------------------------------------------------
" Pure operators
Plug 'tommcdo/vim-lion'
Plug 'arthurxavierx/vim-caser'

" Pure motions
Plug 'jeetsukumaran/vim-indentwise'

" Pure text objects
" [NONE]

" Mix of some of: operators, text objects, ex commands
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-abolish'
Plug 'machakann/vim-sandwich'


" Auto-set options
" ----------------------------------------------------------------------------
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
" TODO-L: norcalli/nvim-colorizer.lua is not maintained anymore.
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

" TODO-L: Fix this:
" When I had `Plug 'preservim/vim-markdown'`:
" This file: $VIMRUNTIME/ftplugin/markdown.vim
" executed after this file: ~/.vim/plugged/vim-markdown/ftplugin/markdown.vim
" This means that the $VIMRUNTIME file overrided some things, e.g., mappings
" set in the preservim/vim-markdown file.

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

" Load first-party plugins.
"
" These are included with neovim but not loaded automatically. For a full
" list of such plugins, see: $VIMRUNTIME/pack/dist/opt/.
"
" Note that "matchit" actually is automatically loaded due to
" $VIMRUNTIME/plugin/matchit.vim.
" ============================================================================
packadd cfilter
