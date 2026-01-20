local oil_ok, oil = pcall(require, "oil")
if oil_ok then
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
			-- Documentation recommends <C-l> for refresh, but I use the built-in <C-l>.
			-- Thus, I use "gs" for refresh instead.
			-- ["<C-l>"] = "actions.refresh",
			-- ["gs"] = { "actions.change_sort", mode = "n" },
			["gs"] = "actions.refresh",
		},
	})
end

local neogit_ok, neogit = pcall(require, "neogit")
if neogit_ok then
	neogit.setup()
end

local snacks_ok, snacks = pcall(require, "snacks")
if snacks_ok then
	snacks.setup({
		picker = { enabled = true },
	})
end

local CopilotChat_ok, CopilotChat = pcall(require, "CopilotChat")
if CopilotChat_ok then
	CopilotChat.setup(
		{
			mappings = {
				reset = {
					-- Disable default mappings for resetting a chat because I use the built-in <C-l>
					normal = "",
					insert = "",
				},
			},
		}
	)
end

vim.g.copilot_no_tab_map = true

local livepreview_config_ok, livepreview_config = pcall(require, "livepreview.config")
if livepreview_config_ok then
	livepreview_config.set()
end
