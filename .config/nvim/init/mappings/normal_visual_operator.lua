local util = require("util")
local system_calls = require("system_calls")
local print_options = require("print_stuff.options")

local ks = vim.keymap.set

-- Map to Normal Mode Commands
-- ============================================================================

-- Fold
ks("n", "<Left>", "zc")
ks("n", "<S-Left>", "zC")
ks("n", "<Right>", "zo")
ks("n", "<S-Right>", "zO")

-- Yank and Put
ks({ "n", "x" }, "<leader>y", '"*y')
ks({ "n", "x" }, "<leader>Y", '"*Y', { remap = true })
ks({ "n", "x" }, "<leader>p", '"*p')
ks({ "n", "x" }, "<leader>P", '"*P')

-- Visually select previously changed/yanked text
-- Mnemonic: gh = go highlight
ks({ "n" }, "gh", "`[v`]")

-- Map to Normal Mode Commands (via expr)
-- ============================================================================

-- Scrolling
ks("n", "<C-f>", function()
	local count = vim.fn.winheight(0) - 1
	return count .. "<C-e>"
end, { expr = true })
ks("n", "<C-b>", function()
	local count = vim.fn.winheight(0) - 1
	return count .. "<C-y>"
end, { expr = true })
ks("n", "<C-d>", function()
	local count = math.floor(vim.fn.winheight(0) / 2) - 1
	return count .. "<C-e>"
end, { expr = true })
ks("n", "<C-u>", function()
	local count = math.floor(vim.fn.winheight(0) / 2) - 1
	return count .. "<C-y>"
end, { expr = true })

-- Map to Partial Ex Commands
-- ============================================================================

-- Mnemonic: c = chat
ks({ "n", "x" }, "<leader>c", ":CopilotChat<C-z><C-p>")

-- Mnemonic: g = grep
ks("n", "<leader>g", ":sil gr!  | tab cw<S-Left><S-Left><S-Left><Left>")

-- Mnemonic: r = redirect
ks("n", "<leader>r", ":redi @r | sil  | redi END<S-Left><S-Left><S-Left><Left>")

-- Mnemonic: t = tab
ks("n", "<leader>t", ":tab<C-z><C-p>")

-- Mnemonic: yp = yank path
ks("n", "yp", ":ec \"p = full path\\nh = head\\nt = tail\\n\"<CR>:let @* = expand('%:')<Left><Left>")

-- Map to Full Ex Commands
-- ============================================================================
-- Mnemonic: j = jumps
ks("n", "<leader>j", "<Cmd>jumps<CR>")

-- Mnemonic: o = open
ks("n", "<leader>o", "<Cmd>Open %:h<CR>")

-- Mnemonic: s = status
ks("n", "<leader>s", "<Cmd>Git<CR>")

-- Mnemonic: w = write
ks("n", "<leader>w", "<Cmd>silent update<CR>")

ks("n", "-", "<Cmd>Oil<CR>")

-- Map to System Calls
-- ============================================================================
-- Open current file in VSCode
ks("n", "<leader>v", system_calls.open_curr_file_in_vscode)

-- Open dictionary
ks("n", "<leader>d", function()
	system_calls.open_dictionary(vim.fn.expand("<cword>"))
end)
ks("x", "<leader>d", function()
	system_calls.open_dictionary(util.get_selected_text())
end)

-- Browser search
ks("n", "<leader>b", function()
	system_calls.browser_search(vim.fn.expand("<cword>"))
end)
ks("x", "<leader>b", function()
	system_calls.browser_search(util.get_selected_text())
end)

-- Speak
vim.keymap.set("n", "<leader><Left>", function()
	system_calls.change_speech_rate(-50)
end)
vim.keymap.set("n", "<leader><Right>", function()
	system_calls.change_speech_rate(50)
end)
-- Mnemonic: k = speaK
vim.keymap.set("n", "<leader>k", function()
	system_calls.speak(vim.fn.getline("."))
end)
vim.keymap.set("x", "<leader>k", function()
	system_calls.speak(util.get_selected_text())
end)

-- Map to Other Lua Functions
-- ============================================================================
-- Mnemonic: g = get
ks("n", "<C-g><C-g>", print_options.print_general)
ks("n", "<C-g><C-b>", print_options.print_border)
ks("n", "<C-g><C-f>", print_options.print_formatting)
ks("n", "<C-g><C-t>", print_options.print_indenting)
ks("n", "<C-g><C-d>", print_options.print_folding)

-- Reference
-- ============================================================================
-- Duplicate keys (* = used in mapping already, ! = do not map or map to self only)
--   Normal-mode
--       h!         <Left>*    <C-h>      <BS>*
--       l!         <Right>*   <Space>*
--       j!         <Down>!    <C-j>      <C-n>
--       k!         <Up>!                 <C-p>
--       <Enter>!   +          <C-m>
--       cc!        S
--   Visual-mode(char)
--       d!         x
--       D!         X
--       c!         s*
--       C!         S
--   Visual-mode (line)
--       d!         x        X          D
--       c!         s*
--       C!         S
--   Visual-mode (block)
--       d!         x        X
--       c!         s*
