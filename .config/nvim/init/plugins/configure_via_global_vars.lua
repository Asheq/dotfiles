-- Some plugins are configured via global variables set before the plugin is
-- loaded. This pollutes the global namespace, but some plugins only support
-- configuration this way.
-- ============================================================================

-- markdown
vim.g.markdown_folding = 1

-- indentwise
vim.g.indentwise_suppress_keymaps = 1

-- sandwich
-- TODO-L: Add sandwich text objects without clobbering default as/is
vim.g.textobj_sandwich_no_default_key_mappings = 1

-- copilot
vim.g.copilot_no_tab_map = true

-- markdown-preview
vim.cmd([[
  function! OpenMarkdownPreview(url)
    call v:lua.require("system_calls").open_url_in_firefox(a:url, { "new_window": v:true })
  endfunction
]])

vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
