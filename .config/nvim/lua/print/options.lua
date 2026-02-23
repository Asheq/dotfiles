local util = require("util")

local M = {}

-- Print a single option
-- ============================================================================

---@param label string
---@param value any
---@param info vim.api.keyset.get_option_info
---@param printer Printer
local function print_option_value(label, value, info, printer)
	local chunks = {
		{ string.format("%s: ", label), "Normal" },
		{ tostring(value),              "NonText" },
	}

	local sid_info = util.get_sid_info(info.last_set_sid)

	if sid_info then
		table.insert(chunks, { " ➤ ", "Normal" })

		if sid_info.kind == "special" then
			table.insert(chunks, { sid_info.name, "Normal" })
		elseif sid_info.kind == "script" then
			local filename_info = util.get_filename_info(sid_info.filename)
			if filename_info then
				table.insert(chunks, { filename_info.prefix_alias, filename_info.highlight })
				table.insert(chunks, { filename_info.suffix, "Normal" })
			else
				table.insert(chunks, { sid_info.filename, "IncSearch" })
			end
		elseif sid_info.kind == "unknown" then
			table.insert(chunks, { tostring(sid_info.sid), "IncSearch" })
		end
	end

	printer:append_line(chunks, 2)
end

---@param optname string
---@param conf { print_default_value: boolean? }?
---@param printer Printer
local function print_option(optname, conf, printer)
	local print_default_value = conf and conf.print_default_value or false

	local info = vim.api.nvim_get_option_info2(optname, {})
	local value = vim.api.nvim_get_option_value(optname, {})

	local global_info = vim.api.nvim_get_option_info2(optname, { scope = "global" })
	local global_value = vim.api.nvim_get_option_value(optname, { scope = "global" })

	local local_info = vim.api.nvim_get_option_info2(optname, { scope = "local" })
	local local_value = vim.api.nvim_get_option_value(optname, { scope = "local" })

	-- Print header
	printer:append_line({
		{ string.format(" %s ", info.name),                                      "TermCursor" },
		{ info.shortname ~= "" and string.format("(%s) ", info.shortname) or "", "TermCursor" },
		{ string.format(" %s", info.scope),                                      "Identifier" },
		{ info.global_local and " + global" or "",                               "Identifier" },
		{ string.format(" [%s]", info.type),                                     "NonText" },
	}, 1)

	-- Print used/effective value
	printer:append_line({
		{ "   used: ",     "Normal" },
		{ tostring(value), "String" },
	}, 2)

	-- Print local value
	if info.scope == "buf" or info.scope == "win" or info.scope == "tab" then
		print_option_value("  local", local_value, local_info, printer)
	end

	-- Print global value
	print_option_value(" global", global_value, global_info, printer)

	-- Print default value
	if (print_default_value) then
		printer:append_line({
			{ "default: ",            "Normal" },
			{ tostring(info.default), "NonText" },
		}, 2)
	end
end

