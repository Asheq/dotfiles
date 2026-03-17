local util = require("util")
local system_calls = require("system_calls")
local print_options = require("print.options")

-- Helpers
-- ============================================================================

local ks = vim.keymap.set

local function ks_group(maps)
	for _, map in ipairs(maps) do
		local mode = map[1]
		local lhs = map[2]
		local rhs = map[3]
		local opts = map[4] or {}
		ks(mode, lhs, rhs, opts)
	end
end

-- Map to Strings
-- ============================================================================

-- Map to Normal Mode Commands
-- ----------------------------------------------------------------------------
-- Fold
ks_group({
	{ "n", "<Left>",    "zc" },
	{ "n", "<S-Left>",  "zC" },
	{ "n", "<Right>",   "zo" },
	{ "n", "<S-Right>", "zO" }
})

-- Yank and Put
ks_group({
	{ { "n", "x" }, "<leader>y", '"*y' },
	{ { "n", "x" }, "<leader>Y", '"*Y', { remap = true } },
	{ { "n", "x" }, "<leader>p", '"*p' },
	{ { "n", "x" }, "<leader>P", '"*P' }
})

-- Visually select previously changed/yanked text
-- Mnemonic: gh = go highlight
ks({ "n" }, "gh", "`[v`]")

-- Map to <Plug>
-- -----------------------------------------------------------------------------
ks_group({
	{ { "n", "x", "o" }, "[a",    "<Plug>(IndentWiseBlockScopeBoundaryBegin)", { remap = true } },
	{ { "n", "x", "o" }, "]a",    "<Plug>(IndentWiseBlockScopeBoundaryEnd)",   { remap = true } },
	{ { "n", "x", "o" }, "<A-h>", "<Plug>(IndentWisePreviousLesserIndent)",    { remap = true } },
	{ { "n", "x", "o" }, "<A-l>", "<Plug>(IndentWiseNextGreaterIndent)",       { remap = true } },
	{ { "n", "x", "o" }, "<A-j>", "<Plug>(NavigateBlockDown)",                 { remap = true } },
	{ { "n", "x", "o" }, "<A-k>", "<Plug>(NavigateBlockUp)",                   { remap = true } },
})

-- Map to Partial Ex Commands
-- ---------------------------------------------------------------------------
-- Mnemonic:
-- c = chat
-- g = grep
-- l = lgrep
-- r = redirect
-- t = tab
ks_group({
	{ { "n", "x" }, "<leader>c", ":CopilotChat<C-z><C-p>" },
	{ "n",          "<leader>g", ":sil gr!  | bot cw<S-Left><S-Left><S-Left><Left>" },
	{ "n",          "<leader>l", ":sil lgr!  | lw<S-Left><S-Left><Left>" },
	{ "n",          "<leader>r", ":redi @r | sil  | redi END<S-Left><S-Left><S-Left><Left>" },
	{ "n",          "<leader>t", ":tab<C-z><C-p>" },
})

-- Map to Full Ex Commands
-- ---------------------------------------------------------------------------
-- Mnemonic:
-- j = jumps
-- o = open
-- s = status
-- w = write
ks_group({
	{ "n", "<leader>j", "<Cmd>jumps<CR>" }, -- TODO: Use vim.ui.select to select jump
	{ "n", "<leader>o", "<Cmd>Open %:h<CR>" },
	{ "n", "<leader>s", "<Cmd>Git<CR>" },
	{ "n", "<leader>w", "<Cmd>silent update<CR>" }
})

ks_group({
	{ "n", "-",       "<Cmd>Oil<CR>" },
	{ "n", "<Esc>",   "<Cmd>pwd<CR>" },
	{ "n", "<S-Esc>", "<Cmd>file<CR>" },
})

-- Map to Lua Functions
-- ============================================================================

-- Map to Normal Mode Commands (via expression)
-- ----------------------------------------------------------------------------

