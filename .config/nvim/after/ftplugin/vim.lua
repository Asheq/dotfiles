local config_path = vim.fn.stdpath("config")

vim.opt_local.spell = true
vim.opt_local.spelllang:append("vim")
vim.opt_local.spellfile = {
	config_path .. "/spell/programming.utf-8.add",
	config_path .. "/spell/en.utf-8.add"
}
