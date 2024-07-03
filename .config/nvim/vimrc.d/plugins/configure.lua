-- TODO-L: Guard
require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<Return>", { desc = "Open parent directory" })
