" Easier :vert and :tab command modifiers
cabbrev         v     vert
cabbrev         t     tab

" Insert date or date-time
inoremap <expr> <M-d> strftime('%Y-%m-%d')
inoremap <expr> <M-t> strftime('%Y-%m-%dT%TZ')
