local vimrc = require("vimrc")

local ks = vim.keymap.set

-- Map to Normal Mode Commands
-- ============================================================================

-- Fold
ks("n", "<Left>", "zc")
ks("n", "<S-Left>", "zC")
ks("n", "<Right>", "zo")
ks("n", "<S-Right>", "zO")

-- Visually select previously changed/yanked text
-- Mnemonic: g = go highlight
ks({ "n" }, "gh", '`[v`]')

-- Yank and Put
ks({ "n", "x" }, "<leader>y", '"*y')
ks({ "n", "x" }, "<leader>Y", '"*Y', { remap = true })
ks({ "n", "x" }, "<leader>p", '"*p')
ks({ "n", "x" }, "<leader>P", '"*P')

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

ks('n', '<C-g><C-g>', '<Cmd>PrintGeneralOptions<CR>')
ks('n', '<C-g><C-b>', '<Cmd>PrintBorderOptions<CR>')
ks('n', '<C-g><C-f>', '<Cmd>PrintFormattingOptions<CR>')
ks('n', '<C-g><C-t>', '<Cmd>PrintIndentingOptions<CR>')
ks('n', '<C-g><C-d>', '<Cmd>PrintFoldingOptions<CR>')

ks("n", "-", "<Cmd>Oil<CR>")

-- Map to System Commands
-- ============================================================================
ks("n", "<leader>v", function()
	local file = vim.fn.expand("%")
	local line = vim.fn.line(".")
	local col = vim.fn.col(".")
	vim.system({ "code", "--goto", string.format("%s:%d:%d", file, line, col) }, { detach = true })
end)

-- Map to ???
-- ============================================================================
-- View definition
ks("n", "<leader>d", function()
	vimrc.define(vim.fn.expand("<cword>"))
end, { silent = true })

ks("x", "<leader>d", function()
	vimrc.define(vimrc.get_selection_text())
end, { silent = true })

-- Map to feedkeys
-- ============================================================================
-- Improved, consistent scrolling
local ctrl_e = vim.api.nvim_replace_termcodes('<C-e>', true, false, true)
local ctrl_y = vim.api.nvim_replace_termcodes('<C-y>', true, false, true)
ks('n', '<C-f>', function()
	local count = vim.fn.winheight(0) - 1
	vim.api.nvim_feedkeys(count .. ctrl_e, 'n', false)
end)
ks('n', '<C-b>', function()
	local count = vim.fn.winheight(0) - 1
	vim.api.nvim_feedkeys(count .. ctrl_y, 'n', false)
end)
ks('n', '<C-d>', function()
	local count = math.floor(vim.fn.winheight(0) / 2) - 1
	vim.api.nvim_feedkeys(count .. ctrl_e, 'n', false)
end)
ks('n', '<C-u>', function()
	local count = math.floor(vim.fn.winheight(0) / 2) - 1
	vim.api.nvim_feedkeys(count .. ctrl_y, 'n', false)
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
