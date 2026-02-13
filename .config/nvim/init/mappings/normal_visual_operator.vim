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
