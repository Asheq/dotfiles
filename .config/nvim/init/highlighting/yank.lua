vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({ higroup = "IncSearch", timeout = 300, on_visual = true })
	end
})
