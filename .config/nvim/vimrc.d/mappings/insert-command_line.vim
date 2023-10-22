" Easier :vert and :tab command modifiers
cabbrev        v vert
cabbrev        t tab

" Insert date or date-time
iabbrev <expr> ,d strftime('%Y-%m-%d')
iabbrev <expr> ,t strftime('%Y-%m-%dT%TZ')
