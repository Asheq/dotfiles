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
	background = {
		light = "latte",
		dark = "frappe",
	},
	transparent_background = true,
	highlight_overrides = {
		all = function(C)
			local U = require("catppuccin.utils.colors")
			return {
				MatchParen       = { bg = C.none, style = { "bold" } },
				Visual           = { bg = U.darken(C.peach, 0.18, C.base), style = {} },

				-- Diff*
				DiffChange       = { bg = U.darken(C.mauve, 0.15, C.base), style = {} },
				DiffText         = { bg = U.darken(C.mauve, 0.30, C.base), style = {} },

				-- Coc*
				CocHighlightText = { bg = U.darken(C.red, 0.30, C.base), style = {} },

				-- StatusLine*
				-- NOTE: I can probably remove these when I add mini.statusline
				StatusLineNC     = { bg = C.subtext0, fg = C.surface2, style = { "italic" } },
				StatusLine       = { bg = C.text, fg = C.crust, style = {} },
			}
		end,
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
