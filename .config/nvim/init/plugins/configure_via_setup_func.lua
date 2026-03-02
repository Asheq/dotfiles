-- Some plugins are configured by calling their setup() function after the
-- plugin is loaded.
-- ============================================================================

local hidden = {
	[".."] = true,
	[".DS_Store"] = true,
	[".tmp.drivedownload"] = true,
	[".tmp.driveupload"] = true,
	["Icon\r"] = true
}

require("oil").setup({
	default_file_explorer = true,
	view_options = {
		show_hidden = true,
		is_always_hidden = function(name)
			return hidden[name]
		end
	},
	use_default_keymaps = true,
	keymaps = {
		["<C-l>"] = false,
		["gs"] = { "actions.refresh", mode = "n" }, -- Mnemonic: get started
		["cs"] = { "actions.change_sort", mode = "n" } -- Mnemonic: change sort
	}
})

require("snacks").setup({
	picker = {
		enabled = true
	}
})

require("CopilotChat").setup({
	mappings = {
		reset = {
			normal = "gs", -- Mnemonic: get started
			insert = ""
		},
		accept_diff = {
			normal = "yd", -- Mnemonic: yes diff
			insert = ""
		},
		jump_to_diff = { normal = "", insert = "" }
	}
})

require("catppuccin").setup({
	highlight_overrides = {
		all = function(colors)
			return {
				MatchParen = { bg = colors.none, style = { "bold" } },

				-- TODO: Pick better colors for these:
				CocHighlightText = { bg = "red", fg = "black", style = {} },
				Visual = { bg = "orange", fg = "black", style = {} },
				StatusLine = { bg = "darkgreen", fg = "white", style = {} },
				StatusLineNC = { bg = "lightblue", fg = "black", style = {} },
				DiffChange = { bg = "blue", style = {} },
				DiffText = { bg = "purple", style = {} },
			}
		end
	},
	default_integrations = true,
	auto_integrations = true,
	integrations = {
		coc_nvim = true,
		copilot_vim = true,
		treesitter_context = true,
		snacks = {
			enabled = true,
		},
		sandwich = false
	}
})
