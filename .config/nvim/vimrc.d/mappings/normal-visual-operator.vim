" Ex command typing helpers
" ============================================================================

" Partial
" ----------------------------------------------------------------------------
nnoremap          <leader>g        :sil gr!  <Bar> tab cw<S-Left><S-Left><S-Left><Left>

nnoremap          <leader>r        :redi @r <Bar> sil  <Bar> redi END<S-Left><S-Left><S-Left><Left>

nnoremap          <leader>t        :tab<C-z><C-p>

nnoremap          <leader>/        :mat Match //<Left>

nnoremap          yp               :ec "p = full path\nh = head\nt = tail"<Enter>:let @* = expand('%:')<Left><Left>

" Complete
" ----------------------------------------------------------------------------
nnoremap <silent> <leader>o        :sil !open '%:h'<Enter><Enter>

nnoremap <silent> <leader>s        :sil Git<Enter>

nnoremap <silent> <leader>w        :sil up<Enter>

nnoremap <silent> <leader>h        :cal vimrc#echo_highlight_info()<Enter>

nnoremap <silent> <leader>j        :ju<Enter>

nnoremap <silent> <leader>c        :changes<Enter>

nnoremap <silent> <C-g>            :cal vimrc#ctrl_g_with_scrollbar()<Enter>

" This copies the selected text into the system clipboard as rich text so that
" when it's pasted in certain applications, the application shows the
" formatted text rather than the raw text.
xnoremap  <silent> <leader>c       :w !pandoc --from markdown --to html <Bar> textutil -stdin -format html -convert rtf -stdout <Bar> pbcopy<Enter><Enter>

" Normal and visual mode command typing helpers
" ============================================================================

" Yank and Paste
" ----------------------------------------------------------------------------
nnoremap          <leader>y        "*y
nmap              <leader>Y        "*Y
xnoremap          <leader>y        "*y

nnoremap          <leader>p        "*p
nnoremap          <leader>P        "*P
xnoremap          <leader>p        "*p

nnoremap          <C-h>            `[v`]

" Move up and down through wrapped lines
" ----------------------------------------------------------------------------
noremap           j                gj
noremap           k                gk
noremap           gj               j
noremap           gk               k

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
map               [a               <Plug>(IndentWiseBlockScopeBoundaryBegin)
map               ]a               <Plug>(IndentWiseBlockScopeBoundaryEnd)

map               <A-h>            <Plug>(IndentWisePreviousLesserIndent)
map               <A-l>            <Plug>(IndentWiseNextGreaterIndent)

"map               <A-k>            <Plug>(IndentWisePreviousEqualIndent)
"map               <A-j>            <Plug>(IndentWiseNextEqualIndent)
nnoremap <silent>  <A-j>            :call navigate_block#down()<CR>
nnoremap <silent>  <A-k>            :call navigate_block#up()<CR>

" Duplicate keys (* = used in mapping already, ! = do not map or map to self only)
"   Normal-mode
"       h! <Left>* CTRL-H* <BS>*
"       l! <Right>* <Space>*
"       j! <Down> CTRL-J CTRL-N*
"       k! <Up> CTRL-P*
"       <Return>! + CTRL-M
"       cc! S
"   Visual-mode(char)
"       d! x
"       D! X
"       c! s*
"       C! S
"   Visual-mode (line)
"       d! x X D
"       c! s*
"       C! S
"   Visual-mode (block)
"       d! x X
"       c! s*
