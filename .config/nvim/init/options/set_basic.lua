-- Global
-- ----------------------------------------------------------------------------
vim.opt.ruler = false
vim.opt.timeout = false
vim.opt.wrapscan = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.report = 1
vim.opt.linespace = 5
vim.opt.wildcharm = 26 -- 26 = ASCII decimal value of <C-z> key
vim.opt.jumpoptions = "stack"
vim.opt.guifont = "PragmataPro Mono:h22"
vim.opt.wildignore = ".DS_Store,.tmp.drivedownload,.tmp.driveupload"
vim.opt.tabline = "%{%v:lua.require('lines').get_tabline()%}"
vim.opt.helpheight = 0

-- Tab [+ Global]
-- ----------------------------------------------------------------------------
vim.opt.cmdheight = 2

-- Window [+ Global]
-- ----------------------------------------------------------------------------
vim.opt.list = true
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.smoothscroll = true
vim.opt.conceallevel = 2
vim.opt.colorcolumn:append("+1")
vim.opt.foldtext = ""
vim.opt.foldcolumn = "auto:9"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.statusline = "%{%v:lua.require('lines').get_statusline()%}"

-- Buffer [+ Global]
-- ----------------------------------------------------------------------------
vim.opt.undofile = true
vim.opt.grepprg = "rg --vimgrep"
vim.opt.spelloptions = "camel,noplainbuffer"
vim.opt.spelllang = "en_us"
vim.opt_local.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add"
vim.opt.dictionary:append("/usr/share/dict/words")
