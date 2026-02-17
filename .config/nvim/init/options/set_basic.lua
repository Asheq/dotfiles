-- Global
-- ----------------------------------------------------------------------------
vim.opt.tabline = "%!vimrc#get_tabline()"
vim.opt.ruler = false
vim.opt.jumpoptions = "stack"
vim.opt.timeout = false
vim.opt.wrapscan = false
vim.opt.report = 1
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wildcharm = 26
vim.opt.wildignore = ".DS_Store,.tmp.drivedownload,.tmp.driveupload"
vim.opt.guifont = "PragmataPro Mono:h22"
vim.opt.linespace = 5

-- Tab [+ Global]
-- ----------------------------------------------------------------------------
vim.opt.cmdheight = 2

-- Window [+ Global]
-- ----------------------------------------------------------------------------
vim.opt.statusline = "%!vimrc#get_statusline()"
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.conceallevel = 2
vim.opt.smoothscroll = true
vim.opt.foldcolumn = "auto:9"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldtext = ""

-- Buffer [+ Global]
-- ----------------------------------------------------------------------------
vim.opt.spelloptions = "camel,noplainbuffer"
vim.opt.undofile = true
vim.opt.dictionary:append("/usr/share/dict/words")
vim.opt.grepprg = "rg --vimgrep"
