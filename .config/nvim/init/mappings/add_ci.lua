local ks = vim.keymap.set

-- Expand v to vert and t to tab in command-line mode
vim.cmd([[
  cabbrev v vert
  cabbrev t tab
]])

-- Insert date or date-time
ks("i", "<A-d>", function()
	return vim.fn.strftime("%Y-%m-%d")
end, { expr = true })
ks("i", "<A-t>", function()
	return vim.fn.strftime("%Y-%m-%dT%TZ")
end, { expr = true })

-- Accept Copilot suggestions
ks("i", "<C-;>", "copilot#Accept('')", {
	expr = true,
	replace_keycodes = false
})
ks("i", "<C-.>", "<Plug>(copilot-accept-word)", { remap = true })
ks("i", "<C-,>", "<Plug>(copilot-accept-line)", { remap = true })
