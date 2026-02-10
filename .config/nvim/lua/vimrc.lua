local M = {}

local function system_detached(cmd)
	if vim.system then
		vim.system(cmd, { detach = true })
		return
	end

	-- Neovim < 0.10
	vim.fn.jobstart(cmd, { detach = true })
end

---Open a file/url in the macOS shell using `open`.
---
---Equivalent to the VimL `vimrc#open_in_shell()`.
---
---@param item string
---@param application? string
function M.open_in_shell(item, application)
	local cmd = { "open" }
	if application and application ~= "" then
		vim.list_extend(cmd, { "-a", application })
	end
	table.insert(cmd, item)
	system_detached(cmd)
end

---Percent-encode a string using RFC 3986 unreserved set.
---
---Matches the behavior of the VimL implementation, which encodes bytes that
---are not in `[A-Za-z0-9_.~-]`.
---
---@param str string
---@return string
function M.url_encode(str)
	return (str:gsub("([^A-Za-z0-9_.~-])", function(c)
		return string.format("%%%02X", string.byte(c))
	end))
end

---Get the current visual selection text without yanking.
---
---This avoids the side-effects of normal-mode yanks and register writes.
---
---@param opts? { bufnr?: integer }
---@return string
function M.get_selection_text(opts)
	opts = opts or {}
	local bufnr = opts.bufnr or 0
	local vmode = vim.fn.visualmode()

	local pos1 = vim.fn.getpos("'<")
	local pos2 = vim.fn.getpos("'>")
	if pos1[2] == 0 or pos2[2] == 0 then
		return ""
	end

	if bufnr ~= 0 then
		pos1[1] = bufnr
		pos2[1] = bufnr
	end

	local lines = vim.fn.getregion(pos1, pos2, { type = vmode })
	return table.concat(lines, "\n")
end

---Open Dictionary.app definition (via dict:// URL scheme).
---
---@param keyword string
function M.define(keyword)
	M.open_in_shell("dict://" .. M.url_encode(keyword))
end

return M
