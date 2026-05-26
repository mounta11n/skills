(*
  list-projects.applescript
  -------------------------
  Listet alle Projekte in Things 3 auf.
  
  Usage:
    osascript list-projects.applescript
    osascript list-projects.applescript "Bereichsname"   → nur Projekte in diesem Bereich
*)

on run argv
	set filterArea to ""
	if (count of argv) > 0 then
		set filterArea to item 1 of argv
	end if
	
	tell application "Things3"
		try
			set output to ""
			
			if filterArea is "" then
				-- Alle Projekte
				repeat with p in projects
					set pName to name of p
					set pStatus to status of p
					set pArea to ""
					try
						set pArea to " (in: " & name of area of p & ")"
					end try
					if pStatus is open then
						set output to output & "- " & pName & pArea & linefeed
					end if
				end repeat
			else
				-- Projekte eines Bereichs
				try
					set targetArea to area filterArea
					set projectList to projects of targetArea
					repeat with p in projectList
						set pName to name of p
						set pStatus to status of p
						if pStatus is open then
							set output to output & "- " & pName & linefeed
						end if
					end repeat
				on error
					return "❌ Bereich \"" & filterArea & "\" nicht gefunden."
				end try
			end if
			
			if output is "" then
				return "Keine offenen Projekte gefunden."
			end if
			return "📁 Projekte:" & linefeed & output
		on error errMsg
			return "❌ Fehler: " & errMsg
		end try
	end tell
end run
