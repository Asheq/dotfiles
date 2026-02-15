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
source_lua("init/mappings/set_mapleader.lua")

-- Plugins
source_lua("init/plugins/configure_via_global_vars.lua")
source_lua("init/plugins/disable_built_in.lua")
source_lua("init/plugins/load_built_in.lua")
source_vim("init/plugins/add_third_party.vim")
source_lua("init/plugins/configure_via_setup_func.lua")
source_lua("init/plugins/configure_coc.lua")

-- User Commands
source_lua("init/user_commands/add.lua")

-- Mappings
source_lua("init/mappings/add_nxo.lua")
source_lua("init/mappings/add_ci.lua")
source_lua("init/mappings/add_t.lua")

-- Options
source_lua("init/options/set_basic.lua")
source_lua("init/options/set_listchars_fillchars.lua")
source_lua("init/options/set_wrap.lua")

-- Filetype Detection
source_lua("init/ft_detection/add.lua")

-- Autocmds
source_lua("init/autocmds/start_treesitter_on_ft.lua")
source_lua("init/autocmds/highlight_text_on_yank.lua")
source_lua("init/autocmds/override_highlights_on_colorscheme.lua")
source_lua("init/autocmds/show_terminal_prompt_signs.lua")
