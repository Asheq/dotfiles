-- Annotate each terminal prompt with a sign.
--
-- This code was copied directly from :h shell-prompt-signs.
--
-- TODO-L There seems to be a bug in nvim where after you press Ctrl-L to clear
-- the terminal, there are "ghost signs" left behind.
vim.api.nvim_create_autocmd('TermOpen', {
	command = 'setlocal signcolumn=auto',
})
local ns = vim.api.nvim_create_namespace('my.terminal.prompt')
vim.api.nvim_create_autocmd('TermRequest', {
	callback = function(args)
		if string.match(args.data.sequence, '^\027]133;A') then
			local lnum = args.data.cursor[1]
			vim.api.nvim_buf_set_extmark(args.buf, ns, lnum - 1, 0, {
				sign_text = '▶',
				sign_hl_group = 'SpecialChar',
			})
		end
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = {
		'c',
		'css',
		'diff',
		'git_config',
		'html',
		'lua',
		'markdown',
		'markdown_inline',
		'query',
		'regex',
		'tsx',
		'typescript',
		'typescriptreact',
		'vim',
		'vimdoc',
	},
	callback = function() vim.treesitter.start() end,
})
