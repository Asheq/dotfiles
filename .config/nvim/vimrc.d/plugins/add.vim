" Begin
" ----------------------------------------------------------------------------
call plug#begin()

" Core Libraries
" ---------------------------------------------------------------------------
Plug 'nvim-lua/plenary.nvim'

" General Editing + Motions/Operators/Text objects
" ---------------------------------------------------------------------------
Plug 'jeetsukumaran/vim-indentwise'
Plug 'machakann/vim-sandwich'

" Git Integration
" ----------------------------------------------------------------------------
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Code Intelligence
" ----------------------------------------------------------------------------
" Treesitter
" NOTE: Treesitter incrementally parses code in real-time to maintain a syntax tree, which is used to provide improved syntax highlighting, code folding, indentation, and structural navigation/editing, etc. (compared to traditional regex-based methods).
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'

" LSP
" NOTE: Language servers handle language intelligence outside the editor to provide completion, diagnostics, go-to-definition, find references, hover documentation, code actions (refactoring, fixes), formatting, etc. via a standardized protocol (LSP).
if executable('node')
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
endif

" AI/Assistants
" NOTE: AI/Assistants attempt to understand your codebase to generate code, suggest code, explain code, and automate tasks. They are also useful useful for generating documentation, code review, and learning.
Plug 'github/copilot.vim'
Plug 'CopilotC-Nvim/CopilotChat.nvim'

" Filetype Plugins
" ----------------------------------------------------------------------------
" NOTE: Currently commenting out to reduce plugin bloat, since Treesitter and
" LSP provide much of the same functionality across languages.
" TODO-L: Remove permanently if not needed anymore.

" Various
"Plug 'tpope/vim-apathy'

" Markdown
"Plug 'preservim/vim-markdown'

" JavaScript
"Plug 'pangloss/vim-javascript'

" TypeScript
"Plug 'leafgarland/typescript-vim'

" JSX
"Plug 'MaxMEllon/vim-jsx-pretty'

" TSX
"Plug 'peitalin/vim-jsx-typescript'

" Git
"Plug 'tpope/vim-git'

" Other Quality of Life
" ---------------------------------------------------------------------------
Plug 'gcavallanti/vim-noscrollbar'
Plug 'stevearc/oil.nvim'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-projectionist'
Plug 'azabiong/vim-highlighter'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npx --yes yarn install' }
Plug 'folke/snacks.nvim'

" End
" ----------------------------------------------------------------------------
" plug#end() automatically executes:
"   1. 'filetype plugin indent on'
"   2. 'syntax enable'
call plug#end()
