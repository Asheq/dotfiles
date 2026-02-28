local M = {}

local extra_words = {}
local ignore = {}

--- Collect, deduplicate, sort, and write all Neovim words to a spellfile.
function M.update_spell_file()
	-- Map source names to functions that return word lists
	local source_map = {
		["function"] = vim.fn.getcompletion("", "function"),
		cmdline = vim.fn.getcompletion("", "cmdline"),
		color = vim.fn.getcompletion("", "color"),
		command = vim.fn.getcompletion("", "command"),
		compiler = vim.fn.getcompletion("", "compiler"),
		environment = vim.fn.getcompletion("", "environment"),
		event = vim.fn.getcompletion("", "event"),
		file_in_path = vim.fn.getcompletion("", "file_in_path"),
		filetype = vim.fn.getcompletion("", "filetype"),
		help = vim.fn.getcompletion("", "help"),
		highlight = vim.fn.getcompletion("", "highlight"),
		history = vim.fn.getcompletion("", "history"),
		mapping = vim.fn.getcompletion("", "mapping"),
		messages = vim.fn.getcompletion("", "messages"),
		option = vim.fn.getcompletion("", "option"),
		packadd = vim.fn.getcompletion("", "packadd"),
		shellcmd = vim.fn.getcompletion("", "shellcmd"),
		sign = vim.fn.getcompletion("", "sign"),
		syntime = vim.fn.getcompletion("", "syntime"),
		var = vim.fn.getcompletion("", "var")
	}

	-- Collect words into a set to deduplicate
	local word_set = {}
	for _, words in pairs(source_map) do
		if words then
			for _, word in ipairs(words) do
				if word and word ~= "" then
					word_set[word] = true
				end
			end
		end
	end

	-- Add extra words
	for _, word in ipairs(extra_words) do
		if word and word ~= "" then
			word_set[word] = true
		end
	end

	-- Build ignore set for O(1) lookup
	local ignore_set = {}
	for _, pattern in ipairs(ignore) do
		ignore_set[pattern] = true
	end

	-- Build sorted word list, excluding ignored words
	local words = {}
	for word in pairs(word_set) do
		if not ignore_set[word] then
			table.insert(words, word)
		end
	end
	table.sort(words)

	-- Write words to a portable temp file
	local wordfile = vim.fn.tempname() .. ".lst"
	local open_wordfile, open_err = io.open(wordfile, "w")
	if not open_wordfile then
		vim.notify(
			"nvimwordlist: Failed to open temp file: " .. (open_err or "unknown error"),
			vim.log.levels.ERROR
		)
		return
	end
	for _, word in ipairs(words) do
		open_wordfile:write(word .. "\n")
	end
	open_wordfile:close()

	-- Determine the writable spell directory
	local ok, spelldir = pcall(vim.call, "spellfile#WritableSpellDir")
	if not ok or not spelldir or spelldir == "" then
		vim.notify("nvimwordlist: Could not determine spell directory", vim.log.levels.ERROR)
		return
	end

	-- Build the spellfile and report result
	local spell_ok, spell_err = pcall(vim.cmd, "mkspell! " .. spelldir .. "/vim " .. wordfile)
	if not spell_ok then
		vim.notify(
			"nvimwordlist: mkspell! failed: " .. tostring(spell_err),
			vim.log.levels.ERROR
		)
		return
	end

	vim.notify(
		string.format(
			"nvimwordlist: Spellfile updated with %d words at %s/vim.*.spl",
			#words,
			spelldir
		),
		vim.log.levels.INFO
	)
end

return M
