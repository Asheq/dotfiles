-- NOTE: When wrap is enabled and any of linebreak, breakindent, or showbreak
-- are enabled, there are bugs that sometimes cause:
--
--   1. colorcolumn to be drawn at the wrong column
--
--   2. a hard line break to be created at the wrong column when formatting
--      with gq or when auto-format executes during typing (because 'fo'
--      includes t or a)

vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.breakindentopt = "list:-1"
vim.opt.showbreak = "↪"

vim.opt.colorcolumn:append("+1")
