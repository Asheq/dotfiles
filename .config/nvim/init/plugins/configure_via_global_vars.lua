-- Some plugins are configured via global variables set before the plugin is
-- loaded.
--
-- This method pollutes the global namespace, so it is not preferred. However,
-- some plugins only support configuration this way.
-- ============================================================================

-- markdown
vim.g.markdown_folding = 1

-- vim-indentwise
vim.g.indentwise_suppress_keymaps = 1

-- vim-sandwich
-- TODO-L: Add sandwich text objects without clobbering default as/is
vim.g.textobj_sandwich_no_default_key_mappings = 1

-- copilot.vim
vim.g.copilot_no_tab_map = true

-- markdown-preview.nvim
vim.cmd([[
  function! OpenMarkdownPreview(url)
    call v:lua.require('system_calls').open_url_in_firefox(a:url)
  endfunction
]])

vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
