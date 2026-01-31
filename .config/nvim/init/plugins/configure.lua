-- markdown
vim.g.markdown_folding = 1

-- indentwise
vim.g.indentwise_suppress_keymaps = 1

-- sandwich
-- TODO-L: Add sandwich text objects without clobbering default as/is
vim.g.textobj_sandwich_no_default_key_mappings = 1

-- markdown-preview.nvim
function _G.OpenMarkdownPreview(url)
	vim.fn.jobstart({ "open", "-a", "Firefox", "-n", "--args", "--new-window", url }, { detach = true })
end

vim.cmd([[
  function! OpenMarkdownPreview(url)
    call v:lua.OpenMarkdownPreview(a:url)
  endfunction
]])
vim.g.mkdp_browserfunc = "OpenMarkdownPreview"

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

local snacks_ok, snacks = pcall(require, "snacks")
if snacks_ok then
	snacks.setup({
		picker = { enabled = true },
	})
end

local CopilotChat_ok, CopilotChat = pcall(require, "CopilotChat")
if CopilotChat_ok then
	CopilotChat.setup({
		mappings = {
			reset = {
				-- Disable default mappings for resetting a chat because I use the built-in <C-l>
				normal = "",
				insert = "",
			},
			accept_diff = {
				-- Disable default mappings for accepting a diff because I use the built-in <C-y>
				-- For now, I am copying and pasting diffs manually.
				normal = "",
				insert = "",
			},
		},
	})
	vim.g.copilot_no_tab_map = true
end
