local M = {}

-- Get current working directory
-- ============================================================================

---@return string
function M.get_global_cwd()
	return vim.fn.getcwd(-1, -1)
end

---@param tabnr integer
---@return string | nil
function M.get_tab_local_cwd(tabnr)
	if vim.fn.haslocaldir(-1, tabnr) ~= 0 then
		return vim.fn.getcwd(-1, tabnr)
	else
		return nil
	end
end

---@param winnr integer
---@return string | nil
function M.get_window_local_cwd(winnr)
	if vim.fn.haslocaldir(winnr) ~= 0 then
		return vim.fn.getcwd(winnr)
	else
		return nil
	end
end

-- Statusline
-- ============================================================================

---@return string
function M.get_statusline()
	return
	"%{v:lua.require('lines').get_statusline_file_name()}  %h%w%m%r%=[%P %{noscrollbar#statusline(10,'■','◫',['◧'],['◨'])} %L]%([%{v:lua.require('lines').get_statusline_window_cwd()}]%)"
end

-- NOTE: Unlike %f, this function always returns the file name relative to the
-- effective CWD of the statusline window
---@return string
function M.get_statusline_file_name()
	-- In this context, win_getid() returns the window of the statusline that
	-- is being drawn, not the active window.
	local winid = vim.fn.win_getid()
	local bufnr = vim.fn.winbufnr(winid)
	local bufname = vim.fn.bufname(bufnr)

	if bufname == "" then
		return "[No Name]"
	end

	local bufpath = vim.fn.fnamemodify(bufname, ":p")
	local cwd = vim.fn.fnamemodify(vim.fn.getcwd(winid), ":p")

	if vim.startswith(bufpath, cwd) then
		local rel_bufpath = bufpath:sub(#cwd + 1)
		return rel_bufpath ~= "" and rel_bufpath or bufpath
	else
		return vim.fn.fnamemodify(bufpath, ":~")
	end
end

---@return string
function M.get_statusline_window_cwd()
	local winid = vim.fn.win_getid()
	local cwd = M.get_window_local_cwd(winid)
	return (cwd and cwd ~= "" and vim.fn.pathshorten(vim.fn.fnamemodify(cwd, ":~"))) or ""
end

-- Tabline
-- ============================================================================

---@return string
function M.get_tabline()
	local tab_count = vim.fn.tabpagenr("$")
	local current_tab = vim.fn.tabpagenr()
	local s = {}
	for i = 1, tab_count do
		local hl = (i == current_tab) and "%#TabLineSel#" or "%#TabLine#"
		table.insert(s, hl .. "%" .. i .. "T" ..
			string.format(
				" %%{v:lua.require('lines').get_tabline_tab_label(%d)}%%( [%%{v:lua.require('lines').get_tabline_tab_cwd(%d)}]%%)▕",
				i, i))
	end
	table.insert(s, "%#TabLineFill#%T")
	if tab_count > 1 then
		table.insert(s, "%=%#TabLine#%999X▏Close ")
	end
	return table.concat(s)
end

---@param tabnr integer
---@return string
function M.get_tabline_tab_label(tabnr)
	return "Tab " .. tostring(tabnr)
end

---@param tabnr integer
---@return string
function M.get_tabline_tab_cwd(tabnr)
	local cwd = M.get_tab_local_cwd(tabnr)
	return (cwd and cwd ~= "" and vim.fn.pathshorten(vim.fn.fnamemodify(cwd, ":~"))) or ""
end

return M
