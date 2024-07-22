-- TODO-L: Guard
require("oil").setup({
    default_file_explorer = true,
    view_options = {
        show_hidden = true,
        is_always_hidden = function(name)
            if name == ".DS_Store" then
                return true
            end
            if name == ".." then
                return true
            end
            return false
        end,
    }
})

vim.keymap.set("n", "-", "<CMD>Oil<Return>", { desc = "Open parent directory" })
