local options = require("print.options")
local mappings = require("print.mappings")
local system_calls = require("system_calls")
local nvim_word_list = require("nvim_word_list")

-- :Dictionary {keyword}
vim.api.nvim_create_user_command("Dictionary", function(opts)
	system_calls.open_dictionary(opts.args)
end, { nargs = 1 })

-- :BrowserSearch {keyword}
vim.api.nvim_create_user_command("BrowserSearch", function(opts)
	system_calls.browser_search(opts.args)
end, { nargs = 1 })

-- :PrintOptions [-def] {option1} [option2] ... → print specified options
vim.api.nvim_create_user_command("PrintOptions", function(opts)
	local optnames = {}
	local conf = { print_default_value = false }

	for _, arg in ipairs(opts.fargs or {}) do
		if arg == "-def" then
			conf.print_default_value = true
		elseif not vim.startswith(arg, "-") then
			table.insert(optnames, arg)
		end
	end

	options.print_option_groups({ {
		title = "Options",
		optnames = optnames,
	} }, conf)
end, {
	nargs = "+",
	complete = "option",
})

-- :PrintMappings                      → print mappings for all modes
-- :PrintMappings {mode1} [mode2] ...  → print mappings for specified modes
vim.api.nvim_create_user_command("PrintMappings", function(opts)
	local modes, err = mappings.normalize_modes(opts.fargs)
	if err then
		vim.notify("PrintMappings: " .. err, vim.log.levels.ERROR)
		return
	end

	mappings.print_mappings(modes)
end, {
	nargs = "*",
	complete = function(arglead)
		local out = {}
		for _, m in ipairs(mappings.valid_modes()) do
			if arglead == "" or vim.startswith(m, arglead) then
				table.insert(out, m)
			end
		end
		return out
	end,
})

-- :SpellCleanAdd
vim.api.nvim_create_user_command("SpellCleanAdd", function()
	local cmd = "runtime spell/cleanadd.vim"
	vim.notify("Executing: " .. cmd)
	vim.cmd(cmd)
end, {})

-- :MakeSpell
vim.api.nvim_create_user_command("MakeSpell", function()
	local cmd = "mkspell! %"
	vim.notify("Executing: " .. cmd)
	vim.cmd(cmd)
end, {})

-- :NeovimWordListUpdate
vim.api.nvim_create_user_command("NeovimWordListUpdate",
	nvim_word_list.update_spell_file,
	{})
