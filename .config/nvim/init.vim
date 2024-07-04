" First
source <sfile>:h/vimrc.d/first.vim

" Plugins
source <sfile>:h/vimrc.d/plugins/do-not-load-built-in.vim
source <sfile>:h/vimrc.d/plugins/load-built-in.vim
source <sfile>:h/vimrc.d/plugins/add.vim
source <sfile>:h/vimrc.d/plugins/configure.vim
source <sfile>:h/vimrc.d/plugins/configure-coc.vim

" Mappings
source <sfile>:h/vimrc.d/mappings/normal-visual-operator.vim
source <sfile>:h/vimrc.d/mappings/insert-command_line.vim
source <sfile>:h/vimrc.d/mappings/terminal.vim

" Options
source <sfile>:h/vimrc.d/options.vim

" Final
source <sfile>:h/vimrc.d/final.vim

if filereadable(expand('<sfile>:h') . '/vimrc.d/final.local.vim')
    source <sfile>:h/vimrc.d/final.local.vim
endif
