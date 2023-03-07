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

Plug 'giusgad/pets.nvim'
Plug 'giusgad/hologram.nvim'
Plug 'MunifTanjim/nui.nvim'

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
