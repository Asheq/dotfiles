" Load third-party plugins via vim-plug
" ============================================================================
call plug#begin()

" Other
" ---------------------------------------------------------------------------
Plug 'tpope/vim-characterize'

" Text editing
" ---------------------------------------------------------------------------
" Pure motions
Plug 'jeetsukumaran/vim-indentwise'

" Pure text objects
" [NONE]

" Mix of some of: operators, text objects, ex commands
Plug 'machakann/vim-sandwich'

" Auto-set options
" ----------------------------------------------------------------------------
Plug 'tpope/vim-projectionist'

" Integration with git and GitHub
" ----------------------------------------------------------------------------
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Directory explorer
" ----------------------------------------------------------------------------
Plug 'stevearc/oil.nvim'

" Scrollbar
" ----------------------------------------------------------------------------
Plug 'gcavallanti/vim-noscrollbar'

" Highlighting
" ----------------------------------------------------------------------------
Plug 'azabiong/vim-highlighter'

" Filetype plugins
" ----------------------------------------------------------------------------
" Various
Plug 'tpope/vim-apathy'

" Markdown
" TODO-L: Fix this:
" This file: $VIMRUNTIME/ftplugin/markdown.vim
" executes after this file: ~/.vim/plugged/vim-markdown/ftplugin/markdown.vim
" This means that the $VIMRUNTIME file overrides some things, e.g., mappings
" set in preservim/vim-markdown.
" This is pretty bad, right?
" Just wait until I migrate to Lua and lua plugin manager?
" TODO-L: Also, it's best to remove this plugin, anyway. It seems unmaintained
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

" Language Server
" ----------------------------------------------------------------------------
if executable('node')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

" plug#end() automatically executes:
"   1. 'filetype plugin indent on'
"   2. 'syntax enable'
call plug#end()

" Load first-party plugins.
"
" These are included with neovim but are not loaded automatically. For a full
" list of such plugins, see: $VIMRUNTIME/pack/dist/opt/.
"
" Note that "matchit" is special; it is automatically loaded due to
" $VIMRUNTIME/plugin/matchit.vim.
" ============================================================================
packadd cfilter
