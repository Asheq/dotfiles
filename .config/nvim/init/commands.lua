local options = require("print_stuff.options")

vim.api.nvim_create_user_command("PrintGeneralOptions", options.print_general, {})
vim.api.nvim_create_user_command("PrintFormattingOptions", options.print_formatting, {})
vim.api.nvim_create_user_command("PrintIndentingOptions", options.print_indenting, {})
vim.api.nvim_create_user_command("PrintFoldingOptions", options.print_folding, {})
vim.api.nvim_create_user_command("PrintBorderOptions", options.print_border, {})
vim.api.nvim_create_user_command("PrintAllNotDefaultOptions", options.print_all_not_default, {})

-- Usage: :PrintOptions [option1] [option2] ... [-def]
vim.api.nvim_create_user_command("PrintOptions", function(opts)
	local option_names = {}
	local conf = { show_default_value = false }
	for _, arg in ipairs(opts.fargs) do
		if arg == "-def" then
			conf.show_default_value = true
		elseif not vim.startswith(arg, "-") then
			table.insert(option_names, arg)
		end
	end
	if #option_names == 0 then
		vim.notify("At least one option name required", vim.log.levels.ERROR)
		return
	end
	for _, optname in ipairs(option_names) do
		options.print_option(optname, conf)
	end
end, {
	nargs = "+",
	complete = "option",
	desc = "Print info about Vim options",
})

-- TODO: Add a command for :Dictionary
