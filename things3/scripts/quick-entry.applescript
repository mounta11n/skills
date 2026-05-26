(*
  quick-entry.applescript
  -----------------------
  Öffnet das Quick Entry Popover in Things 3, optional mit Vorausfüllung.
  
  Usage:
    osascript quick-entry.applescript                          → leeres Quick Entry
    osascript quick-entry.applescript "Titel"
    osascript quick-entry.applescript "Titel" "Notizen"
    osascript quick-entry.applescript "Titel" "Notizen" yes   → mit Autofill
*)

on run argv
	set todoTitle to ""
	set todoNotes to ""
	set useAutofill to false
	
	if (count of argv) >= 1 then
		set todoTitle to item 1 of argv
	end if
	
	if (count of argv) >= 2 and item 2 of argv is not "" then
		set todoNotes to item 2 of argv
	end if
	
	if (count of argv) >= 3 and item 3 of argv is "yes" then
		set useAutofill to true
	end if
	
	tell application "Things3"
		try
			activate
			
			if todoTitle is "" and not useAutofill then
				-- Einfach leeres Quick Entry
				show quick entry panel
				return "📝 Quick Entry geöffnet."
			else if useAutofill and todoTitle is "" then
				show quick entry panel with autofill yes
				return "📝 Quick Entry mit Autofill geöffnet."
			else if useAutofill then
				show quick entry panel with properties ¬
					{name:todoTitle, notes:todoNotes} ¬
					and autofill yes
				return "📝 Quick Entry geöffnet: \"" & todoTitle & "\" (mit Autofill)"
			else
				show quick entry panel with properties ¬
					{name:todoTitle, notes:todoNotes}
				return "📝 Quick Entry geöffnet: \"" & todoTitle & "\""
			end if
		on error errMsg
			return "❌ Fehler: " & errMsg
		end try
	end tell
end run
