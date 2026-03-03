local util = require("util")

local M = {}

-- Global types
-- ===========================================================================
---@alias PrintOptionsConf { print_default_value: boolean? }
---@alias PrintOptionGroup PrintOptionSubgroup[]
---@alias PrintOptionSubgroup { title: string, optnames: string[] }

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
---@param printer Printer
---@param conf PrintOptionsConf?
local function print_option(optname, printer, conf)
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

-- Print an option group
-- ============================================================================
---@param group PrintOptionGroup
---@param conf PrintOptionsConf?
function M.print_option_group(group, conf)
	local printer = util.new_printer({ history = true })
	local half_screen_cols = math.ceil(vim.opt.columns:get() / 2)

	for _, subgroup in ipairs(group) do
		-- Print subgroup title
		local extra_space = math.max(half_screen_cols - #subgroup.title, 0)
		printer:append_line({ { subgroup.title .. string.rep(" ", extra_space), "Underlined" } }, 0)

		-- Print subgroup options
		for _, optname in ipairs(subgroup.optnames) do
			print_option(optname, printer, conf)
		end
	end

	printer:flush()
end

-- Print a preset option group
-- ============================================================================

---@param conf PrintOptionsConf?
local function print_general_group(conf)
	M.print_option_group({
		{
			title = "File type",
			optnames = {
				"filetype",
			},
		},
		{
			title = "File encoding & format",
			optnames = {
				"fileencoding",
				"fileformat",
			},
		},
		{
			title = "Other",
			optnames = {
				"matchpairs",
				"omnifunc",
			},
		}
	}, conf)
end

---@param conf PrintOptionsConf?
local function print_comment_group(conf)
	M.print_option_group({
		{
			title = "Main",
			optnames = {
				"comments",
				"commentstring",
			},
		},
	}, conf)
end

---@param conf PrintOptionsConf?
local function print_spell_group(conf)
	M.print_option_group({
		{
			title = "Main",
			optnames = {
				"spell",
				"spelloptions",
				"spelllang",
				"spellfile",
			},
		},
		{
			title = "Other",
			optnames = {
				"spellsuggest",
				"spellcapcheck",
			},
		},
	}, conf)
end

---@param conf PrintOptionsConf?
local function print_diff_group(conf)
	M.print_option_group({
		{
			title = "Diff",
			optnames = {
				"diffopt",
				"diffexpr",
			},
		},
		{
			title = "Patch",
			optnames = {
				"patchexpr",
				"patchmode",
			},
		},
		{
			title = "Auto-updated in diff mode",
			optnames = {
				"diff",
				"wrap",
				"cursorbind",
				"scrollbind",
				"scrollopt",
				"foldenable",
				"foldmethod",
				"foldcolumn",
			},
		},
	}, conf)
end

---@param conf PrintOptionsConf?
local function print_ui_group(conf)
	M.print_option_group({
		{
			title = "Tab line",
			optnames = {
				"showtabline",
				"tabline",
			},
		},
		{
			title = "Status line",
			optnames = {
				"laststatus",
				"statusline",
			},
		},
		{
			title = "Window bar, status column, sign column",
			optnames = {
				"winbar",
				"statuscolumn",
				"signcolumn",
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
			},
		},
		{
			title = "Other",
			optnames = {
				"fillchars",
				"colorcolumn",
			},
		},
	}, conf)
end

---@param conf PrintOptionsConf?
local function print_text_formatting_group(conf)
	-- Formatting with `gq`/`gw` operators
	M.print_option_group({
		{
			title = "Formatting methods (ascending priority)",
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
	}, conf)
end

---@param conf PrintOptionsConf?
local function print_whitespace_group(conf)
	M.print_option_group({
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
	}, conf)
end

---@param conf PrintOptionsConf?
local function print_folding_group(conf)
	M.print_option_group({
		{
			title = "Fold state",
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
			},
		},
		{
			title = "Fold method specifics",
			optnames = {
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
	}, conf)
end

---@param conf PrintOptionsConf?
local function print_file_navigation_group(conf)
	M.print_option_group({
		{
			title = "File finding (gf, :find)",
			optnames = {
				"path",
				"cdpath",
				"suffixesadd",
				"suffixes",
				"isfname",
			},
		},
		{
			title = "Include & define",
			optnames = {
				"include",
				"includeexpr",
				"define",
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
	}, conf)
end

---@param conf PrintOptionsConf?
local function print_keyword_group(conf)
	M.print_option_group({
		{
			title = "Keyword",
			optnames = {
				"iskeyword",
				"isident",
				"keywordprg",
			},
		},
	}, conf)
end

---@param conf PrintOptionsConf?
local function print_text_display_group(conf)
	M.print_option_group({
		{
			title = "List",
			optnames = {
				"list",
				"listchars",
			},
		},
		{
			title = "Conceal",
			optnames = {
				"conceallevel",
				"concealcursor",
			},
		},
		{
			title = "Line wrapping",
			optnames = {
				"wrap",
				"linebreak",
				"breakindent",
				"breakindentopt",
				"showbreak",
			},
		},
	}, conf)
end

---@param conf PrintOptionsConf?
local function print_text_search_group(conf)
	M.print_option_group({
		{
			title = "Grep",
			optnames = {
				"grepprg",
				"grepformat",
			},
		},
		{
			title = "Case sensitivity",
			optnames = {
				"ignorecase",
				"smartcase",
			},
		},
	}, conf)
end

---@param conf PrintOptionsConf?
local function print_modified_group(conf)
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

	M.print_option_group({
		{
			title = "All options where effective value is diff than default value",
			optnames = modified_options,
		},
	}, conf or {
		print_default_value = true,
	})
end

---@param conf PrintOptionsConf?
function M.select_preset_group(conf)
	local items = {
		{ label = "General",         fn = print_general_group },
		{ label = "Comment",         fn = print_comment_group },
		{ label = "Spell",           fn = print_spell_group },
		{ label = "Diff",            fn = print_diff_group },
		{ label = "UI",              fn = print_ui_group },
		{ label = "Text Display",    fn = print_text_display_group },
		{ label = "Text Formatting", fn = print_text_formatting_group },
		{ label = "Whitespace",      fn = print_whitespace_group },
		{ label = "Folding",         fn = print_folding_group },
		{ label = "File Navigation", fn = print_file_navigation_group },
		{ label = "Keyword",         fn = print_keyword_group },
		{ label = "Text Search",     fn = print_text_search_group },
		{ label = "Modified",        fn = print_modified_group },
	}

	vim.ui.select(items, {
		prompt = "Print preset option group:",
		format_item = function(item)
			return item.label
		end,
	}, function(choice)
		if choice and type(choice.fn) == "function" then
			choice.fn(conf)
		end
	end)
end

return M
