local util = require("util")
local ks_group = util.ks_group

-- Expand v to vert and t to tab in command-line mode
vim.cmd([[
  cabbrev v vert
  cabbrev t tab
]])

-- Insert date or date-time
ks_group({
	{ "i", "<A-d>", function() return vim.fn.strftime("%Y-%m-%d") end,     { expr = true } },
	{ "i", "<A-t>", function() return vim.fn.strftime("%Y-%m-%dT%TZ") end, { expr = true } }
})

-- Accept Copilot suggestions
ks_group({
	{ "i", "<C-a>", "copilot#Accept('')",          { expr = true, replace_keycodes = false, silent = true } },
	{ "i", "<C-s>", "<Plug>(copilot-accept-word)", { remap = true } },
	{ "i", "<C-z>", "<Plug>(copilot-accept-line)", { remap = true } }
})
