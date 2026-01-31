-- Do not load some built-in plugins that are normally automatically loaded.
-- These plugins are located in $VIMRUNTIME/plugin/.

-- Do not load netrw.
-- Replace with oil.nvim. Note that oil.nvim does this itself as well.
vim.g.loaded_netrwPlugin = 1

-- Do not load matchit and matchparen.
-- Replace both with just andymass/vim-matchup.
-- vim.g.loaded_matchit = 1
-- vim.g.loaded_matchparen = 1
