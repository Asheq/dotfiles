local util = require("util")
local system_calls = require("system_calls")

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
ks({ "n" }, "gh", '`[v`]')

-- Map to Normal Mode Commands (via expression)
-- ============================================================================

-- Scrolling
ks('n', '<C-f>', function()
	local count = vim.fn.winheight(0) - 1
	return count .. "<C-e>"
end, { expr = true })
ks('n', '<C-b>', function()
	local count = vim.fn.winheight(0) - 1
	return count .. "<C-y>"
end, { expr = true })
ks('n', '<C-d>', function()
	local count = math.floor(vim.fn.winheight(0) / 2) - 1
	return count .. "<C-e>"
end, { expr = true })
ks('n', '<C-u>', function()
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

-- Mnemonic: g = get
ks('n', '<C-g><C-g>', '<Cmd>PrintGeneralOptions<CR>')
ks('n', '<C-g><C-b>', '<Cmd>PrintBorderOptions<CR>')
ks('n', '<C-g><C-f>', '<Cmd>PrintFormattingOptions<CR>')
ks('n', '<C-g><C-t>', '<Cmd>PrintIndentingOptions<CR>')
ks('n', '<C-g><C-d>', '<Cmd>PrintFoldingOptions<CR>')

ks("n", "-", "<Cmd>Oil<CR>")

-- Map to Function Calls -> System Commands
-- ============================================================================
-- Open file in VSCode at current line and column
ks("n", "<leader>v", function()
	local file = vim.fn.expand("%")
	local line = vim.fn.line(".")
	local col = vim.fn.col(".")
	system_calls.open_file_in_vscode(file, line, col)
end)

-- Open dictionary for current word or selected text
ks("n", "<leader>d", function()
	local keyword = vim.fn.expand("<cword>")
	system_calls.open_dictionary(keyword)
end)
ks("x", "<leader>d", function()
	local keyword = util.get_selected_text()
	if keyword then
		system_calls.open_dictionary(keyword)
	end
end)

-- Reference
-- ============================================================================
-- Duplicate keys (* = used in mapping already, ! = do not map or map to self only)
--   Normal-mode
--       h!         <Left>*    <C-h>      <BS>*
--       l!         <Right>*   <Space>*
--       j!         <Down>!    <C-j>      <C-n>
--       k!         <Up>!                 <C-p>*
--       <Enter>!              +          <C-m>
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
