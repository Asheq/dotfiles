local M = {}

---@param file string
---@param line integer
---@param col integer
function M.open_file_in_vscode(file, line, col)
	vim.system({ "code", "--goto", string.format("%s:%d:%d", file, line, col) }, { detach = true })
end

---@param keyword string
function M.open_dictionary(keyword)
	vim.system({ "open", "dict://" .. vim.uri_encode(keyword) }, { detach = true })
end

---@param url string
---@param opts { new_window?: boolean }?
function M.open_url_in_firefox(url, opts)
	local new_window = opts and opts.new_window or false
	local args = { "open", "-a", "Firefox", "-n", "--args" }
	if new_window then
		table.insert(args, "--new-window")
	end
	table.insert(args, url)
	vim.system(args, { detach = true })
end

return M
