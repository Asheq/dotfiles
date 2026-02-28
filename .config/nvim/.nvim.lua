vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		vim.opt_local.spelllang:append("vim")
	end,
})

vim.opt.path:append("init/**")
vim.opt.path:append("plugin/**")
vim.opt.path:append("lua/**")
