vim.cmd.highlight("clear")
vim.g.colors_name = "demo"

local hi = vim.api.nvim_set_hl

if vim.o.background == "light" then
	hi(0, "Normal", { fg = "#000000", bg = "#ffffff" })
	hi(0, "Comment", { fg = "purple" })
	hi(0, "Constant", { fg = "#cc0000" })
	hi(0, "Identifier", { fg = "#008800" })
	hi(0, "Statement", { fg = "#0000cc" })
else
	hi(0, "Normal", { fg = "#ffffff", bg = "#000000" })
	hi(0, "Comment", { fg = "orange" })
	hi(0, "Constant", { fg = "#ff0000" })
	hi(0, "Identifier", { fg = "#00ff00" })
	hi(0, "Statement", { fg = "#0000ff" })
end
