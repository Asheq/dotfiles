local util = require("util")

local M = {}

-- Main functions
-- ============================================================================

---@param optname string
---@param conf? { show_default_value?: boolean }
---@param printer? EchoBuffer
function M.print_option(optname, conf, printer)
	local own_printer = false
	if not printer then
		printer = util.new_echo_buffer({ history = true })
		own_printer = true
	end

	local info = vim.api.nvim_get_option_info2(optname, {})
	local value = vim.api.nvim_get_option_value(optname, {})

	local global_info = vim.api.nvim_get_option_info2(optname, { scope = "global" })
	local global_value = vim.api.nvim_get_option_value(optname, { scope = "global" })

	local local_info = vim.api.nvim_get_option_info2(optname, { scope = "local" })
	local local_value = vim.api.nvim_get_option_value(optname, { scope = "local" })

	local function filename_hl(filename)
		if vim.startswith(filename, "$VIMCONFIG") then
			return "DiagnosticError"
		elseif vim.startswith(filename, "$VIMRUNTIME") then
			return "DiagnosticError"
		else
			return "DiagnosticWarn"
		end
	end

	printer:append_line({
		{ " " .. optname .. " (" .. info.shortname .. ") ",               "TermCursor" },
		{ " " .. info.scope .. (info.global_local and " + global" or ""), "Identifier" },
		{ " [" .. info.type .. "]",                                       "NonText" },
	}, 1)

	printer:append_line({
		{ "   used: ",     "Normal" },
		{ tostring(value), "String" },
	}, 2)

	if info.scope == "buf" or info.scope == "win" or info.scope == "tab" then
		local local_last_set_sid = local_info.last_set_sid
		local local_last_set_filename = util.get_filename(local_last_set_sid)
		local local_filename_hl = local_last_set_filename and filename_hl(local_last_set_filename) or nil

		local local_scope_label = "  local"

		printer:append_line({
			{ local_scope_label .. ": ", "Normal" },
			{ tostring(local_value),     "NonText" },
			local_last_set_filename and { " ➤ ", local_filename_hl },
			local_last_set_filename and { tostring(local_last_set_filename), local_filename_hl },
		}, 2)
	end

	local global_last_set_sid = global_info.last_set_sid
	local global_last_set_filename = util.get_filename(global_last_set_sid)
	local global_filename_hl = global_last_set_filename and filename_hl(global_last_set_filename) or nil

	local global_scope_label = " global"

	printer:append_line({
		{ global_scope_label .. ": ", "Normal" },
		{ tostring(global_value),     "NonText" },
		global_last_set_filename and { " ➤ ", global_filename_hl },
		global_last_set_filename and { tostring(global_last_set_filename), global_filename_hl },
	}, 2)

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

---@param groups { title?: string, options: string[] }[]
---@param conf? { show_default_value?: boolean }
---@param printer? EchoBuffer
local function print_option_groups(groups, conf, printer)
	local own_printer = false
	if not printer then
		printer = util.new_echo_buffer({ history = true })
		own_printer = true
	end

	for _, group in ipairs(groups) do
		if group.title and group.title ~= "" then
			local extra_space = math.ceil((vim.opt.columns:get() - #group.title) / 2)
			printer:append_line({ { group.title .. string.rep(" ", extra_space), "Underlined" } }, 0)
		end

		for _, optname in ipairs(group.options) do
			M.print_option(optname, conf, printer)
		end
	end

	if own_printer then
		printer:flush()
	end
end

-- Print preset groups of options
-- ============================================================================

local function print_general_options()
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
			title = "Other",
			options = {
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
			options = {
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
			options = {
				"number",
				"relativenumber",
				"numberwidth",
			},
		},
		{
			title = "Cursor indicators",
			options = {
				"cursorline",
				"cursorlineopt",
				"cursorcolumn",
				"colorcolumn",
			},
		},
		{
			title = "Text rendering",
			options = {
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
			options = {
				"formatprg",
				"formatexpr",
			},
		},
		{
			title = "For internal formatting",
			options = {
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
			options = {
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
		{
			title = "Other",
			options = {
				"equalprg",
			},
		},
	})
end

local function print_folding_options()
	print_option_groups({
		{
			title = "State",
			options = {
				"foldenable",
				"foldlevel",
				"foldlevelstart",
			},
		},
		{
			title = "Fold method",
			options = {
				"foldmethod",
				"foldexpr",
				"foldmarker",
			},
		},
		{
			title = "Other",
			options = {
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
			options = {
				"path",
				"cdpath",
				"suffixesadd",
				"suffixes",
				"isfname",
			},
		},
		{
			title = "Include & define search",
			options = {
				"include",
				"includeexpr",
				"define",
			},
		},
		{
			title = "Grep",
			options = {
				"grepprg",
				"grepformat",
			},
		},
		{
			title = "Keyword",
			options = {
				"iskeyword",
				"isident",
				"keywordprg",
			},
		},
		{
			title = "Case sensitivity",
			options = {
				"ignorecase",
				"smartcase",
			},
		},
		{
			title = "Tags",
			options = {
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

local function print_all_not_default_options()
	local all_options = {}
	local info_by_name = vim.api.nvim_get_all_options_info()

	for name, info in pairs(info_by_name) do
		local default_value = info.default
		local has_diff = false

		local ok, value = pcall(vim.api.nvim_get_option_value, name, {})
		if ok and value ~= default_value then
			has_diff = true
		end

		if has_diff then
			table.insert(all_options, name)
		end
	end

	table.sort(all_options)
	print_option_groups({
		{
			title = "All options with local or global value different from default",
			options = all_options,
		},
	}, {
		show_default_value = true,
	})
end

function M.choose()
	-- Ctrl+<letter> is represented as an ASCII control code: byte(letter) & 0x1f
	-- Examples: Ctrl+g=7, Ctrl+d=4, Ctrl+f=6, Ctrl+w=23, Ctrl+z=26, Ctrl+s=19, Ctrl+a=1
	local actions_by_code = {
		[7] = { label = "General", fn = print_general_options },
		[4] = { label = "Display", fn = print_display_options },
		[6] = { label = "Formatting", fn = print_formatting_options },
		[23] = { label = "Whitespace", fn = print_whitespace_options },
		[26] = { label = "Folding", fn = print_folding_options },
		[19] = { label = "Search", fn = print_search_options },
		[1] = { label = "All non-default", fn = print_all_not_default_options },
	}

	local lines = {
		"Print options: press Ctrl+key",
		"  [C-g] General",
		"  [C-d] Display",
		"  [C-f] Formatting",
		"  [C-w] Whitespace",
		"  [C-z] Folding",
		"  [C-s] Search",
		"  [C-a] All non-default",
		"  (Esc to cancel)",
	}

	vim.api.nvim_echo({ { table.concat(lines, "\n"), "None" } }, false, {})

	while true do
		local ok, code = pcall(vim.fn.getchar)
		if not ok or code == nil then
			return
		end

		-- Some keys may come back as strings depending on UI/input method.
		if type(code) == "string" then
			code = string.byte(code)
		end

		-- Cancel only on Esc
		if code == 27 then
			return
		end

		local action = actions_by_code[code]
		if action and type(action.fn) == "function" then
			action.fn()
			return
		end

		vim.notify("Unknown choice (use Ctrl+key): " .. vim.inspect(code), vim.log.levels.WARN)
	end
end

return M
