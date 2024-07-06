-- This file was originally inspired by: https://github.com/jesse-c/dotfiles/blob/main/home/dot_hammerspoon/appearance.lua
-- TODO: Do not require passing full paths to shell commands like `kitty`, `nvr`, and `nvim`

local function map(table, func)
    local result = {}
    for key, val in pairs(table) do
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
    local _, res = hs.osascript.javascript([[
    Application('System Events').appearancePreferences.darkMode()
  ]])

    -- NOTE: Getting nil here sometimes
    return res == true
end

local function getKittyCommand(darkModeEnabled)
    local gruvboxTheme
    if darkModeEnabled then
        gruvboxTheme = 'Dark'
    else
        gruvboxTheme = 'Light'
    end

    return
        '/Applications/kitty.app/Contents/MacOS/kitty +kitten themes --config-file-name=theme.conf --reload-in=all Gruvbox ' ..
        gruvboxTheme
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
                nvimBg .. '<CR>" --server "' .. serverAddress .. '"'
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
    executeCommand(getKittyCommand(darkModeEnabled))
    executeCommand(getNvimCommand(darkModeEnabled))
end

local notificationName = 'AppleInterfaceThemeChangedNotification'
local themeChangeWatcher = hs.distributednotifications.new(respondToThemeChange, notificationName, nil)
themeChangeWatcher:start()
