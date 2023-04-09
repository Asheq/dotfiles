-- require("github-theme").setup({
--   theme_style = "light",
--   hide_inactive_statusline = false,
--   dark_float = true,
--   overrides = function(c)
--     return {
--       DiffText = { fg = c.diff.change, bg = c.diff.change_fg },
--     }
--   end
-- })

require("colorizer").setup()

require('neorg').setup({
    load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.norg.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.norg.dirman"] = { -- Manages Neorg workspaces
            config = {
                workspaces = {
                    notes = "~/notes",
                },
                default_workspace = "notes",
            },
        },
    },
})
