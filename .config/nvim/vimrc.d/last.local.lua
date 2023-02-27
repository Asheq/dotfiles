require("github-theme").setup({
  theme_style = "light",
  hide_inactive_statusline = false,
  dark_float = true,
  overrides = function(c)
    return {
      DiffText = { fg = c.diff.change, bg = c.diff.change_fg }
    }
  end
})

require("colorizer").setup()
