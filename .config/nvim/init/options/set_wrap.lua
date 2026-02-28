-- NOTE: When 'wrap' is enabled and any of 'linebreak', 'breakindent', or
-- 'showbreak' are enabled, there are bugs that sometimes cause:
--
--   1. 'colorcolumn' to be drawn at the wrong column
--
--   2. A hard line break to be created at the wrong column when formatting
--
--   Note that formatting can be triggered explicitly by gq or automatically
--   when inserting text (because 'formatoptions' includes t or a).

vim.opt.wrap = true

vim.opt.linebreak = true
vim.opt.breakindent = true
vim.opt.breakindentopt = "list:-1"
vim.opt.showbreak = "↪"
