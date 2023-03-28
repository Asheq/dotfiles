" Add third-party plugins via vim-plug
" ============================================================================
call plug#begin('~/.vim/plugged')

" Operators, motions, and text objects
" ---------------------------------------------------------------------------
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'machakann/vim-sandwich'
Plug 'arthurxavierx/vim-caser'

" Auto-set options
" ----------------------------------------------------------------------------
Plug 'editorconfig/editorconfig-vim'
Plug 'tpope/vim-projectionist'

" Integration with git and GitHub
" ----------------------------------------------------------------------------
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Directory explorer
" ----------------------------------------------------------------------------
Plug 'justinmk/vim-dirvish'

" Syntax/highlighting
" ----------------------------------------------------------------------------
Plug 'norcalli/nvim-colorizer.lua'

" Buffer/window/tab management
" ----------------------------------------------------------------------------
Plug 'Asheq/close-buffers.vim'

" Filetype-specific
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

" Scrollbar
" ----------------------------------------------------------------------------
Plug 'dstein64/nvim-scrollview'

" Other
" ----------------------------------------------------------------------------
Plug 'tpope/vim-characterize'
Plug 'wellle/context.vim'
Plug 'tpope/vim-abolish'
Plug 'azabiong/vim-highlighter'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install' }

" Neorg
" ----------------------------------------------------------------------------
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Run the following command in the terminal to install tree-sitter parsers for norg:
" CC=gcc-12 nvim -c "TSInstallSync norg"
" Do this any time neorg is updated to ensure the latest version of the parser
" is installed. Later, when you migrate to the lazy package manger, you won't
" need to this manually.
Plug 'nvim-neorg/neorg'
Plug 'nvim-lua/plenary.nvim'

" Colorschemes
" ----------------------------------------------------------------------------
Plug 'ellisonleao/gruvbox.nvim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'projekt0n/github-nvim-theme'

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
