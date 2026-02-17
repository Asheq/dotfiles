-- Buffer-local variable
vim.b.demo_var_lua = "This is b:demo_var_lua"

-- Global Lua function
_G.DemoFuncLua = function()
	print("Hello from DemoFuncLua()")
end

-- Window-local option
vim.opt_local.scrolloff = 5

-- Buffer-local mapping
vim.keymap.set('n', '<leader>bl', function()
	require('demo').hello()
end, { buffer = true })

-- Buffer-local user command
vim.api.nvim_buf_create_user_command(0, 'DemoCmdLua', function()
	print("Hello from :DemoCmdLua")
end, {})

-- Undo ftplugin
local undo_commands = 'lua ' .. table.concat({
	'vim.b.demo_var_lua = nil',
	'_G.DemoFuncLua = nil',
	'pcall(vim.cmd, "setl scrolloff<")',
	'pcall(vim.keymap.del, "n", "<leader>bl", { buffer = true })',
	'pcall(vim.api.nvim_buf_del_user_command, 0, "DemoCmdLua")',
}, '; ')

if vim.b.undo_ftplugin then
	vim.b.undo_ftplugin = vim.b.undo_ftplugin .. ' | ' .. undo_commands
else
	vim.b.undo_ftplugin = undo_commands
end
