-- listchars
-- ----------------------------------------------------------------------------
vim.opt.list = true
vim.opt.listchars = "tab:│ ,lead:࿁,nbsp:▢,trail:࿁,extends:➤,precedes:⮜"

-- NOTE: I am setting the value of "leadmultispace" within 'listchars' in an
-- autocommand below, since it depends on the value of 'tabstop' which could be
-- different for different buffers and can change on the fly.
local function set_listchars()
	---@diagnostic disable-next-line: undefined-field
	local lcs = vim.opt.listchars:get()
	lcs.leadmultispace = "┊" .. string.rep(" ", vim.opt.tabstop:get() - 1)
	vim.opt_local.listchars = lcs
end

local group = vim.api.nvim_create_augroup("set_listchars", { clear = true })
vim.api.nvim_create_autocmd("OptionSet", {
	group = group,
	pattern = "tabstop",
	callback = set_listchars,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
	group = group,
	callback = set_listchars,
})

set_listchars()

-- fillchars
-- ----------------------------------------------------------------------------
vim.opt.fillchars = "foldopen:▽,foldclose:▶,diff:╱,lastline:➤"
