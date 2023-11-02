" Ex command typing helpers
" ============================================================================

" Partial
" ----------------------------------------------------------------------------
nnoremap          <leader>g        :sil gr!  <Bar> tab cw<S-Left><S-Left><S-Left><Left>

nnoremap          <leader>rr       :redi @r <Bar> sil  <Bar> redi END<S-Left><S-Left><S-Left><Left>

nnoremap          <leader>t        :tab<C-z><C-p>

nnoremap          <leader>/        :mat Match //<Left>

nnoremap          yp               :echo "p = full path\nh = head\nt = tail"<Enter>:let @* = expand('%:')<Left><Left>

" Complete
" ----------------------------------------------------------------------------
nnoremap <silent> <C-g>            :echo vimrc#better_ctrl_g()<Enter>

nnoremap <silent> <Enter>          :cal vimrc#maybe_toggle_fold()<Enter>

nnoremap <silent> <leader>h        :cal vimrc#echo_highlight_info()<Enter>

nnoremap <silent> <leader>n        :noh<Enter>

nnoremap <silent> <leader>m        :cal vimrc#mru_dirvish()<Enter>

nnoremap <silent> <leader>o        :!open '%:h'<Enter><Enter>

nnoremap <silent> <leader>s        :Git<Enter>

nnoremap <silent> <leader>j        :ju<Enter>

nnoremap <silent> <leader>w        :up<Enter>

" TODO-L: Remove
" nnoremap          <leader>?        :%!npx --quiet prettier --stdin-filepath %<Enter>

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
nnoremap          <leader>y        "*y
xnoremap          <leader>y        "*y
nmap              <leader>Y        "*Y
nnoremap          <leader>p        "*p
xnoremap          <leader>p        "*p
nnoremap          <leader>P        "*P

" Other
" ----------------------------------------------------------------------------
nnoremap <silent> <leader><Enter>  <Enter>
map               _                <Plug>(dirvish_up)

" Text Operations
" ============================================================================
nnoremap <silent> <leader>d        :cal vimrc#define(expand('<cword>'))<Enter>
xnoremap <silent> <leader>d        :<C-u>cal vimrc#define(vimrc#get_selection_text())<Enter>

nnoremap <silent> <leader>b        :cal vimrc#browse(expand('<cword>'))<Enter>
xnoremap <silent> <leader>b        :<C-u>cal vimrc#browse(vimrc#get_selection_text())<Enter>

let g:say_speed = 250
nnoremap <silent> <leader><Left>   :let g:say_speed -= 50<Enter>:echo g:say_speed<Enter>
nnoremap <silent> <leader><Right>  :let g:say_speed += 50<Enter>:echo g:say_speed<Enter>

nnoremap <silent> <leader>k        :execute 'silent .w !say -r ' . g:say_speed<Enter>
xnoremap <silent> <leader>k        :<C-u>execute 'silent !echo ' . shellescape(vimrc#get_selection_text(), 1) . ' <Bar> say -r ' . g:say_speed<Enter>

nnoremap <silent> <leader>i        :cal vimrc#read_aloud(getline('.'))<Enter>
xnoremap <silent> <leader>i        :<C-u>cal vimrc#read_aloud(vimrc#get_selection_text())<Enter>

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
