" The options here are grouped and organized like :options

" 2. Moving around, searching and patterns
" ----------------------------------------------------------------------------
set nowrapscan
set jumpoptions=stack

" 4. Displaying text
" ----------------------------------------------------------------------------
set nowrap
set linebreak
let &showbreak='↪'
set breakindent
set breakindentopt=list:-1

set list
let &listchars='tab:│ ,lead:࿁,nbsp:▢,trail:࿁,extends:➤,precedes:⮜' " NOTE: Could add "eol:🮦"
" NOTE: I am setting the value of "leadmultispace" within 'listchars' in an
" autocommand below, since it depends on the value of "tabstop" which could be
" different for different buffers and can change on the fly.
augroup set_listchars
    autocmd!
    autocmd OptionSet tabstop call s:set_listchars()
    autocmd BufWinEnter * call s:set_listchars()
augroup END
function! s:set_listchars()
    execute 'setlocal listchars-=' . escape(matchstr(&listchars, 'leadmultispace.\{-}\ze\($\|,\)'), ' ')
    execute 'setlocal listchars+=leadmultispace:┊' . repeat('\ ', &tabstop - 1)
endfunction
call s:set_listchars()

let &fillchars='foldopen:▽,foldclose:▶,diff:╱,lastline:➤'
set number
set cmdheight=2
set smoothscroll
set conceallevel=2

" 5. Syntax, highlighting and spelling
" ----------------------------------------------------------------------------
set cursorline
set spelloptions=camel

" NOTE: There are bugs that cause colorcolumn to be displayed incorrectly when
" used in combination with wrap and linebreak/breakindent/showbreak. Until
" these bugs are fixed, I am using an autocommand to toggle colorcolumn when
" wrap is toggled, to avoid confusing display.
augroup set_colorcolumn
    autocmd!
    autocmd OptionSet wrap call s:set_colorcolumn()
    autocmd BufWinEnter * call s:set_colorcolumn()
augroup END
function! s:set_colorcolumn()
	if &wrap
		set colorcolumn-=+1
	else
		set colorcolumn+=+1
	endif
endfunction
call s:set_colorcolumn()

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

" 12. Editing text
" ----------------------------------------------------------------------------
set undofile
set dictionary+=/usr/share/dict/words

" 14. Folding
" ----------------------------------------------------------------------------
set foldcolumn=auto:9
set foldtext=
set foldmethod=expr
set foldexpr=v:lua.vim.treesitter.foldexpr()

" 16. Mapping
" ----------------------------------------------------------------------------
set notimeout

" 19. Command line editing
" ----------------------------------------------------------------------------
set wildcharm=<C-z>
let &wildignore='.DS_Store,.tmp.drivedownload,.tmp.driveupload'

" 22. Running make and jumping to errors
" ----------------------------------------------------------------------------
if executable('rg')
    set grepprg=rg\ --vimgrep
endif

" GUI options
" ----------------------------------------------------------------------------
set guifont=PragmataPro\ Mono:h22
set linespace=5

if exists('g:neovide')
	" NOTE: Neovide doesn't render "PragmataPro Mono" correctly, for some reason
	set guifont=PragmataPro\ Mono\ Liga:h22

    let g:neovide_theme = 'auto'
    let g:neovide_input_macos_option_key_is_meta = 'both'
    let g:neovide_cursor_animation_length = 0
endif

" Character reference:
" │ ┊
" ╱
" 🮮 🮤 🮦
" ➤ ▷ ▶ ▹ ▸
" ↪ └
" ࿁ ⚬ ◌
" ▢ ⬚ ▫
" ⁺ ₊ ˖
" 🞩
" ┘ ʴ ˼ ↵
