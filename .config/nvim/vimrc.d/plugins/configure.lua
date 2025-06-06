local ok, oil = pcall(require, "oil")

if ok then
    oil.setup({
        default_file_explorer = true,
        view_options = {
            show_hidden = true,
            is_always_hidden = function(name)
                local list = { ".DS_Store", "..", ".tmp.driveupload" }
                for _, value in ipairs(list) do
                    if name == value then
                        return true
                    end
                end

                if name:find("^Icon.$") ~= nil then
                    return true
                end

                return false
            end,
        },
        use_default_keymaps = false,
        keymaps = {
            ["g?"] = { "actions.show_help", mode = "n" },
            ["<CR>"] = "actions.select",
            ["<C-s>"] = { "actions.select", opts = { vertical = true } },
            ["<C-h>"] = { "actions.select", opts = { horizontal = true } },
            ["<C-t>"] = { "actions.select", opts = { tab = true } },
            ["<C-p>"] = "actions.preview",
            ["<C-c>"] = { "actions.close", mode = "n" },
            ["-"] = { "actions.parent", mode = "n" },
            ["_"] = { "actions.open_cwd", mode = "n" },
            ["`"] = { "actions.cd", mode = "n" },
            ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
            ["gx"] = "actions.open_external",
            ["g."] = { "actions.toggle_hidden", mode = "n" },
            ["g\\"] = { "actions.toggle_trash", mode = "n" },
            -- ["<C-l>"] = "actions.refresh",
            -- ["gs"] = { "actions.change_sort", mode = "n" },
            ["gs"] = "actions.refresh",
        },
    })

    vim.keymap.set("n", "-", "<CMD>Oil<Return>", { desc = "Open parent directory" })
end
