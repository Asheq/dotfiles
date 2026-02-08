local M = {}

local function echo_line(chunks)
	vim.api.nvim_echo(chunks, true, {})
end

local function print_option_groups(groups)
	for _, group in ipairs(groups) do
		if group.title and group.title ~= "" then
			echo_line({ { group.title, "Underlined" } })
		end

		for _, optname in ipairs(group.options) do
			local info = vim.api.nvim_get_option_info2(optname, {})
			-- TODO: Print information abou the option
		end
	end
end

function M.print_general()
	print_option_groups({
		{
			title = "Filetype",
			options = {
				"filetype",
			},
		},
		{
			title = "Encoding and format",
			options = {
				"fileencoding",
				"fileformat",
			},
		},
		{
			title = "Comments",
			options = {
				"comments",
				"commentstring",
			},
		},
		{
			title = "UI",
			options = {
				"tabline",
				"statusline",
				"winbar",
			},
		},
	})
end

function M.print_formatting()
	print_option_groups({
		{
			title = "Formatting methods for gq/gw operator (ascending priority)",
			options = {
				"formatprg",
				"formatexpr",
			},
		},
		{
			title = "For internal formatting",
			options = {
				"textwidth",
				"formatoptions",
				"formatlistpat",
			},
		},
	})
end

function M.print_indenting()
	print_option_groups({
		{
			title = "Tabs",
			options = {
				"expandtab",
				"tabstop",
				"shiftwidth",
				"smarttab",
				"softtabstop",
				"copyindent",
				"preserveindent",
			},
		},
		{
			title = "Indenting methods (ascending priority)",
			options = {
				"autoindent",
				"smartindent",
				"cindent",
				"indentexpr",
			},
		},
		{
			title = "For cindent",
			options = {
				"cinoptions",
				"cinkeys",
				"cinwords",
			},
		},
		{
			title = "For indentexpr",
			options = {
				"indentkeys",
			},
		},
	})
end

function M.print_folding()
	print_option_groups({
		{
			title = "Basic",
			options = {
				"foldenable",
				"foldlevelstart",
				"foldlevel",
				"foldmethod",
				"foldexpr",
				"foldmarker",
			},
		},
		{
			title = "Other",
			options = {
				"foldtext",
				"foldopen",
				"foldclose",
				"foldcolumn",
				"foldignore",
				"foldminlines",
				"foldnestmax",
			},
		},
	})
end

return M
