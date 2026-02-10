set guifont=PragmataPro\ Mono:h22
set linespace=5

if exists('g:neovide')
	" NOTE: Neovide doesn't render "PragmataPro Mono" correctly, for some reason
	set guifont=PragmataPro\ Mono\ Liga:h22

    let g:neovide_theme = 'auto'
    let g:neovide_input_macos_option_key_is_meta = 'both'
    let g:neovide_cursor_animation_length = 0
endif
