-- Neovim has several optional built-in plugins located in
-- $VIMRUNTIME/pack/dist/opt/
--
-- These are not loaded automatically. You must explicitly load them using
-- :packadd {plugin-name} if you want to use them.
--
-- Note that "matchit" is special; it is automatically loaded indirectly by
-- $VIMRUNTIME/plugin/matchit.vim which runs on startup.
-- ============================================================================

-- Load cfilter
vim.cmd("packadd cfilter")
