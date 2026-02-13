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
		say_process = vim.system({ 'say', '-r', tostring(speech_rate) }, { stdin = text, text = true })
	end
end

return M
