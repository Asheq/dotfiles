-- Built-in plugins in $VIMRUNTIME/plugin/ auto-load on startup. Setting
-- g:loaded_xxx = 1 before that happens prevents a plugin from loading.
-- ============================================================================

-- Do not load netrw
vim.g.loaded_netrwPlugin = 1

-- Do not load matchit and matchparen. They are both replaced with
-- andymass/vim-matchup.
-- vim.g.loaded_matchit = 1
-- vim.g.loaded_matchparen = 1
