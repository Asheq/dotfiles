let s:goyo = 0

function! goyo#execute()
    if s:goyo
        call s:goyo_off()
        let s:goyo = 0
    else
        call s:goyo_on()
        let s:goyo = 1
    endif
endfunction

function! s:goyo_off()
    let &cursorline = s:cursorline
    let &colorcolumn = s:colorcolumn
    let &conceallevel = s:conceallevel
    let &foldcolumn = s:foldcolumn
    let &laststatus = s:laststatus
    let &list = s:list
    let &number = s:number
    let &relativenumber = s:relativenumber
    let &ruler = s:ruler
    let &showtabline = s:showtabline
    let &spell = s:spell

    " Make EndOfBuffer tildes visible again
    highlight! link EndOfBuffer LineNr
endfunction

function! s:goyo_on()
    let s:cursorline = &cursorline
    let s:colorcolumn = &colorcolumn
    let s:conceallevel = &conceallevel
    let s:foldcolumn = &foldcolumn
    let s:laststatus = &laststatus
    let s:list = &list
    let s:number = &number
    let s:relativenumber = &relativenumber
    let s:ruler = &ruler
    let s:showtabline = &showtabline
    let s:spell = &spell

    set nocursorline
    set colorcolumn-=+1
    set conceallevel=3
    set foldcolumn=9
    set laststatus=0
    set nolist
    set nonumber
    set norelativenumber
    set noruler
    set showtabline=0
    set nospell

    " Make EndOfBuffer tildes invisible
    let bg = synIDattr(synIDtrans(hlID("Normal")), "bg#")
    if bg == -1 || empty(bg)
        highlight EndOfBuffer guifg='black'
    else
        highlight EndOfBuffer guifg=bg
    endif
endfunction
