local M = {}

local function echo_line(chunks, indent)
	local indent_str = string.rep("  ", indent and (indent * 2) or 0)
	local indented_chunks = vim.deepcopy(chunks)
	table.insert(indented_chunks, 1, { indent_str, "Normal" })
	vim.api.nvim_echo(indented_chunks, true, {})
end

local function get_filename(sid)
	if sid == 0 then
		return nil
	end

	if sid < 0 then
		return sid
	end

	local scripts = vim.fn.getscriptinfo({ sid = sid })

	if scripts[1] and scripts[1].name and scripts[1].name ~= "" then
		local name = scripts[1].name

		local runtime = vim.env.VIMRUNTIME
		if runtime and runtime ~= "" and name:sub(1, #runtime) == runtime then
			name = "$VIMRUNTIME" .. name:sub(#runtime + 1)
		end

		local vimconfig = vim.env.HOME .. "/.config/nvim"
		if name:sub(1, #vimconfig) == vimconfig then
			name = "$VIMCONFIG" .. name:sub(#vimconfig + 1)
		end

		local plug_home = vim.g.plug_home
		if name:sub(1, #plug_home) == plug_home then
			name = "$PLUGHOME" .. name:sub(#plug_home + 1)
		end

		return name
	end

	return sid
end

local show_used_value = false
local show_default_value = false

local function print_option(optname)
	-- TODO: Handle tab-local options?

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

	echo_line({
		{ " " .. optname .. " ",                                          "TermCursor" },
		{ " (" .. info.shortname .. ")",                                  "NonText" },
		{ " [" .. info.type .. "]",                                       "NonText" },
		{ " " .. (info.global_local and "global + " or "") .. info.scope, "NonText" }
	}, 1)

	if (show_used_value) then
		echo_line(
			{
				{ "          Used: ", "Normal" },
				{ tostring(value),    "String" },
			},
			2)
	end

	if info.scope == "buf" or info.scope == "win" then
		local local_scope_label = info.scope == "buf" and "       Buf" or "       Win"

		local local_last_set_sid = local_info.last_set_sid
		-- local local_was_set_by_script = local_info.last_set_sid ~= 0
		local local_last_set_filename = get_filename(local_last_set_sid)

		echo_line(
			{
				{ local_scope_label .. ": ", "Normal" },
				{ tostring(local_value),     "String" },
				local_last_set_filename and { " ➤ ", "DiagnosticError" },
				local_last_set_filename and { tostring(local_last_set_filename), "DiagnosticError" },
			},
			2)
	end

	local global_scope_label = "       ???"
	if (info.scope == "global" or info.global_local) then
		global_scope_label = "       Gbl"
	elseif (info.scope == "buf") then
		global_scope_label = "(Init) Gbl"
	elseif (info.scope == "win") then
		global_scope_label = "(Bufs) Gbl"
	end

	local global_last_set_sid = global_info.last_set_sid
	-- local global_was_set_by_script = global_info.last_set_sid ~= 0
	local global_last_set_filename = get_filename(global_last_set_sid)

	echo_line(
		{
			{ global_scope_label .. ": ", "Normal" },
			{ tostring(global_value),     info.scope == "global" and "String" or "NonText" },
			global_last_set_filename and { " ➤ ", "DiagnosticError" },
			global_last_set_filename and { tostring(global_last_set_filename), "DiagnosticError" },
		},
		2)

	if (show_default_value) then
		echo_line(
			{
				{ "       Default: ",     "Normal" },
				{ tostring(info.default), "NonText" },
			},
			2)
	end
end

local function print_option_groups(groups)
	for _, group in ipairs(groups) do
		if group.title and group.title ~= "" then
			local extra_space = math.ceil((vim.o.columns - #group.title) / 2)
			echo_line({ { group.title .. string.rep(" ", extra_space), "Underlined" } }, 0)
		end

		for _, optname in ipairs(group.options) do
			print_option(optname)
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
	})
end

function M.print_border()
	print_option_groups({
		{
			title = "Window dressing",
			options = {
				"tabline",
				"statusline",
				"laststatus",
				"winbar",
				"statuscolumn",
				"signcolumn",
			},
		},
		{
			title = "Displaying text",
			options = {
				"list",
				"number",
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
