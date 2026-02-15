-- Highlight yanked text
-- ============================================================================
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.hl.on_yank({ higroup = "IncSearch", timeout = 300, on_visual = true })
	end,
})

-- Highlight Overrides
-- ============================================================================
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

local function on_bg_change()
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

vim.api.nvim_create_autocmd("OptionSet", {
	pattern = "background",
	callback = on_bg_change,
})
on_bg_change()

-- Annotate each terminal prompt with a sign.
--
-- This code was copied directly from :h shell-prompt-signs.

-- TODO-L There seems to be a bug in nvim where after you press Ctrl-L to clear
-- the terminal, there are "ghost signs" left behind.
vim.api.nvim_create_autocmd("TermOpen", {
	command = "setlocal signcolumn=auto",
})
local ns = vim.api.nvim_create_namespace("my.terminal.prompt")
vim.api.nvim_create_autocmd("TermRequest", {
	callback = function(args)
		if string.match(args.data.sequence, "^\027]133;A") then
			local lnum = args.data.cursor[1]
			vim.api.nvim_buf_set_extmark(args.buf, ns, lnum - 1, 0, {
				sign_text = "▶",
				sign_hl_group = "SpecialChar",
			})
		end
	end,
})
