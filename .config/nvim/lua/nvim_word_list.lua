local M = {}

local extra_words = {}
local ignore_words = {}

-- Build ignore words set for O(1) lookup
local ignore_words_set = {}
for _, pattern in ipairs(ignore_words) do
	ignore_words_set[pattern] = true
end

function M.update_spell_file()
	local categories = {
		["function"] = function() return vim.fn.getcompletion("", "function") end,
		cmdline = function() return vim.fn.getcompletion("", "cmdline") end,
		color = function() return vim.fn.getcompletion("", "color") end,
		command = function() return vim.fn.getcompletion("", "command") end,
		compiler = function() return vim.fn.getcompletion("", "compiler") end,
		environment = function() return vim.fn.getcompletion("", "environment") end,
		event = function() return vim.fn.getcompletion("", "event") end,
		file_in_path = function() return vim.fn.getcompletion("", "file_in_path") end,
		filetype = function() return vim.fn.getcompletion("", "filetype") end,
		help = function() return vim.fn.getcompletion("", "help") end,
		highlight = function() return vim.fn.getcompletion("", "highlight") end,
		history = function() return vim.fn.getcompletion("", "history") end,
		mapping = function() return vim.fn.getcompletion("", "mapping") end,
		messages = function() return vim.fn.getcompletion("", "messages") end,
		option = function() return vim.fn.getcompletion("", "option") end,
		packadd = function() return vim.fn.getcompletion("", "packadd") end,
		shellcmd = function() return vim.fn.getcompletion("", "shellcmd") end,
		sign = function() return vim.fn.getcompletion("", "sign") end,
		syntime = function() return vim.fn.getcompletion("", "syntime") end,
		var = function() return vim.fn.getcompletion("", "var") end,
	}

	-- Collect words into a set to deduplicate
	local word_set = {}
	for _, get_words in pairs(categories) do
		local words = get_words()
		if words then
			for _, word in ipairs(words) do
				if word and word ~= "" then
					-- Truncate at the first '('
					word = word:match("^([^(]+)") or word
					-- Split on '/' and add each part
					for part in word:gmatch("[^/]+") do
						if part ~= "" and #part > 1 then
							word_set[part] = true
						end
					end
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

	-- Remove ignored words
	local filtered_words = {}
	for word in pairs(word_set) do
		if not ignore_words_set[word] then
			table.insert(filtered_words, word)
		end
	end

	-- Sort words
	table.sort(filtered_words)

	-- Write words to a portable temp file
	local wordfile = vim.fn.tempname() .. ".lst"
	local opened_wordfile, open_err = io.open(wordfile, "w")
	if not opened_wordfile then
		vim.notify(
			"nvim_word_list: Failed to open temp file: " .. (open_err or "unknown error"),
			vim.log.levels.ERROR
		)
		return
	end
	for _, word in ipairs(filtered_words) do
		opened_wordfile:write(word .. "\n")
	end
	opened_wordfile:close()

	-- Determine the writable spell directory
	local ok, spelldir = pcall(vim.call, "spellfile#WritableSpellDir")
	if not ok or not spelldir or spelldir == "" then
		vim.notify("nvim_word_list: Could not determine spell directory", vim.log.levels.ERROR)
		return
	end

	-- Build the spellfile and report result
	local spell_ok, spell_err = pcall(vim.cmd, "mkspell! " .. spelldir .. "/vim " .. wordfile)
	if not spell_ok then
		vim.notify(
			"nvim_word_list: mkspell! failed: " .. tostring(spell_err),
			vim.log.levels.ERROR
		)
		return
	end

	vim.notify(
		string.format(
			"nvim_word_list: Spellfile updated with %d words at %s/vim.*.spl",
			#filtered_words,
			spelldir
		),
		vim.log.levels.INFO
	)
end

return M
