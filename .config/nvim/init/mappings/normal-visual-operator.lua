-- TODO: After autoload/vimrc.vim is migrated to lua, make sure calls here are updated

local ks = vim.keymap.set

-- Type Ex Commands Partially (to allow editing before execution)
-- ============================================================================

ks("n", "<leader>g", ":sil gr!  <Bar> tab cw<S-Left><S-Left><S-Left><Left>")

ks("n", "<leader>r", ":redi @r <Bar> sil  <Bar> redi END<S-Left><S-Left><S-Left><Left>")

ks("n", "<leader>t", ":tab<C-z><C-p>")

ks("n", "<leader>c", ":CopilotChat<C-z><C-p>")
ks("x", "<leader>c", ":CopilotChat<C-z><C-p>")

ks("n", "yp", ":ec \"p = full path\\nh = head\\nt = tail\\n\"<Enter>:let @* = expand('%:')<Left><Left>")

-- Execute Full Ex Commands
-- ============================================================================
ks("n", "<leader>s", "<Cmd>Git<CR>")

ks("n", "<leader>w", "<Cmd>silent update<CR>")

ks("n", "<leader>j", "<Cmd>jumps<CR>")

ks("n", "-", "<CMD>Oil<CR>")

-- Open External GUI Applications
-- ============================================================================
-- Open Mac OS file explorer at current file's directory
ks("n", "<leader>o", function()
	vim.system({ "open", vim.fn.expand("%:h") }, { detach = true })
end)

-- Open current file in VS Code at current line and column
ks("n", "<leader>v", function()
	local file = vim.fn.expand("%")
	local line = vim.fn.line(".")
	local col = vim.fn.col(".")
	vim.system({ "code", "--goto", string.format("%s:%d:%d", file, line, col) }, { detach = true })
end)

-- Execute Built-in Normal Mode Commands with Enhancements
-- ============================================================================
ks("n", "<C-g>", function()
	vim.fn["vimrc#ctrl_g_with_scrollbar"]()
end)
