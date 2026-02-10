local M = {}

function M.open_file_in_vscode(file, line, col)
	vim.system({ "code", "--goto", string.format("%s:%d:%d", file, line, col) }, { detach = true })
end

function M.open_dictionary(keyword)
	vim.system({ "open", "dict://" .. vim.uri_encode(keyword) }, { detach = true })
end

function M.open_url_in_firefox(url)
	vim.system({ "open", "-a", "Firefox", "-n", "--args", "--new-window", url }, { detach = true })
end

return M
