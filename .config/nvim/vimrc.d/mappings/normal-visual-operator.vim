" Ex command typing helpers
" ============================================================================

" Partial
" ----------------------------------------------------------------------------
nnoremap          <leader>g        :sil gr!  <Bar> tab cw<S-Left><S-Left><S-Left><Left>

nnoremap          <leader>r        :redi @r <Bar> sil  <Bar> redi END<S-Left><S-Left><S-Left><Left>

nnoremap          <leader>t        :tab<C-z><C-p>

nnoremap          <leader>c        :CopilotChat<C-z><C-p>
xnoremap          <leader>c        :CopilotChat<C-z><C-p>

nnoremap          <leader>/        :mat Match //<Left>
xnoremap          <leader>/        :mat Match //<Left>

nnoremap          yp               :ec "p = full path\nh = head\nt = tail"<Enter>:let @* = expand('%:')<Left><Left>

" Complete
" ----------------------------------------------------------------------------
nnoremap <silent> <leader>V        'V:exe 'help ' . expand('%:t')<Enter>'V

nnoremap <silent> <C-f>            @=winheight(0) - 1 . "\<lt>C-e>"<Return>
nnoremap <silent> <C-b>            @=winheight(0) - 1 . "\<lt>C-y>"<Return>

nnoremap <silent> <C-d>            @=winheight(0) / 2 - 1 . "\<lt>C-e>"<Return>
nnoremap <silent> <C-u>            @=winheight(0) / 2 - 1 . "\<lt>C-y>"<Return>

nnoremap <silent> <leader>o        :sil !open '%:h'<Enter><Enter>

nnoremap <silent> <leader>s        :sil Git<Enter>

nnoremap <silent> <leader>w        :sil up<Enter>

nnoremap <silent> <leader>h        :Inspect<Enter>

nnoremap <silent> <leader>j        :ju<Enter>

nnoremap <silent> <C-g>            :cal vimrc#ctrl_g_with_scrollbar()<Enter>

" Copy markdown text as rich text into system clipboard
nnoremap  <silent> <leader>m       :w !pandoc --from markdown --to html <Bar> textutil -stdin -format html -convert rtf -stdout <Bar> pbcopy<Enter><Enter>
xnoremap  <silent> <leader>m       :%w !pandoc --from markdown --to html <Bar> textutil -stdin -format html -convert rtf -stdout <Bar> pbcopy<Enter><Enter>

" nnoremap <silent> <leader>c        :changes<Enter>

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

map               <A-j>            <Plug>(NavigateBlockDown)
map               <A-k>            <Plug>(NavigateBlockUp)

" Duplicate keys (* = used in mapping already, ! = do not map or map to self only)
"   Normal-mode
"       h! <Left>* <C-h>* <BS>*
"       l! <Right>* <Space>*
"       j! <Down> <C-j> <C-n>*
"       k! <Up> <C-p>*
"       <Return>! + <C-m>
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
