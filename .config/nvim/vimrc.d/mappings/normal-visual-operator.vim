" Ex command typing helpers
" ============================================================================

" Partial
" ----------------------------------------------------------------------------
nnoremap          <leader>g       :sil gr!  <Bar> cw<S-Left><S-Left><Left>

nnoremap          <leader>rr       :redi @r <Bar> sil  <Bar> redi END<S-Left><S-Left><S-Left><Left>

nnoremap          <leader>t        :tab<C-z><C-p>

nnoremap          <leader>y        :echo "p = full path\nh = head\nt = tail"<CR>:let @* = expand('%:')<Left><Left>

nnoremap          <leader>/        :mat Match //<Left>

" Complete
" ----------------------------------------------------------------------------
nnoremap          <CR>             za<Cmd>ScrollViewRefresh<CR>


nnoremap <silent> <C-l>            :ScrollViewRefresh<Bar>nohlsearch<Bar>diffupdate<Bar>normal! <C-l><CR>

nnoremap          <leader>w        :up<CR>

nnoremap          <leader>p        :%!npx --quiet prettier --stdin-filepath %<CR>

nnoremap          <leader>s        :Git<CR>

nnoremap          <leader>n        :noh<CR>

nnoremap          <leader>m        :cal vimrc#mru_dirvish()<CR>

nnoremap          <leader>j        :ju<CR>

nnoremap <silent> <leader>h        :cal vimrc#echo_highlight_info()<CR>

map               _                <Plug>(dirvish_up)

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

" Operators
" ============================================================================
" Do not conflict with sandwich's mappings
nmap              s                <Nop>
xmap              s                <Nop>

" Operations
" ============================================================================
nnoremap          <leader>d        :cal vimrc#define(expand('<cword>'))<CR>
xnoremap          <leader>d        :<C-u>cal vimrc#define(vimrc#get_selection_text())<CR>

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
