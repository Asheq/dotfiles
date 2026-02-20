local util = require("util")
local options = require("print.options")
local system_calls = require("system_calls")

-- Usage: :PrintOptions                          → interactive picker
-- Usage: :PrintOptions option1 [option2] [-def] → show specific option(s)
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
		options.choose()
		return
	end

	local printer = util.new_echo_buffer({ history = true })
	for _, optname in ipairs(option_names) do
		options.print_option(optname, conf, printer)
	end
	printer:flush()
end, {
	nargs = "*",
	complete = "option",
})

-- Usage: :Dictionary {keyword}
vim.api.nvim_create_user_command("Dictionary", function(opts)
	system_calls.open_dictionary(opts.args)
end, { nargs = 1 })

-- Usage: :BrowserSearch {keyword}
vim.api.nvim_create_user_command("BrowserSearch", function(opts)
	system_calls.browser_search(opts.args)
end, { nargs = 1 })
