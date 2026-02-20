local config_path = vim.fn.stdpath("config")

---@param rel_path string
local function source_vim(rel_path)
	vim.cmd("source " .. vim.fn.fnameescape(config_path .. "/" .. rel_path))
end

---@param rel_path string
local function source_lua(rel_path)
	dofile(config_path .. "/" .. rel_path)
end

-- First
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", force = true })
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Plugins
source_lua("init/plugins/configure_via_global_vars.lua")
source_lua("init/plugins/disable_built_in.lua")
source_lua("init/plugins/load_built_in.lua")
source_vim("init/plugins/add_third_party.vim")
source_lua("init/plugins/configure_via_setup_func.lua")
source_lua("init/plugins/configure_coc.lua")

-- Mappings
source_lua("init/mappings/add_nxo.lua")
source_lua("init/mappings/add_ci.lua")
source_lua("init/mappings/add_t.lua")

-- Options
source_lua("init/options/set_basic.lua")
source_lua("init/options/set_listchars_fillchars.lua")
source_lua("init/options/set_wrap.lua")

-- Highlighting
source_lua("init/highlighting/highlight_yank.lua")
source_lua("init/highlighting/start_treesitter_highlighting.lua")
source_lua("init/highlighting/override_highlights.lua")

-- User Commands
source_lua("init/user_commands/add.lua")

-- Filetype Detection
source_lua("init/ft_detection/add.lua")

-- Other
source_lua("init/other/show_prompt_signs_in_terminal.lua")
