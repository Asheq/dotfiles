local function override_highlights()
	vim.api.nvim_set_hl(0, "CocMenuSel", { link = "PmenuSel", force = true })

	vim.api.nvim_set_hl(0, "MatchParen", { link = "CocBold", force = true })

	vim.api.nvim_set_hl(0, "WinBar", { link = "StatusLine", force = true })
	vim.api.nvim_set_hl(0, "WinBarNC", { link = "StatusLineNC", force = true })

	vim.api.nvim_set_hl(0, "TabLineSel", { link = "StatusLine", force = true })
	vim.api.nvim_set_hl(0, "TabLine", { link = "StatusLineNC", force = true })

	vim.api.nvim_set_hl(0, "@markup.heading.1.markdown", { link = "CocListBlackYellow", force = true })
	vim.api.nvim_set_hl(0, "@markup.heading.2.markdown", { link = "CocListBlackCyan", force = true })
	vim.api.nvim_set_hl(0, "@markup.heading.3.markdown", { link = "CocListBlackBlue", force = true })
	vim.api.nvim_set_hl(0, "@markup.heading.4.markdown", { link = "CocListBlackWhite", force = true })

	if vim.o.background == "light" then
		vim.api.nvim_set_hl(0, "Visual", { bg = "#bda9b0", force = true })
		vim.api.nvim_set_hl(0, "Substitute", { fg = "#ffffff", bg = "#b16286", force = true })
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "#c6d3cf", force = true })
	elseif vim.o.background == "dark" then
		vim.api.nvim_set_hl(0, "Visual", { bg = "#45353b", force = true })
		vim.api.nvim_set_hl(0, "Substitute", { fg = "#ffffff", bg = "#b16286", force = true })
		vim.api.nvim_set_hl(0, "CursorLine", { bg = "#32413c", force = true })
	end
end

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = override_highlights,
})

override_highlights()
