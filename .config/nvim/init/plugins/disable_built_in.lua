-- Neovim has several built-in plugins located in $VIMRUNTIME/plugin/ that are
-- automatically loaded on startup.
--
-- To prevent multiple loads, each plugin has a guard clause at the top of its
-- main script that checks the value of the variable g:loaded_xxx, where xxx is
-- the name of the plugin. If the value is 1, the rest of the script does not
-- execute.
--
-- Thus, setting the variable to 1 here prevents the plugin code from executing
-- even once.
-- ============================================================================

-- Do not load netrw
vim.g.loaded_netrwPlugin = 1

-- Do not load matchit and matchparen. They are both replaced with
-- andymass/vim-matchup.
-- vim.g.loaded_matchit = 1
-- vim.g.loaded_matchparen = 1
