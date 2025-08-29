" Begin
" ----------------------------------------------------------------------------
call plug#begin()

" Other
" ---------------------------------------------------------------------------
Plug 'azabiong/vim-highlighter'
Plug 'gcavallanti/vim-noscrollbar'
Plug 'stevearc/oil.nvim'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-projectionist'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'nvim-lua/plenary.nvim' " Required for CopilotChat.nvim and neogit

" Motions, Operators, Text objects
" ---------------------------------------------------------------------------
Plug 'jeetsukumaran/vim-indentwise'
Plug 'machakann/vim-sandwich'

" git, GitHub
" ----------------------------------------------------------------------------
" Basic git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Copilot
Plug 'github/copilot.vim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'

" New git plugins to explore
Plug 'NeogitOrg/neogit'
Plug 'sindrets/diffview.nvim'

" Language Server, Treesitter
" ----------------------------------------------------------------------------
if executable('node')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

" Fuzzy finder/picker
" ---------------------------------------------------------------------------
" Plug 'nvim-telescope/telescope.nvim',
" Plug 'ibhagwan/fzf-lua',
" Plug 'echasnovski/mini.pick',
" Plug 'folke/snacks.nvim',

" Filetype plugins
" ----------------------------------------------------------------------------
" Various
Plug 'tpope/vim-apathy'

" Markdown
" TODO-L: Fix this:
" This file: $VIMRUNTIME/ftplugin/markdown.vim
" executes after this file: ~/.local/share/nvim/plugged/vim-markdown/ftplugin/markdown.vim
" This means that the $VIMRUNTIME file overrides some things, e.g., mappings
" set in preservim/vim-markdown.
" This is pretty bad, right?
" Also, it's best to remove this plugin, anyway. It seems unmaintained
" and does a lot strange things like force overwrite fold method.
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

" End
" ----------------------------------------------------------------------------
" plug#end() automatically executes:
"   1. 'filetype plugin indent on'
"   2. 'syntax enable'
call plug#end()
