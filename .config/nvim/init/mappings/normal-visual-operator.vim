" Operate on Text
" ============================================================================
" View definition
nnoremap <silent>       <leader>d        :cal vimrc#define(expand('<cword>'))<Enter>
xnoremap <silent>       <leader>d        :<C-u>cal vimrc#define(vimrc#get_selection_text())<Enter>

" View browser search
nnoremap <silent>       <leader>b        :cal vimrc#browse(expand('<cword>'))<Enter>
xnoremap <silent>       <leader>b        :<C-u>cal vimrc#browse(vimrc#get_selection_text())<Enter>

" Change speech rate
let g:say_speed = 250
nnoremap <silent>       <leader><Left>   :let g:say_speed -= 50<Enter>:echo g:say_speed<Enter>
nnoremap <silent>       <leader><Right>  :let g:say_speed += 50<Enter>:echo g:say_speed<Enter>

" Read aloud
nnoremap <silent>       <leader>k        :execute 'silent .w !say -r ' . g:say_speed<Enter>
xnoremap <silent>       <leader>k        :<C-u>execute 'silent !echo ' . shellescape(vimrc#get_selection_text(), 1) . ' <Bar> say -r ' . g:say_speed<Enter>

" Read aloud and highlight text
nnoremap <silent>       <leader>i        :cal vimrc#read_aloud(getline('.'))<Enter>
xnoremap <silent>       <leader>i        :<C-u>cal vimrc#read_aloud(vimrc#get_selection_text())<Enter>

" Copy markdown text as rich text into system clipboard
nnoremap  <silent>      <leader>m        :w !pandoc --from markdown --to html <Bar> textutil -stdin -format html -convert rtf -stdout <Bar> pbcopy<Enter><Enter>
xnoremap  <silent>      <leader>m        :%w !pandoc --from markdown --to html <Bar> textutil -stdin -format html -convert rtf -stdout <Bar> pbcopy<Enter><Enter>

" Move
" ============================================================================
map                     [a               <Plug>(IndentWiseBlockScopeBoundaryBegin)
map                     ]a               <Plug>(IndentWiseBlockScopeBoundaryEnd)

map                     <A-h>            <Plug>(IndentWisePreviousLesserIndent)
map                     <A-l>            <Plug>(IndentWiseNextGreaterIndent)

map                     <A-j>            <Plug>(NavigateBlockDown)
map                     <A-k>            <Plug>(NavigateBlockUp)
