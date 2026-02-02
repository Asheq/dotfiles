local config = vim.fn.stdpath("config")

local function source_vim(relpath)
	vim.cmd("source " .. vim.fn.fnameescape(config .. "/" .. relpath))
end

local function source_lua(relpath)
	dofile(config .. "/" .. relpath)
end

-- First
source_lua("init/first.lua")

-- Filetypes
source_lua("init/filetypes/add.lua")

-- Plugins
source_lua("init/plugins/do-not-load-built-in.lua")
source_lua("init/plugins/load-built-in.lua")
source_vim("init/plugins/add.vim")
source_lua("init/plugins/configure-via-global-vars.lua")
source_lua("init/plugins/configure-via-setup-func.lua")
source_lua("init/plugins/configure-coc.lua")

-- Mappings
source_lua("init/mappings/normal-visual-operator.lua")
source_vim("init/mappings/normal-visual-operator.vim")
source_vim("init/mappings/insert-command_line.vim")
source_vim("init/mappings/terminal.vim")

-- Options
source_vim("init/options.vim")

-- Final
source_vim("init/final.vim")
