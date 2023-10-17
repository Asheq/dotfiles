" A vertical version of the :splitfind command
cabbrev        vf vert sf
" TODO-L: Add cabbrev lines for these missing "shortcut helper commands":
" :tabsp[lit]
"
" :vf[ind]
"
" :vta[g]
" :tabta[g]
"
" :ste[rminal]
" :vte[rminal]
" :tabte[rminal]
"
" :vcope[n]
" :tabcope[n]
"
" :vh[elp]
" :tabh[elp]

" Insert date or date-time
iabbrev <expr> ,d strftime('%Y-%m-%d')
iabbrev <expr> ,t strftime('%Y-%m-%dT%TZ')
