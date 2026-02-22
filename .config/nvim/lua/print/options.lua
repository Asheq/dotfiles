local util = require("util")

local M = {}

-- Print a single option
-- ============================================================================

---@param value any
---@param info vim.api.keyset.get_option_info
---@param label string
---@param printer Printer
local function print_option_value(value, info, label, printer)
	local last_set_filename = util.get_filename(info.last_set_sid)
	local filename_hl = util.get_filename_hl(last_set_filename)

	local chunks = {
		{ string.format("%s: ", label), "Normal" },
		{ tostring(value), "NonText" },
		{ last_set_filename and string.format(" ➤ %s", last_set_filename) or "", filename_hl },
	}

	printer:append_line(chunks, 2)
end

---@param optname string
---@param conf? { show_default_value?: boolean }
---@param printer? Printer
local function print_option(optname, conf, printer)
	local own_printer = false
	if not printer then
		printer = util.new_printer({ history = true })
		own_printer = true
	end

	local info = vim.api.nvim_get_option_info2(optname, {})
	local value = vim.api.nvim_get_option_value(optname, {})

	local global_info = vim.api.nvim_get_option_info2(optname, { scope = "global" })
	local global_value = vim.api.nvim_get_option_value(optname, { scope = "global" })

	local local_info = vim.api.nvim_get_option_info2(optname, { scope = "local" })
	local local_value = vim.api.nvim_get_option_value(optname, { scope = "local" })

	printer:append_line({
		{ string.format(" %s ", info.name),                                      "TermCursor" },
		{ info.shortname ~= "" and string.format("(%s) ", info.shortname) or "", "TermCursor" },
		{ string.format(" %s", info.scope),                                      "Identifier" },
		{ info.global_local and " + global" or "",                               "Identifier" },
		{ string.format(" [%s]", info.type),                                     "NonText" },
	}, 1)

	printer:append_line({
		{ "   used: ",     "Normal" },
		{ tostring(value), "String" },
	}, 2)

	if info.scope == "buf" or info.scope == "win" or info.scope == "tab" then
		print_option_value(local_value, local_info, "  local", printer)
	end

	print_option_value(global_value, global_info, " global", printer)

	if (conf and conf.show_default_value) then
		printer:append_line({
			{ "default: ",            "Normal" },
			{ tostring(info.default), "NonText" },
		}, 2)
	end

	if own_printer then
		printer:flush()
	end
end

-- Print multiple options
-- ============================================================================

---@param optnames? string[]
---@param conf? { show_default_value?: boolean }
function M.print_options(optnames, conf)
	optnames = optnames or {}
	conf = conf or { show_default_value = false }

	local printer = util.new_printer({ history = true })
	for _, optname in ipairs(optnames) do
		print_option(optname, conf, printer)
	end
	printer:flush()
end

-- Print preset option groups
-- ============================================================================

---@param groups { title: string, optnames: string[] }[]
---@param conf? { show_default_value?: boolean }
local function print_option_groups(groups, conf)
	local printer = util.new_printer({ history = true })

	for _, group in ipairs(groups) do
		if group.title and group.title ~= "" then
			local extra_space = math.ceil((vim.opt.columns:get() - #group.title) / 2)
			printer:append_line({ { group.title .. string.rep(" ", extra_space), "Underlined" } }, 0)
		end

		for _, optname in ipairs(group.optnames) do
			print_option(optname, conf, printer)
		end
	end

	printer:flush()
end

local function print_general_options()
	print_option_groups({
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
	print_option_groups({
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
	print_option_groups({
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
	print_option_groups({
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
	print_option_groups({
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
	print_option_groups({
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
	print_option_groups({
		{
			title = "All options where effective value is diff than default value",
			optnames = modified_options,
		},
	}, {
		show_default_value = true,
	})
end

function M.select_preset_option_groups()
	local items = {
		{ label = "General",    fn = print_general_options },
		{ label = "Display",    fn = print_display_options },
		{ label = "Formatting", fn = print_formatting_options },
		{ label = "Whitespace", fn = print_whitespace_options },
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
