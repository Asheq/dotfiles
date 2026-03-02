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
	})
end

local function print_comment_options()
	M.print_option_groups({
		{
			title = "Main",
			optnames = {
				"comments",
				"commentstring",
			},
		},
	})
end

local function print_spell_options()
	M.print_option_groups({
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
	})
end

local function print_diff_options()
	M.print_option_groups({
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
	})
end

local function print_ui_options()
	M.print_option_groups({
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
	})
end

local function print_text_formatting_options()
	-- Formatting with `gq`/`gw` operators
	M.print_option_groups({
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
	})
end

local function print_file_navigation_options()
	M.print_option_groups({
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
	})
end

local function print_keyword_options()
	M.print_option_groups({
		{
			title = "Keyword",
			optnames = {
				"iskeyword",
				"isident",
				"keywordprg",
			},
		},
	})
end
local function print_text_display_options()
	M.print_option_groups({
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
	})
end

local function print_text_search_options()
	M.print_option_groups({
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

function M.select_preset_options_to_print()
	local items = {
		{ label = "General",         fn = print_general_options },
		{ label = "Comment",         fn = print_comment_options },
		{ label = "Spell",           fn = print_spell_options },
		{ label = "Diff",            fn = print_diff_options },
		{ label = "UI",              fn = print_ui_options },
		{ label = "Text Display",    fn = print_text_display_options },
		{ label = "Text Formatting", fn = print_text_formatting_options },
		{ label = "Whitespace",      fn = print_whitespace_options },
		{ label = "Folding",         fn = print_folding_options },
		{ label = "File Navigation", fn = print_file_navigation_options },
		{ label = "Keyword",         fn = print_keyword_options },
		{ label = "Text Search",     fn = print_text_search_options },
		{ label = "Modified",        fn = print_modified_options },
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