-- Scrolling
ks_group({
	{ "n", "<C-f>", function() return (vim.fn.winheight(0) - 1) .. "<C-e>" end,               { expr = true } },
	{ "n", "<C-b>", function() return (vim.fn.winheight(0) - 1) .. "<C-y>" end,               { expr = true } },
	{ "n", "<C-d>", function() return math.floor(vim.fn.winheight(0) / 2) - 1 .. "<C-e>" end, { expr = true } },
	{ "n", "<C-u>", function() return math.floor(vim.fn.winheight(0) / 2) - 1 .. "<C-y>" end, { expr = true } }
})

-- Map to Partial Ex Commands
-- ---------------------------------------------------------------------------
-- Mnemonic: yp = yank path
ks("n", "yp", function()
	-- Hint lines showing the modifier options the user can type
	local hint = {
		" p   = full path ",
		" p:. = from CWD ",
		" h   = head ",
		" t   = tail ",
	}

	-- Create a scratch buffer (not listed, not a real file)
	local buf = vim.api.nvim_create_buf(false, true)

	-- Put the hint text into the buffer
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, hint)

	local width = 0
	for _, line in ipairs(hint) do
		width = math.max(width, #line)
	end

	-- Open a floating window to display the hint near the bottom of the screen
	local win = vim.api.nvim_open_win(buf, false, {
		relative = "editor", -- position relative to the whole editor
		row = vim.o.lines, -- as close to the bottom as possible
		col = 0,       -- left edge
		width = width, -- just wide enough for the hint text
		height = #hint, -- one line per modifier
		style = "minimal", -- no line numbers, statusline, etc.
		border = "rounded", -- rounded border
	})

	-- Set up a one-shot autocommand: when the user leaves the command line
	-- (either by pressing Enter or Escape), close the floating window
	vim.api.nvim_create_autocmd("CmdlineLeave", {
		once = true,
		callback = function()
			if vim.api.nvim_win_is_valid(win) then
				vim.api.nvim_win_close(win, true)
			end
		end,
	})

	-- Translate <Left> from its string name to the actual key code
	local LEFT = vim.api.nvim_replace_termcodes("<Left>", true, false, true)

	-- Feed keystrokes to open the command line with:
	--   :let @* = expand('%:')
	-- then press Left twice to position the cursor where a modifier can be
	-- entered.
	vim.api.nvim_feedkeys(":let @* = expand('%:')" .. LEFT .. LEFT, "n", false)
end)

ks("n", "<leader>h", function()
	local output = vim.api.nvim_exec2("chistory", { output = true }).output
	local lines = vim.split(output, "\n", { trimempty = true })

	vim.ui.select(lines, { prompt = "Quickfix History:" }, function(_, idx)
		if idx then
			vim.cmd("chistory " .. idx)
		end
	end)
end)

-- Map to System Calls
-- ----------------------------------------------------------------------------
ks_group({
	-- Open current file in VSCode
	{ "n", "<leader>v",       system_calls.open_curr_file_in_vscode },

	-- Open dictionary
	{ "n", "<leader>d",       function() system_calls.open_dictionary(vim.fn.expand("<cword>")) end },
	{ "x", "<leader>d",       function() system_calls.open_dictionary(util.get_selected_text()) end },

	-- Browser search
	{ "n", "<leader>b",       function() system_calls.browser_search(vim.fn.expand("<cword>")) end },
	{ "x", "<leader>b",       function() system_calls.browser_search(util.get_selected_text()) end },

	-- Change speech rate
	{ "n", "<leader><Left>",  function() system_calls.change_speech_rate(-50) end },
	{ "n", "<leader><Right>", function() system_calls.change_speech_rate(50) end },

	-- Speak
	-- Mnemonic: k = speaK
	{ "n", "<leader>k",       function() system_calls.speak(vim.fn.getline(".")) end },
	{ "x", "<leader>k", function()
		system_calls.speak(util.get_selected_text())
		local ESC = vim.api.nvim_replace_termcodes("<Esc>", true, false, true)
		vim.api.nvim_feedkeys(ESC, "n", false)
	end }
})

-- Map to Other Lua Functions
-- ---------------------------------------------------------------------------
ks("n", "<C-g>", print_options.select_preset_group)
