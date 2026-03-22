# Maintenance Commands

- `brew upgrade neovim` - Update Neovim to the latest version using `Homebrew`
- `:PlugClean` - Remove unused plugins
- `:PlugInstall` - Install plugins
- `:PlugUpdate` - Update plugins
- `:CocUpdate` - Update CoC extensions
- `:TSUpdate` - Update Treesitter parsers

# Notes

- `grepprg` and `grepformat` control how the quickfix/location list is populated when executing `:grep`/`:lgrep`
- `makeprg` and `errorformat` control how the quickfix/location list is populated when executing `:make`/`:lmake`
- Many names of concepts, commands, and options are legacy; better names would be:
    - Make -> Run
        - `makeprg` -> `runprg`
        - `errorformat` -> `runformat`
        - `:make` -> `:run`
        - `:compiler` -> `:runner`
    - QuickFix -> FileLocation
        - "quickfix list" -> "global file location list"
        - "location list" -> "window-local file location list"
