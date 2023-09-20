" Ex command typing helpers
" ============================================================================

" Partial
" ----------------------------------------------------------------------------
nnoremap <unique>          <leader>g        :sil gr!  <Bar> cw<S-Left><S-Left><Left>

nnoremap <unique>          <leader>rr       :redi @r <Bar> sil  <Bar> redi END<S-Left><S-Left><S-Left><Left>

nnoremap <unique>          <leader>t        :tab<C-z><C-p>

nnoremap <unique>          <leader>/        :mat Match //<Left>

" TODO
" nnoremap <unique>          <leader>?        :echo "p = full path\nh = head\nt = tail"<CR>:let @* = expand('%:')<Left><Left>

" Complete
" ----------------------------------------------------------------------------
nnoremap <unique> <silent> <CR>             :cal vimrc#maybe_toggle_fold()<CR>

nnoremap          <silent> <C-l>            :cal vimrc#redraw_screen()<CR>

nnoremap <unique> <silent> <leader>x        :ContextToggleWindow<CR>

nnoremap <unique> <silent> <leader>c        :ColorizerToggle<CR>

nnoremap <unique> <silent> <leader>h        :cal vimrc#echo_highlight_info()<CR>

nnoremap <unique> <silent> <leader>n        :noh <Bar> call HighlightLineBeforeLatestJumpStop()<CR>

nnoremap <unique> <silent> <leader>m        :cal vimrc#mru_dirvish()<CR>

nnoremap <unique> <silent> <leader>o        :!open '%:h'<CR><CR>

nnoremap <unique> <silent> <leader>s        :Git<CR>

nnoremap <unique> <silent> <leader>j        :ju<CR>

nnoremap <unique> <silent> <leader>w        :up<CR>

" TODO
" nnoremap <unique>          <leader>?        :%!npx --quiet prettier --stdin-filepath %<CR>

call vimrc#create_toggle_maps('a', '&formatoptions=~"a"'         , 'setl fo-=a'    , 'setl fo+=a')
call vimrc#create_toggle_maps('b', '&scrollbind'                 , 'setl noscb'    , 'setl scb')
call vimrc#create_toggle_maps('c', '&cursorcolumn'               , 'setl nocuc'    , 'setl cuc')
call vimrc#create_toggle_maps('f', '&foldopen=="all"'            , 'setl fdo& fcl&', 'setl fdo=all fcl=all')
call vimrc#create_toggle_maps('l', '&list'                       , 'setl nolist'   , 'setl list')
call vimrc#create_toggle_maps('n', '&number'                     , 'setl nonu'     , 'setl nu')
call vimrc#create_toggle_maps('r', '&relativenumber'             , 'setl nornu'    , 'setl rnu')
call vimrc#create_toggle_maps('s', '&spell'                      , 'setl nospell'  , 'setl spell')
call vimrc#create_toggle_maps('t', 'match(&colorcolumn, "+1")>=0', 'setl cc-=+1'   , 'setl cc+=+1')
call vimrc#create_toggle_maps('w', '&wrap'                       , 'setl nowrap'   , 'setl wrap')
call vimrc#create_toggle_maps('d', '&background=="dark"'         , 'set bg=light'  , 'set bg=dark')

" Other
" ============================================================================
nnoremap <unique> <silent> <leader><CR>     <CR>
map      <unique>          _                <Plug>(dirvish_up)

" Yank and Paste Operators/Operations
" ============================================================================
nnoremap <unique>          <leader>y        "*y
xnoremap <unique>          <leader>y        "*y
nmap     <unique>          <leader>Y        "*Y
nnoremap <unique>          <leader>p        "*p
xnoremap <unique>          <leader>p        "*p
nnoremap <unique>          <leader>P        "*P

" Operations
" ============================================================================
nnoremap <unique> <silent> <leader>d        :cal vimrc#define(expand('<cword>'))<CR>
xnoremap <unique> <silent> <leader>d        :<C-u>cal vimrc#define(vimrc#get_selection_text())<CR>

nnoremap <unique> <silent> <leader>b        :cal vimrc#browse(expand('<cword>'))<CR>
xnoremap <unique> <silent> <leader>b        :<C-u>cal vimrc#browse(vimrc#get_selection_text())<CR>

let g:say_speed = 250
nnoremap <unique> <silent> <leader><Left>   :let g:say_speed -= 50<CR>:echo g:say_speed<CR>
nnoremap <unique> <silent> <leader><Right>  :let g:say_speed += 50<CR>:echo g:say_speed<CR>

" TODO: Move into function
nnoremap <unique> <silent> <leader>k        :execute '.w !say -r ' . g:say_speed<CR><CR>
xnoremap <unique> <silent> <leader>k        :<C-u>execute 'silent !echo ' . shellescape(vimrc#get_selection_text(), 1) . ' <Bar> say -r ' . g:say_speed<CR>

nnoremap <unique> <silent> <leader>i        :cal vimrc#read_aloud(getline('.'))<CR>
xnoremap <unique> <silent> <leader>i        :<C-u>cal vimrc#read_aloud(vimrc#get_selection_text())<CR>

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
