local M = {}

-- Get current working directory
-- ============================================================================
---@return string
function M.get_global_cwd()
	return vim.fn.getcwd(-1, -1)
end

---@param tabnr integer
---@return string
function M.get_tab_cwd(tabnr)
	if vim.fn.haslocaldir(-1, tabnr) ~= 0 then
		return vim.fn.getcwd(-1, tabnr)
	end
	return ""
end

---@param winnr integer
---@return string
function M.get_window_cwd(winnr)
	if vim.fn.haslocaldir(winnr) ~= 0 then
		return vim.fn.getcwd(winnr)
	end
	return ""
end

-- Statusline
-- ============================================================================
---@return string
function M.get_statusline()
	return ""
		.. "%{v:lua.require('lines').get_statusline_file_name()}  "
		.. "%h%w%m%r%=[%P %{noscrollbar#statusline(10,'■','◫',['◧'],['◨'])} %L]"
		.. "%([%{v:lua.require('lines').get_statusline_window_cwd()}]%)"
end

-- NOTE: Unlike %f, this function always returns the file name relative to the
-- effective CWD of the statusline window
---@return string
function M.get_statusline_file_name()
	-- In this context, win_getid() returns the window of the statusline that
	-- is being drawn (a.k.a. the statusline window), not the active window.
	local winid = vim.fn.win_getid()

	local bufnr = vim.fn.winbufnr(winid)
	local bufname = vim.fn.bufname(bufnr)

	if bufname == "" then
		return "[No Name]"
	end

	local bufpath = vim.fn.fnamemodify(bufname, ":p")

	-- Get the effective CWD for the statusline window
	local win_cwd_path = vim.fn.fnamemodify(vim.fn.getcwd(winid), ":p")

	-- If file is under the CWD of the statusline window, make path relative to it
	if vim.startswith(bufpath, win_cwd_path) then
		local relative_bufname = bufpath:sub(#win_cwd_path + 1)
		return relative_bufname ~= "" and relative_bufname or bufpath
	end

	-- Otherwise, shorten with home directory (~)
	return vim.fn.fnamemodify(bufpath, ":~")
end

---@return string
function M.get_statusline_window_cwd()
	local winid = vim.fn.win_getid()
	local cwd = M.get_window_cwd(winid)
	return cwd == "" and "" or vim.fn.pathshorten(vim.fn.fnamemodify(cwd, ":~"))
end

-- Tabline
-- ============================================================================
---@return string
-- TODO-L: Simplify
function M.get_tabline()
	local s = ""
	for i = 0, vim.fn.tabpagenr("$") - 1 do
		-- select the highlighting
		if i + 1 == vim.fn.tabpagenr() then
			s = s .. "%#TabLineSel#"
		else
			s = s .. "%#TabLine#"
		end

		-- set the tab page number (for mouse clicks)
		s = s .. "%" .. (i + 1) .. "T"

		-- the label is made by get_tabline_tab_label()
		s = s ..
			" %{v:lua.require\'lines\'.get_tabline_tab_label(" ..
			(i + 1) .. ")}%( [%{v:lua.require\'lines\'.get_tabline_tab_cwd(" .. (i + 1) .. ")}]%)▕"
	end

	-- after the last tab fill with TabLineFill and reset tab page nr
	s = s .. "%#TabLineFill#%T"

	-- right-align the label to close the current tab page
	if vim.fn.tabpagenr("$") > 1 then
		s = s .. "%=%#TabLine#%999Xclose"
	end

	return s
end

---@param tabnr integer
---@return string
function M.get_tabline_tab_label(tabnr)
	return tostring(tabnr)
end

---@param tabnr integer
---@return string
function M.get_tabline_tab_cwd(tabnr)
	local cwd = M.get_tab_cwd(tabnr)
	return cwd == "" and "" or vim.fn.pathshorten(vim.fn.fnamemodify(cwd, ":~"))
end

return M
