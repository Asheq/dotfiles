-- Some plugins are configured via their setup() function called after the
-- plugin is loaded. This setup call is a common pattern in modern Neovim
-- plugins.
-- ============================================================================

-- oil.nvim
local oil_loaded, oil = pcall(require, "oil")
if oil_loaded then
	oil.setup({
		default_file_explorer = true,
		view_options = {
			show_hidden = true,
			is_always_hidden = function(name)
				local list = { ".DS_Store", "..", ".tmp.driveupload" }
				for _, value in ipairs(list) do
					if name == value then
						return true
					end
				end

				if name:find("^Icon.$") ~= nil then
					return true
				end

				return false
			end,
		},
		use_default_keymaps = false,
		keymaps = {
			["g?"] = { "actions.show_help", mode = "n" },
			["<CR>"] = "actions.select",
			["<C-s>"] = { "actions.select", opts = { vertical = true } },
			["<C-h>"] = { "actions.select", opts = { horizontal = true } },
			["<C-t>"] = { "actions.select", opts = { tab = true } },
			["<C-p>"] = "actions.preview",
			["<C-c>"] = { "actions.close", mode = "n" },
			["-"] = { "actions.parent", mode = "n" },
			["_"] = { "actions.open_cwd", mode = "n" },
			["`"] = { "actions.cd", mode = "n" },
			["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
			["gx"] = "actions.open_external",
			["g."] = { "actions.toggle_hidden", mode = "n" },
			["g\\"] = { "actions.toggle_trash", mode = "n" },
			-- ["<C-l>"] = "actions.refresh",
			["gs"] = { "actions.refresh", mode = "n" }, -- Mnemonic: get started
			-- ["gs"] = { "actions.change_sort", mode = "n" },
			["cs"] = { "actions.change_sort", mode = "n" }, -- Mnemonic: change sort
		},
	})
end

-- snacks.nvim
local snacks_loaded, snacks = pcall(require, "snacks")
if snacks_loaded then
	snacks.setup({
		picker = { enabled = true },
	})
end

-- CopilotChat.nvim
local CopilotChat_loaded, CopilotChat = pcall(require, "CopilotChat")
if CopilotChat_loaded then
	CopilotChat.setup({
		mappings = {
			reset = {
				normal = "gs", -- " Mnemonic: get started "
				insert = "",
			},
			accept_diff = {
				normal = "yd", -- " Mnemonic: yes diff "
				insert = "",
			},
		},
	})
end
