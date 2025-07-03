local winCharAssoc = {}

hs.hotkey.bind({ "ctrl", "alt" }, "=", function()
    local win = hs.window.focusedWindow()
    local button, input = hs.dialog.textPrompt("Enter a character", "", "", "OK", "Cancel")

    if button == "OK" and input and #input > 0 then
        local char = input:sub(1, 1)
        hs.alert.show("You are associating '" .. char .. "' with window " .. win:id())
        for i = #winCharAssoc, 1, -1 do
            if winCharAssoc[i][1] == char then
                table.remove(winCharAssoc, i)
            end
        end
        table.insert(winCharAssoc, { char, win })

        hs.hotkey.bind({ "ctrl", "alt" }, char, function()
            for _, item in ipairs(winCharAssoc) do
                if item[1] == char then
                    item[2]:focus()
                    break
                end
            end
        end)
    else
        hs.alert.show("Cancelled or empty input")
    end
end)

