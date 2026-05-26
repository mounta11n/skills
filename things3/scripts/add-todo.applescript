(*
  add-todo.applescript
  --------------------
  Erstellt ein neues To-do in Things 3.
  
  Usage:
    osascript add-todo.applescript "Titel"
    osascript add-todo.applescript "Titel" "2026-06-15" "Projektname"
    osascript add-todo.applescript "Titel" "" "Projektname" "Work" "Notizen" "Tag1, Tag2"
  
  Argumente (Position):
    1: Titel (Pflicht)
    2: Fälligkeitsdatum (optional, ISO-Format YYYY-MM-DD oder leer)
    3: Projektname (optional, oder leer)
    4: Bereichsname (optional, oder leer)
    5: Notizen (optional, oder leer)
    6: Tags (optional, komma-getrennt: "Tag1, Tag2" oder leer)
*)

on run argv
	if (count of argv) < 1 then
		return "❌ Fehler: Titel ist Pflicht. Usage: osascript add-todo.applescript \"Titel\" [Datum] [Projekt] [Bereich] [Notizen] [Tags]"
	end if
	
	set todoTitle to item 1 of argv
	
	set todoDueDate to missing value
	if (count of argv) >= 2 and item 2 of argv is not "" then
		set dateStr to item 2 of argv
		set todoDueDate to my parseDate(dateStr)
	end if
	
	set projectName to missing value
	if (count of argv) >= 3 and item 3 of argv is not "" then
		set projectName to item 3 of argv
	end if
	
	set areaName to missing value
	if (count of argv) >= 4 and item 4 of argv is not "" then
		set areaName to item 4 of argv
	end if
	
	set notesText to ""
	if (count of argv) >= 5 and item 5 of argv is not "" then
		set notesText to item 5 of argv
	end if
	
	set tagStr to ""
	if (count of argv) >= 6 and item 6 of argv is not "" then
		set tagStr to item 6 of argv
	end if
	
	tell application "Things3"
		try
			set props to {name:todoTitle}
			
			if todoDueDate is not missing value then
				set props to props & {due date:todoDueDate}
			end if
			
			if notesText is not "" then
				set props to props & {notes:notesText}
			end if
			
			if tagStr is not "" then
				set props to props & {tag names:tagStr}
			end if
			
			set newToDo to make new to do with properties props
			
			-- In Projekt verschieben, falls angegeben
			if projectName is not missing value then
				try
					set project of newToDo to project projectName
				on error
					return "⚠️ To-do angelegt, aber Projekt \"" & projectName & "\" nicht gefunden."
				end try
			end if
			
			-- In Bereich verschieben, falls angegeben (und kein Projekt)
			if areaName is not missing value and projectName is missing value then
				try
					set area of newToDo to area areaName
				on error
					return "⚠️ To-do angelegt, aber Bereich \"" & areaName & "\" nicht gefunden."
				end try
			end if
			
			return "✅ To-do erstellt: \"" & todoTitle & "\""
		on error errMsg
			return "❌ Fehler: " & errMsg
		end try
	end tell
end run

on parseDate(dateStr)
	-- ISO-Format: YYYY-MM-DD
	set AppleScript's text item delimiters to "-"
	set dateParts to text items of dateStr
	set AppleScript's text item delimiters to ""
	
	if (count of dateParts) is 3 then
		set y to text item 1 of dateParts as integer
		set m to text item 2 of dateParts as integer
		set d to text item 3 of dateParts as integer
		
		set theDate to current date
		set year of theDate to y
		set month of theDate to m
		set day of theDate to d
		set time of theDate to 12 * hours -- Mittag (vermeidet Zeitzonen-Probleme)
		return theDate
	else
		return missing value
	end if
end parseDate
