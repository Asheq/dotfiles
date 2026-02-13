local M = {}

---@param file string
---@param line integer
---@param col integer
function M.open_file_in_vscode(file, line, col)
	vim.system({ "code", "--goto", string.format("%s:%d:%d", file, line, col) }, { detach = true })
end

function M.open_curr_file_in_vscode()
	local file = vim.fn.expand("%")
	local line = vim.fn.line(".")
	local col = vim.fn.col(".")
	M.open_file_in_vscode(file, line, col)
end

---@param keyword string | nil
function M.open_dictionary(keyword)
	if keyword then
		vim.system({ "open", "dict://" .. vim.uri_encode(keyword) }, { detach = true })
	end
end

---@param keyword string | nil
function M.browser_search(keyword)
	if keyword then
		M.open_url_in_firefox("https://www.google.com/search?q=" .. vim.uri_encode(keyword))
	end
end

---@param url string
---@param opts { new_window?: boolean }?
function M.open_url_in_firefox(url, opts)
	local cmd = { "open", "-a", "Firefox", "-n", "--args" }

	local new_window = opts and opts.new_window or false
	if new_window then
		table.insert(cmd, "--new-window")
	end
	table.insert(cmd, url)

	vim.system(cmd, { detach = true })
end

local speech_rate = 250

---@param delta integer
function M.change_speech_rate(delta)
	speech_rate = speech_rate + delta
	vim.notify(tostring(speech_rate))
end

---@type vim.SystemObj | nil
local say_process = nil

---@param text string?
function M.speak(text)
	-- If a process is running, kill it
	if say_process and not say_process:is_closing() then
		local SIGTERM = 15
		say_process:kill(SIGTERM)
		say_process = nil
		return
	end

	-- Otherwise, start a new one
	if text then
		say_process = vim.system({ "say", "-r", tostring(speech_rate) }, { stdin = text, text = true, detach = true })
	end
end

return M
