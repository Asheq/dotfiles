-- This file was originally inspired by: https://github.com/jesse-c/dotfiles/blob/main/home/dot_hammerspoon/appearance.lua
-- TODO: Do not require passing full paths to shell commands like `kitty`, `nvr`, and `nvim`

local function map(tbl, func)
    local newTbl = {}
    for k, v in pairs(tbl) do
        newTbl[k] = func(v)
    end
    return newTbl
end

local function splitString(inputStr, delimiter)
    local result = {}
    for match in (inputStr):gmatch("(.-)" .. delimiter) do
        table.insert(result, match)
    end
    return result
end

local function isDarkModeEnabled()
    local _, res = hs.osascript.javascript([[
    Application("System Events").appearancePreferences.darkMode()
  ]])

    return res == true -- getting nil here sometimes
end

local function buildKittyCommand(isDarkMode)
    local gruvboxTheme

    if isDarkMode then
        gruvboxTheme = "Dark"
    else
        gruvboxTheme = "Light"
    end

    return
        "/Applications/kitty.app/Contents/MacOS/kitty +kitten themes --config-file-name=theme.conf --reload-in=all Gruvbox " ..
        gruvboxTheme
end

local function buildNvimCommand(isDarkMode)
    local nvimBg

    if isDarkMode then
        nvimBg = "dark"
    else
        nvimBg = "light"
    end

    local serverAddressesString = hs.execute("/opt/homebrew/bin/nvr --serverlist")
    local serverAddresses = splitString(serverAddressesString, "\n")
    local shellCommands = map(serverAddresses,
        function(serverAddress)
            return '/opt/homebrew/bin/nvim --remote-send "<Esc>:set bg=' ..
                nvimBg .. '<CR>" --server "' .. serverAddress .. '"'
        end)

    local singleShellCommand = table.concat(shellCommands, '; ')
    return singleShellCommand
end

local function executeCommand(appName, command)
    print("Executing " .. appName .. " command: " .. command)

    local output, status, type, rc = hs.execute(command)

    print("output: " .. output)
    print("status: " .. tostring(status))
    print("type: " .. type)
    print("rc: " .. rc)
end

local themeChangeWatcherCallback = function()
    local isDarkMode = isDarkModeEnabled()

    print("Theme changed. Dark mode: " .. tostring(isDarkMode))

    local commands = {
        { appName = "kitty", builder = buildKittyCommand },
        { appName = "nvim", builder = buildNvimCommand },
    }

    for _i, v in ipairs(commands) do
        executeCommand(v.appName, v.builder(isDarkMode))
    end
end

local notificationName = "AppleInterfaceThemeChangedNotification"
local themeChangeWatcher = hs.distributednotifications.new(themeChangeWatcherCallback, notificationName, nil)
themeChangeWatcher:start()
