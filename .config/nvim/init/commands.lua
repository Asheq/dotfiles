local options = require("print_stuff.options")

vim.api.nvim_create_user_command("PrintGeneralOptions", options.print_general, {})
vim.api.nvim_create_user_command("PrintFormattingOptions", options.print_formatting, {})
vim.api.nvim_create_user_command("PrintIndentingOptions", options.print_indenting, {})
vim.api.nvim_create_user_command("PrintFoldingOptions", options.print_folding, {})
vim.api.nvim_create_user_command("PrintBorderOptions", options.print_border, {})
