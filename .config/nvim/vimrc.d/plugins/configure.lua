local oil_ok, oil = pcall(require, "oil")

if oil_ok then
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

local CopilotChat_ok, CopilotChat = pcall(require, "CopilotChat")

if CopilotChat_ok then
    CopilotChat.setup()
end

local neogit_ok, neogit = pcall(require, "neogit")

if neogit_ok then
    neogit.setup()
    -- neogit.setup({
    --     integrations = {
    --         diffview = 1,
    --     }
    -- })
end
