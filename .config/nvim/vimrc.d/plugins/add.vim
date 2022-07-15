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
Plug 'plasticboy/vim-markdown'

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

" Language Server
" ----------------------------------------------------------------------------

if executable('node')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    " TODO
    " let g:coc_global_extensions = [
    "             \ 'coc-prettier',
    "             \ 'coc-eslint',
    "             \ 'coc-json',
    "             \ 'coc-html',
    "             \ 'coc-css',
    "             \ 'coc-lists'
    "             \ ]
endif

" plug#end() automatically executes:
"   1. 'filetype plugin indent on'
"   2. 'syntax enable'
call plug#end()

" Add first-party plugins (those included in vim distro)
" ============================================================================
packadd cfilter
