local winCharAssoc = {}

local function captureNextChar(callback)
	local eventtap
	local alertId = hs.alert.show("Press a character key to assign to this window", {}, hs.screen.mainScreen(),
		"indefinite")
	eventtap = hs.eventtap.new({ hs.eventtap.event.types.keyDown }, function(event)
		local char = event:getCharacters()
		local keyCode = event:getKeyCode()
		-- Escape key cancels (keyCode 53 on macOS)
		if keyCode == 53 then
			eventtap:stop()
			hs.alert.closeSpecific(alertId)
			hs.alert.show("Cancelled")
			return true
		end
		if char and #char == 1 then
			eventtap:stop()
			hs.alert.closeSpecific(alertId)
			callback(char)
			return true
		end
		return false
	end)
	eventtap:start()
end

hs.hotkey.bind({ "cmd", "alt" }, "1", function()
	local win = hs.window.focusedWindow()
	captureNextChar(function(char)
		for i = #winCharAssoc, 1, -1 do
			if winCharAssoc[i][1] == char then
				table.remove(winCharAssoc, i)
			end
		end

		table.insert(winCharAssoc, { char, win })

		hs.hotkey.bind({ "cmd", "alt" }, char, function()
			for _, item in ipairs(winCharAssoc) do
				if item[1] == char then
					item[2]:focus()
					break
				end
			end
		end)

		hs.alert.show("You can now use Cmd+Alt+" ..
			string.upper(char) .. " to focus this window " .. win:title() .. " (" .. win:id() .. ")")
	end)
end)
