" Ex command typing helpers
" ============================================================================

" Partial
" ----------------------------------------------------------------------------
nnoremap          <leader>g        :sil gr!  <Bar> tab cw<S-Left><S-Left><S-Left><Left>

nnoremap          <leader>r        :redi @r <Bar> sil  <Bar> redi END<S-Left><S-Left><S-Left><Left>

nnoremap          <leader>t        :tab<C-z><C-p>

nnoremap          <leader>/        :mat Match //<Left>

nnoremap          yp               :echo "p = full path\nh = head\nt = tail"<Enter>:let @* = expand('%:')<Left><Left>

" Complete
" ----------------------------------------------------------------------------
nnoremap <silent> <C-g>            :cal vimrc#better_ctrl_g()<Enter>

nnoremap <silent> <leader>h        :cal vimrc#echo_highlight_info()<Enter>

nnoremap <silent> <leader>j        :ju<Enter>

nnoremap <silent> <leader>c        :changes<Enter>

nnoremap <silent> <leader>o        :!open '%:h'<Enter><Enter>

nnoremap <silent> <leader>s        :Git<Enter>

nnoremap <silent> <leader>w        :up<Enter>

" Normal mode command typing helpers
" ============================================================================

" Yank and Paste
" ----------------------------------------------------------------------------
nnoremap          <leader>y        "*y
nmap              <leader>Y        "*Y
nnoremap          <leader>p        "*p
nnoremap          <leader>P        "*P

xnoremap          <leader>y        "*y
xnoremap          <leader>p        "*p

nnoremap          <C-h>            `[v`]

" Move up and down through wrapped lines
" ----------------------------------------------------------------------------
nnoremap          j                gj
nnoremap          k                gk
nnoremap          gj               j
nnoremap          gk               k

" Make half-page scrolling less disorienting
" ----------------------------------------------------------------------------
if exists('g:neovide')
    nnoremap <silent> <C-d>            Lzz
    nnoremap <silent> <C-u>            Hzz
else
    nnoremap <silent> <C-d>            L:sleep 200m<CR>zz
    nnoremap <silent> <C-u>            H:sleep 200m<CR>zz
endif

" NOTE: I could make it work with [count], but it's probably not worth it

"" Make full-page scrolling less disorienting
"" ----------------------------------------------------------------------------
"nnoremap <expr>   <C-f>            winheight(0) - 1 . "<C-e>"
"nnoremap <expr>   <C-b>            winheight(0) - 1 . "<C-y>"
"
"" Make it work with [count]
"nnoremap <silent> <C-f>            @=winheight(0) - 1 . "\<lt>C-e>"<CR>
"nnoremap <silent> <C-b>            @=winheight(0) - 1 . "\<lt>C-y>"<CR>

" Fold
" ----------------------------------------------------------------------------
nnoremap          <Left>           zc
nnoremap          <S-Left>         zC
nnoremap          <Right>          zo
nnoremap          <S-Right>        zO

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
