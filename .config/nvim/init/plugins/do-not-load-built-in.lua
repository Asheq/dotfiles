-- Neovim has several built-in plugins located in $VIMRUNTIME/plugin/ that are
-- automatically loaded on startup.
--
-- Each plugin has a guard clause in its script to prevent multiple loads by
-- setting a g:loaded_xxx variable.
--
-- Setting this guard variable to 1 here prevents the plugin from loading even
-- once.
-- ============================================================================

-- Do not load netrw.
-- Replace with oil.nvim. Note that oil.nvim does this itself as well.
vim.g.loaded_netrwPlugin = 1

-- Do not load matchit and matchparen.
-- Replace both with just andymass/vim-matchup.
-- vim.g.loaded_matchit = 1
-- vim.g.loaded_matchparen = 1
