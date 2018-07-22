--
--	Created by: v1c77
--	Created on: 2018/7/21
--
--	Copyright © 2018 v1c77, All Rights Reserved
--

use AppleScript version "2.7" -- Yosemite (10.10) or later
use scripting additions


tell application "System Preferences"
	quit
	delay 0.5
	launch
	activate
	set current pane to pane "com.apple.preference.displays"
	--reveal pane id "com.apple.preference.displays"
end tell

tell application "System Events"
	tell application process "System Preferences"
		tell window "DELL U2415" -- change the window name for different display
			delay 1
			click radio button "Display" of tab group 1
			set theGroup to tab group 1
			tell pop up button "Rotation:" of theGroup
				set theStat to value of it
				click
				tell menu 1
					if theStat = "Standard" then
						click menu item 4 -- 270 dig
					else
						click menu item 1 -- standard
					end if
				end tell
			end tell
		end tell
	end tell
end tell
tell application "System Preferences"
	quit
end tell

