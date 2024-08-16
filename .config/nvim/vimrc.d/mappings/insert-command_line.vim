" Easier :vert and :tab command modifiers
cabbrev         v     vert
cabbrev         t     tab

" Insert date or date-time
inoremap <expr> <A-d> strftime('%Y-%m-%d')
inoremap <expr> <A-t> strftime('%Y-%m-%dT%TZ')
