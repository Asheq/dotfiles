-- TODO-L: Guard
require("oil").setup({
    default_file_explorer = true,
    view_options = {
        show_hidden = true,
        is_always_hidden = function(name)
            local list = { ".DS_Store", "..", "Icon", ".tmp.driveupload" }
            for _, value in ipairs(list) do
                if name == value then
                    return true
                end
            end
            return false
        end,
    }
})

vim.keymap.set("n", "-", "<CMD>Oil<Return>", { desc = "Open parent directory" })
