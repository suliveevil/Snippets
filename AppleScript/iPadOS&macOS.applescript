tell application "System Preferences"
	quit
end tell

tell application "System Preferences"
	activate
end tell

tell application "System Events"
	tell process "System Preferences"
		tell menu bar 1
			tell menu bar item 5
				tell menu 1
					click (every menu item whose name contains "设备名称")
				end tell
			end tell
		end tell
	end tell
end tell

tell application "System Preferences"
	quit
end tell