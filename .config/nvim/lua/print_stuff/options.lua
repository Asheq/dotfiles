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

	-- local was_set_by_script =
	-- 	info.last_set_sid ~= 0 or
	-- 	global_info.last_set_sid ~= 0 or
	-- 	local_info.last_set_sid ~= 0

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
		-- local local_was_set_by_script = local_info.last_set_sid ~= 0
		local local_last_set_filename = util.get_filename(local_last_set_sid)

		local local_scope_label = "  local"

		printer:append_line({
			{ local_scope_label .. ": ", "Normal" },
			{ tostring(local_value),     "NonText" },
			local_last_set_filename and { " ➤ ", "DiagnosticError" },
			local_last_set_filename and { tostring(local_last_set_filename), "DiagnosticError" },
		}, 2)
	end

	local global_last_set_sid = global_info.last_set_sid
	-- local global_was_set_by_script = global_info.last_set_sid ~= 0
	local global_last_set_filename = util.get_filename(global_last_set_sid)

	local global_scope_label = " global"

	printer:append_line({
		{ global_scope_label .. ": ", "Normal" },
		{ tostring(global_value),     "NonText" },
		global_last_set_filename and { " ➤ ", "DiagnosticError" },
		global_last_set_filename and { tostring(global_last_set_filename), "DiagnosticError" },
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
			title = "Other",
			options = {
				"matchpairs",
				"omnifunc",
			},
		},
	})
end

function M.print_border()
	print_option_groups({
		{
			title = "Window dressing",
			options = {
				"tabline",
				"laststatus",
				"statusline",
				"winbar",
				"statuscolumn",
				"signcolumn",
			},
		},
		{
			title = "Displaying text",
			options = {
				"list",
				"relativenumber",
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
				"smarttab",
				"expandtab",
				"tabstop",
				"shiftwidth",
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
				"foldlevelstart",
				"foldenable",
				"foldlevel",
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

function M.print_search()
	print_option_groups({
		{
			title = "File finding & gf navigation",
			options = {
				"path",
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
			title = "Keyword",
			options = {
				"iskeyword",
				"keywordprg",
			},
		},
	})
end

function M.print_all_not_default()
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

return M
