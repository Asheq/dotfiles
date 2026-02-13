" Expand v and t to vert and tab in command-line mode
cabbrev         v     vert
cabbrev         t     tab

" Insert date or date-time
inoremap <expr> <A-d> strftime('%Y-%m-%d')
inoremap <expr> <A-t> strftime('%Y-%m-%dT%TZ')

" Accept Copilot suggestions
inoremap <expr> <C-a> copilot#Accept("")
inoremap        <C-q> <Plug>(copilot-accept-line)
inoremap        <C-z> <Plug>(copilot-accept-word)
