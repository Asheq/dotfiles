-- Global
-- ----------------------------------------------------------------------------
-- Boolean
vim.opt.exrc = true
vim.opt.ruler = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.timeout = false
vim.opt.wrapscan = false
-- Number
vim.opt.helpheight = 0
vim.opt.report = 1
vim.opt.wildcharm = 26 -- 26 = ASCII decimal value of <C-z> key
-- String
vim.opt.guifont = "PragmataPro Mono:h22"
vim.opt.jumpoptions = "stack"
vim.opt.tabline = "%{%v:lua.require('lines').get_tabline()%}"
vim.opt.wildignore = ".DS_Store,.tmp.drivedownload,.tmp.driveupload"

-- Tab [+ Global]
-- ----------------------------------------------------------------------------
-- Number
vim.opt.cmdheight = 2

-- Window [+ Global]
-- ----------------------------------------------------------------------------
-- Boolean
vim.opt.cursorline = true
vim.opt.list = true
vim.opt.number = true
vim.opt.smoothscroll = true
-- Number
vim.opt.conceallevel = 2
-- String
vim.opt.foldcolumn = "auto:5"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldmethod = "expr"
vim.opt.foldtext = ""
vim.opt.signcolumn = "auto:5"
vim.opt.statusline = "%{%v:lua.require('lines').get_statusline()%}"

-- Buffer [+ Global]
-- ----------------------------------------------------------------------------
-- Boolean
vim.opt.undofile = true
-- String
vim.opt.dictionary:append("/usr/share/dict/words")
vim.opt.grepprg = "rg --vimgrep"
vim.opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel,noplainbuffer"
