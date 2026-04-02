local print_options = require("print.options")
local print_mappings = require("print.mappings")
local system_calls = require("system_calls")
local nvim_word_list = require("nvim_word_list")
local diffopt_algorithm = require("diffopt_algorithm")

-- :Dictionary {keyword}
vim.api.nvim_create_user_command("Dictionary", function(opts)
	system_calls.open_dictionary(opts.args)
end, { nargs = 1 })

-- :BrowserSearch {keyword}
vim.api.nvim_create_user_command("BrowserSearch", function(opts)
	system_calls.browser_search(opts.args)
end, { nargs = 1 })

-- :PrintOptions [-def]                          → prompt to select preset option group
-- :PrintOptions [-def] {option1} [option2] ...  → print specified options
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

	if #optnames == 0 then
		print_options.select_preset_group(conf)
		return
	end

	print_options.print_option_group({ {
		title = "Options",
		optnames = optnames,
	} }, conf)
end, {
	nargs = "*",
	complete = "option",
})

-- TODO: Fix
-- :PrintMappings                      → print mappings for all modes
-- :PrintMappings {mode1} [mode2] ...  → print mappings for specified modes
vim.api.nvim_create_user_command("PrintMappings", function(opts)
	local modes, err = print_mappings.normalize_modes(opts.fargs)
	if err then
		vim.notify(err, vim.log.levels.ERROR)
		return
	end

	print_mappings.print_mappings(modes)
end, {
	nargs = "*",
	complete = function(arglead)
		local out = {}
		for _, m in ipairs(print_mappings.valid_modes()) do
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

-- :ChistorySelect
vim.api.nvim_create_user_command("ChistorySelect", function()
	local output = vim.api.nvim_exec2("chistory", { output = true }).output
	local lines = vim.split(output, "\n", { trimempty = true })

	vim.ui.select(lines, { prompt = "Jump to quickfix list:" }, function(_, idx)
		if idx then
			vim.cmd("chistory " .. idx)
		end
	end)
end, {})

-- :LhistorySelect
vim.api.nvim_create_user_command("LhistorySelect", function()
	local output = vim.api.nvim_exec2("lhistory", { output = true }).output
	local lines = vim.split(output, "\n", { trimempty = true })

	vim.ui.select(lines, { prompt = "Jump to location list:" }, function(_, idx)
		if idx then
			vim.cmd("lhistory " .. idx)
		end
	end)
end, {})

-- :DiffAlgo         → prompt to select algorithm
-- :DiffAlgo {algo}  → set specified algorithm
vim.api.nvim_create_user_command("DiffAlgo", function(opts)
	if opts.args == "" then
		diffopt_algorithm.select()
	else
		diffopt_algorithm.set(opts.args)
	end
end, {
	nargs = "?",
	complete = function(arglead)
		return vim.tbl_filter(function(algo)
			return vim.startswith(algo, arglead)
		end, diffopt_algorithm.algorithms)
	end,
})
