" Expand v and t to vert and tab in command-line mode
cabbrev         v     vert
cabbrev         t     tab

" Insert date or date-time
inoremap <expr> <A-d> strftime('%Y-%m-%d')
inoremap <expr> <A-t> strftime('%Y-%m-%dT%TZ')

" Accept Copilot suggestions
inoremap <expr> <C-a>              copilot#Accept("")
inoremap        <C-q>              <Plug>(copilot-accept-line)
inoremap        <C-z>              <Plug>(copilot-accept-word)

" Unused/duplicate keys (* = used in mapping already, ! = do not map or map to self only)
"   Insert-mode
"       <C-a>*
"       <BS>! <C-h>
"       <Tab>! <C-i>
"       <Enter>! <C-j>* <C-m>
"       <C-v>! <C-q>
"       <C-l>
