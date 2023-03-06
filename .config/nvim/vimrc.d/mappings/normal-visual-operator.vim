" Ex command typing helpers
" ============================================================================

" Partial
" ----------------------------------------------------------------------------
nnoremap          <leader>g       :sil gr!  <Bar> cw<S-Left><S-Left><Left>

nnoremap          <leader>rr       :redi @r <Bar> sil  <Bar> redi END<S-Left><S-Left><S-Left><Left>

nnoremap          <leader>t        :tab<C-z><C-p>

nnoremap          <leader>y        "*y
xnoremap          <leader>y        "*y

nnoremap          <leader>/        :mat Match //<Left>

" TODO
" nnoremap          <leader>?        :echo "p = full path\nh = head\nt = tail"<CR>:let @* = expand('%:')<Left><Left>

" Complete
" ----------------------------------------------------------------------------
nnoremap <silent> <CR>             :cal vimrc#maybe_toggle_fold()<CR>

nnoremap <silent> <leader><CR>     <CR>

nnoremap <silent> <C-l>            :cal vimrc#redraw_screen()<CR>

nnoremap <silent> <leader>h        :cal vimrc#echo_highlight_info()<CR>

nnoremap <silent> <leader>n        :noh<CR>

nnoremap <silent> <leader>m        :cal vimrc#mru_dirvish()<CR>

nnoremap <silent> <leader>o        :!open '%:h'<CR><CR>

nnoremap <silent> <leader>s        :Git<CR>

nnoremap <silent> <leader>j        :ju<CR>

nnoremap <silent> <leader>w        :up<CR>

nnoremap          <leader>p        "*p
xnoremap          <leader>p        "*p

" TODO
" nnoremap          <leader>?        :%!npx --quiet prettier --stdin-filepath %<CR>

map               _                <Plug>(dirvish_up)

nnoremap          yr               :Use co
call              vimrc#create_toggle_maps('a', '&formatoptions=~"a"'         , 'setl fo-=a'    , 'setl fo+=a')
call              vimrc#create_toggle_maps('b', '&scrollbind'                 , 'setl noscb'    , 'setl scb')
call              vimrc#create_toggle_maps('c', '&cursorcolumn'               , 'setl nocuc'    , 'setl cuc')
call              vimrc#create_toggle_maps('f', '&foldopen=="all"'            , 'setl fdo& fcl&', 'setl fdo=all fcl=all')
call              vimrc#create_toggle_maps('l', '&list'                       , 'setl nolist'   , 'setl list')
call              vimrc#create_toggle_maps('n', '&number'                     , 'setl nonu'     , 'setl nu')
call              vimrc#create_toggle_maps('r', '&relativenumber'             , 'setl nornu'    , 'setl rnu')
call              vimrc#create_toggle_maps('s', '&spell'                      , 'setl nospell'  , 'setl spell')
call              vimrc#create_toggle_maps('t', 'match(&colorcolumn, "+1")>=0', 'setl cc-=+1'   , 'setl cc+=+1')
call              vimrc#create_toggle_maps('w', '&wrap'                       , 'setl nowrap'   , 'setl wrap')
call              vimrc#create_toggle_maps('d', '&background=="dark"'         , 'set bg=light'  , 'set bg=dark')

" Operations
" ============================================================================
nnoremap <silent> <leader>d        :cal vimrc#define(expand('<cword>'))<CR>
xnoremap <silent> <leader>d        :<C-u>cal vimrc#define(vimrc#get_selection_text())<CR>

nnoremap <silent> <leader>b        :cal vimrc#browse(expand('<cword>'))<CR>
xnoremap <silent> <leader>b        :<C-u>cal vimrc#browse(vimrc#get_selection_text())<CR>

" Motions
" ============================================================================
map               [b               <Plug>(IndentWisePreviousLesserIndent)
map               ]b               <Plug>(IndentWiseNextLesserIndent)

map               [w               <Plug>(IndentWisePreviousGreaterIndent)
map               ]w               <Plug>(IndentWiseNextGreaterIndent)

map               [v               <Plug>(IndentWisePreviousEqualIndent)
map               ]v               <Plug>(IndentWiseNextEqualIndent)

map               [a               <Plug>(IndentWiseBlockScopeBoundaryBegin)
map               ]a               <Plug>(IndentWiseBlockScopeBoundaryEnd)
