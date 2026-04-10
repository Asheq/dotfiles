vim.opt_local.spell = true

vim.opt_local.foldtext = vim.opt_global.foldtext:get()

vim.keymap.set("i", "<A-b>", "- [ ] ", { buffer = true })

vim.cmd("silent Hi load bujo-markers.hl")
