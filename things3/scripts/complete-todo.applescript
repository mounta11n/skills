(*
  complete-todo.applescript
  -------------------------
  Erledigt oder löscht ein To-do in Things 3.
  
  Usage:
    osascript complete-todo.applescript "Titel"               → erledigen
    osascript complete-todo.applescript "Titel" delete         → löschen (in Papierkorb)
    osascript complete-todo.applescript "Titel" cancel         → abbrechen/stornieren
*)

on run argv
	if (count of argv) < 1 then
		return "❌ Fehler: Titel ist Pflicht. Usage: osascript complete-todo.applescript \"Titel\" [delete|cancel]"
	end if
	
	set todoTitle to item 1 of argv
	
	set action to "complete"
	if (count of argv) >= 2 then
		set action to item 2 of argv
	end if
	
	tell application "Things3"
		try
			set targetTodo to to do named todoTitle
			
			if action is "delete" then
				delete targetTodo
				return "🗑️ To-do gelöscht: \"" & todoTitle & "\""
			else if action is "cancel" then
				set status of targetTodo to canceled
				return "❌ To-do storniert: \"" & todoTitle & "\""
			else
				set status of targetTodo to completed
				return "✅ To-do erledigt: \"" & todoTitle & "\""
			end if
		on error errMsg
			return "❌ Fehler: " & errMsg
		end try
	end tell
end run
