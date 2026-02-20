-- Some plugins are configured by calling their setup() function after the
-- plugin is loaded.
-- ============================================================================

require("oil").setup({
	default_file_explorer = true,
	view_options = {
		show_hidden = true,
		is_always_hidden = function(name)
			local hidden = { [".DS_Store"] = true, [".."] = true, [".tmp.driveupload"] = true }
			return hidden[name] or name:find("^Icon.$") ~= nil
		end,
	},
	use_default_keymaps = true,
	keymaps = {
		["<C-l>"] = false,
		["gs"] = { "actions.refresh", mode = "n" }, -- Mnemonic: get started
		["cs"] = { "actions.change_sort", mode = "n" }, -- Mnemonic: change sort
	},
})

require("snacks").setup({
	picker = { enabled = true },
})

require("CopilotChat").setup({
	mappings = {
		reset = {
			normal = "gs", -- Mnemonic: get started
			insert = "",
		},
		accept_diff = {
			normal = "yd", -- Mnemonic: yes diff
			insert = "",
		},
		jump_to_diff = {
			normal = "",
			insert = "",
		},
	},
})
