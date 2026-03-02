local hi = vim.api.nvim_set_hl

local function on_background_change()
	if vim.o.background == "light" then
		hi(0, "Visual", { bg = "#bda9b0", force = true })
		hi(0, "Substitute", { fg = "#ffffff", bg = "#b16286", force = true })
		hi(0, "CursorLine", { bg = "#c6d3cf", force = true })

		-- TODO
		-- hi(0, "DiffAdd", { bg = "#c6d3cf", force = true })
		-- hi(0, "DiffChange", { bg = "#bda9b0", force = true })
	else
		hi(0, "Visual", { bg = "#45353b", force = true })
		hi(0, "Substitute", { fg = "#ffffff", bg = "#b16286", force = true })
		hi(0, "CursorLine", { bg = "#32413c", force = true })

		-- TODO
		-- hi(0, "DiffAdd", { bg = "#32413c", force = true })
		-- hi(0, "DiffChange", { bg = "#45353b", force = true })
	end
end

local function on_colorscheme_change()
	hi(0, "CocMenuSel", { link = "PmenuSel", force = true })

	hi(0, "MatchParen", { link = "CocBold", force = true })

	hi(0, "WinBar", { link = "StatusLine", force = true })
	hi(0, "WinBarNC", { link = "StatusLineNC", force = true })

	hi(0, "TabLineSel", { link = "StatusLine", force = true })
	hi(0, "TabLine", { link = "StatusLineNC", force = true })

	hi(0, "@markup.heading.1.markdown", { link = "CocListBlackYellow", force = true })
	hi(0, "@markup.heading.2.markdown", { link = "CocListBlackCyan", force = true })
	hi(0, "@markup.heading.3.markdown", { link = "CocListBlackBlue", force = true })
	hi(0, "@markup.heading.4.markdown", { link = "CocListBlackWhite", force = true })

	on_background_change()
end

vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = on_background_change,
})

vim.api.nvim_create_autocmd("ColorScheme", {
	callback = on_colorscheme_change,
})

on_colorscheme_change()
