local options = require("print_stuff.options")

-- Usage: :PrintOptions option1 [option2] [option3] ... [-def]
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
})

-- TODO: Add a command for :Dictionary {keyword}
-- TODO: Add a command for :BrowserSearch {keyword}
