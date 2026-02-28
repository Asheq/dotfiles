local config_path = vim.fn.stdpath("config")

vim.opt_local.spell = true
vim.opt_local.spelllang:append("vim")
vim.opt_local.spellfile:append(config_path .. "/spell/programming.utf-8.add")