-- Print option groups
-- ============================================================================
---@param groups { title: string, optnames: string[] }[]
---@param conf { print_default_value: boolean? }?
function M.print_option_groups(groups, conf)
	local printer = util.new_printer({ history = true })
	local half_screen_cols = math.ceil(vim.opt.columns:get() / 2)

	for _, group in ipairs(groups) do
		-- Print group title
		local extra_space = math.max(half_screen_cols - #group.title, 0)
		printer:append_line({ { group.title .. string.rep(" ", extra_space), "Underlined" } }, 0)

		-- Print group options
		for _, optname in ipairs(group.optnames) do
			print_option(optname, conf, printer)
		end
	end

	printer:flush()
end

-- Print preset options
-- ============================================================================

local function print_general_options()
	M.print_option_groups({
		{
			title = "Filetype",
			optnames = {
				"filetype",
			},
		},
		{
			title = "Encoding and format",
			optnames = {
				"fileencoding",
				"fileformat",
			},
		},
		{
			title = "Comments",
			optnames = {
				"comments",
				"commentstring",
			},
		},
		{
			title = "Other",
			optnames = {
				"matchpairs",
				"omnifunc",
			},
		},
	})
end

local function print_display_options()
	M.print_option_groups({
		{
			title = "Window chrome",
			optnames = {
				"showtabline",
				"tabline",
				"laststatus",
				"statusline",
				"winbar",
				"statuscolumn",
				"signcolumn",
				"fillchars",
			},
		},
		{
			title = "Line numbers",
			optnames = {
				"number",
				"relativenumber",
				"numberwidth",
			},
		},
		{
			title = "Cursor indicators",
			optnames = {
				"cursorline",
				"cursorlineopt",
				"cursorcolumn",
				"colorcolumn",
			},
		},
		{
			title = "Text rendering",
			optnames = {
				"list",
				"listchars",
				"conceallevel",
				"concealcursor",
			},
		},
	})
end

local function print_formatting_options()
	M.print_option_groups({
		{
			title = "Formatting methods for gq/gw operator (ascending priority)",
			optnames = {
				"formatprg",
				"formatexpr",
			},
		},
		{
			title = "For internal formatting",
			optnames = {
				"textwidth",
				"wrapmargin",
				"formatoptions",
				"formatlistpat",
				"joinspaces",
			},
		},
	})
end

local function print_whitespace_options()
	M.print_option_groups({
		{
			title = "Auto-indenting, shifting, editing whitespace",
			optnames = {
				"expandtab",
				"tabstop",
				"softtabstop",
				"shiftwidth",
				"smarttab",
				"copyindent",
				"preserveindent",
			},
		},
		{
			title = "How much to auto-indent? (ascending priority)",
			optnames = {
				"autoindent",
				"smartindent",
				"cindent",
				"indentexpr",
			},
		},
		{
			title = "For cindent",
			optnames = {
				"cinoptions",
				"cinkeys",
				"cinwords",
			},
		},
		{
			title = "For indentexpr",
			optnames = {
				"indentkeys",
			},
		},
		{
			title = "Other",
			optnames = {
				"equalprg",
			},
		},
	})
end

local function print_folding_options()
	M.print_option_groups({
		{
			title = "State",
			optnames = {
				"foldenable",
				"foldlevel",
				"foldlevelstart",
			},
		},
		{
			title = "Fold method",
			optnames = {
				"foldmethod",
				"foldexpr",
				"foldmarker",
			},
		},
		{
			title = "Other",
			optnames = {
				"foldopen",
				"foldclose",
				"foldtext",
				"foldcolumn",
				"foldignore",
				"foldminlines",
				"foldnestmax",
			},
		},
	})
end

local function print_search_options()
	M.print_option_groups({
		{
			title = "File finding & gf navigation",
			optnames = {
				"path",
				"cdpath",
				"suffixesadd",
				"suffixes",
				"isfname",
			},
		},
		{
			title = "Include & define search",
			optnames = {
				"include",
				"includeexpr",
				"define",
			},
		},
		{
			title = "Grep",
			optnames = {
				"grepprg",
				"grepformat",
			},
		},
		{
			title = "Keyword",
			optnames = {
				"iskeyword",
				"isident",
				"keywordprg",
			},
		},
		{
			title = "Case sensitivity",
			optnames = {
				"ignorecase",
				"smartcase",
			},
		},
		{
			title = "Tags",
			optnames = {
				"tags",
				"tagfunc",
				"tagcase",
				"tagstack",
				"taglength",
				"tagrelative",
			},
		},
	})
end

local function print_modified_options()
	local modified_options = {}
	local info_by_name = vim.api.nvim_get_all_options_info()

	for name, info in pairs(info_by_name) do
		local default_value = info.default
		local ok, value = pcall(vim.api.nvim_get_option_value, name, {})
		if ok and value ~= default_value then
			table.insert(modified_options, name)
		end
	end

	table.sort(modified_options)

	M.print_option_groups({
		{
			title = "All options where effective value is diff than default value",
			optnames = modified_options,
		},
	}, {
		print_default_value = true,
	})
end

local function print_wrapping_options()
	M.print_option_groups({
		{
			title = "Wrapping",
			optnames = {
				"wrap",
				"linebreak",
				"breakindent",
				"breakindentopt",
				"showbreak",
			},
		},
	})
end

function M.select_preset_options_to_print()
	local items = {
		{ label = "General",    fn = print_general_options },
		{ label = "Display",    fn = print_display_options },
		{ label = "Formatting", fn = print_formatting_options },
		{ label = "Whitespace", fn = print_whitespace_options },
		{ label = "Wrap",       fn = print_wrapping_options },
		{ label = "Folding",    fn = print_folding_options },
		{ label = "Search",     fn = print_search_options },
		{ label = "Modified",   fn = print_modified_options },
	}

	vim.ui.select(items, {
		prompt = "Print options:",
		format_item = function(item)
			return item.label
		end,
	}, function(choice)
		if choice and type(choice.fn) == "function" then
			choice.fn()
		end
	end)
end

return M
