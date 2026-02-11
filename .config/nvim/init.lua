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
source_lua("init/first.lua")

-- Filetypes
source_lua("init/filetypes/add.lua")

-- Plugins
source_lua("init/plugins/do_not_load_built_in.lua")
source_lua("init/plugins/load_built_in.lua")
source_vim("init/plugins/add.vim")
source_lua("init/plugins/configure_via_global_vars.lua")
source_lua("init/plugins/configure_via_setup_func.lua")
source_lua("init/plugins/configure_coc.lua")

-- User Commands
source_vim("init/user_commands.lua")

-- Mappings
source_lua("init/mappings/normal_visual_operator.lua")
source_vim("init/mappings/normal_visual_operator.vim")
source_vim("init/mappings/insert_command_line.vim")
source_vim("init/mappings/terminal.vim")

-- Options
source_vim("init/options/basic.vim")
source_vim("init/options/gui.vim")
source_vim("init/options/listchars-fillchars.vim")
source_vim("init/options/wrap.vim")

-- Final
source_vim("init/final.vim")
source_lua("init/final.lua")
