-- This file was originally inspired by:
-- https://github.com/jesse-c/dotfiles/blob/main/home/dot_hammerspoon/appearance.lua
-- NOTE: It used to contain code to auto-change the display mode for kitty
-- until that became built into kitty itself.

local function map(tbl, func)
    local result = {}
    for key, val in pairs(tbl) do
        result[key] = func(val)
    end
    return result
end

local function split(str, delimiter)
    local result = {}
    for match in (str):gmatch('(.-)' .. delimiter) do
        table.insert(result, match)
    end
    return result
end

local function isDarkModeEnabled()
    local _, result = hs.osascript.javascript([[ Application('System Events').appearancePreferences.darkMode() ]])

    -- If result is nil, cast to false
    return result == true
end

local function getNvimCommand(darkModeEnabled)
    local nvimBg
    if darkModeEnabled then
        nvimBg = 'dark'
    else
        nvimBg = 'light'
    end

    local serverAddressesString = hs.execute('/opt/homebrew/bin/nvr --serverlist')
    local serverAddresses = split(serverAddressesString, '\n')
    local commands = map(serverAddresses,
        function(serverAddress)
            return '/opt/homebrew/bin/nvim --remote-send "<Esc>:set bg=' ..
                nvimBg .. '<Enter>" --server "' .. serverAddress .. '"'
        end)
    return table.concat(commands, ' & ') .. ' &'
end

local function executeCommand(command)
    print('Executing command: ' .. command)

    local output, status, type, rc = hs.execute(command)

    print('output: ' .. output)
    print('status: ' .. tostring(status))
    print('type: ' .. type)
    print('rc: ' .. rc)
end

local respondToThemeChange = function()
    local darkModeEnabled = isDarkModeEnabled()
    print('Theme changed. Dark mode enabled: ' .. tostring(darkModeEnabled))
    executeCommand(getNvimCommand(darkModeEnabled))
end

local notificationName = 'AppleInterfaceThemeChangedNotification'
local themeChangeWatcher = hs.distributednotifications.new(respondToThemeChange, notificationName, nil)
themeChangeWatcher:start()
