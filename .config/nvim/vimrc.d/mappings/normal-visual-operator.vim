" Ex command typing helpers
" ============================================================================

" Partial
" ----------------------------------------------------------------------------
nnoremap <unique>          <leader>g        :sil gr!  <Bar> tab cw<S-Left><S-Left><S-Left><Left>

nnoremap <unique>          <leader>rr       :redi @r <Bar> sil  <Bar> redi END<S-Left><S-Left><S-Left><Left>

nnoremap <unique>          <leader>t        :tab<C-z><C-p>

nnoremap <unique>          <leader>/        :mat Match //<Left>

nnoremap <unique>          yp               :echo "p = full path\nh = head\nt = tail"<Enter>:let @* = expand('%:')<Left><Left>

" Complete
" ----------------------------------------------------------------------------
nnoremap <unique> <silent> <C-g>            :echo vimrc#better_ctrl_g()<Enter>

nnoremap <unique> <silent> <Enter>          :cal vimrc#maybe_toggle_fold()<Enter>

nnoremap <unique> <silent> <leader>c        :ColorizerToggle<Enter>

nnoremap <unique> <silent> <leader>h        :cal vimrc#echo_highlight_info()<Enter>

nnoremap <unique> <silent> <leader>n        :noh<Enter>

nnoremap <unique> <silent> <leader>m        :cal vimrc#mru_dirvish()<Enter>

nnoremap <unique> <silent> <leader>o        :!open '%:h'<Enter><Enter>

nnoremap <unique> <silent> <leader>s        :Git<Enter>

nnoremap <unique> <silent> <leader>j        :ju<Enter>

nnoremap <unique> <silent> <leader>w        :up<Enter>

" nnoremap <unique>          <leader>?        :%!npx --quiet prettier --stdin-filepath %<Enter>

" TODO-L: Remove
" nnoremap          <silent> <C-l>            :cal vimrc#redraw_screen()<Enter>

" TODO-L: Remove
" call vimrc#create_toggle_maps('a', '&formatoptions=~"a"'         , 'setl fo-=a'    , 'setl fo+=a')
" call vimrc#create_toggle_maps('b', '&scrollbind'                 , 'setl noscb'    , 'setl scb')
" call vimrc#create_toggle_maps('c', '&cursorcolumn'               , 'setl nocuc'    , 'setl cuc')
" call vimrc#create_toggle_maps('f', '&foldopen=="all"'            , 'setl fdo& fcl&', 'setl fdo=all fcl=all')
" call vimrc#create_toggle_maps('l', '&list'                       , 'setl nolist'   , 'setl list')
" call vimrc#create_toggle_maps('n', '&number'                     , 'setl nonu'     , 'setl nu')
" call vimrc#create_toggle_maps('r', '&relativenumber'             , 'setl nornu'    , 'setl rnu')
" call vimrc#create_toggle_maps('s', '&spell'                      , 'setl nospell'  , 'setl spell')
" call vimrc#create_toggle_maps('t', 'match(&colorcolumn, "+1")>=0', 'setl cc-=+1'   , 'setl cc+=+1')
" call vimrc#create_toggle_maps('w', '&wrap'                       , 'setl nowrap'   , 'setl wrap')
" call vimrc#create_toggle_maps('d', '&background=="dark"'         , 'set bg=light'  , 'set bg=dark')

" Normal mode command typing helpers
" ============================================================================

" Yank and Paste Operators/Operations
" ----------------------------------------------------------------------------
nnoremap <unique>          <leader>y        "*y
xnoremap <unique>          <leader>y        "*y
nmap     <unique>          <leader>Y        "*Y
nnoremap <unique>          <leader>p        "*p
xnoremap <unique>          <leader>p        "*p
nnoremap <unique>          <leader>P        "*P

" Other
" ----------------------------------------------------------------------------
nnoremap <unique> <silent> <leader><Enter>  <Enter>
map      <unique>          _                <Plug>(dirvish_up)

" Text Operations
" ============================================================================
nnoremap <unique> <silent> <leader>d        :cal vimrc#define(expand('<cword>'))<Enter>
xnoremap <unique> <silent> <leader>d        :<C-u>cal vimrc#define(vimrc#get_selection_text())<Enter>

nnoremap <unique> <silent> <leader>b        :cal vimrc#browse(expand('<cword>'))<Enter>
xnoremap <unique> <silent> <leader>b        :<C-u>cal vimrc#browse(vimrc#get_selection_text())<Enter>

let g:say_speed = 250
nnoremap <unique> <silent> <leader><Left>   :let g:say_speed -= 50<Enter>:echo g:say_speed<Enter>
nnoremap <unique> <silent> <leader><Right>  :let g:say_speed += 50<Enter>:echo g:say_speed<Enter>

nnoremap <unique> <silent> <leader>k        :execute '.w !say -r ' . g:say_speed<Enter><Enter>
xnoremap <unique> <silent> <leader>k        :<C-u>execute 'silent !echo ' . shellescape(vimrc#get_selection_text(), 1) . ' <Bar> say -r ' . g:say_speed<Enter>

nnoremap <unique> <silent> <leader>i        :cal vimrc#read_aloud(getline('.'))<Enter>
xnoremap <unique> <silent> <leader>i        :<C-u>cal vimrc#read_aloud(vimrc#get_selection_text())<Enter>

" Motions
" ============================================================================
map <unique>               [b               <Plug>(IndentWisePreviousLesserIndent)
map <unique>               ]b               <Plug>(IndentWiseNextLesserIndent)

map <unique>               [w               <Plug>(IndentWisePreviousGreaterIndent)
map <unique>               ]w               <Plug>(IndentWiseNextGreaterIndent)

map <unique>               [v               <Plug>(IndentWisePreviousEqualIndent)
map <unique>               ]v               <Plug>(IndentWiseNextEqualIndent)

map <unique>               [a               <Plug>(IndentWiseBlockScopeBoundaryBegin)
map <unique>               ]a               <Plug>(IndentWiseBlockScopeBoundaryEnd)
