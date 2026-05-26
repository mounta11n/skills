(*
  list-todos.applescript
  ----------------------
  Gibt To-dos einer Things-Liste als Text aus.
  
  Usage:
    osascript list-todos.applescript              → Today (default)
    osascript list-todos.applescript "Inbox"
    osascript list-todos.applescript "Today"
    osascript list-todos.applescript "Anytime"
    osascript list-todos.applescript "Upcoming"
    osascript list-todos.applescript "Someday"
*)

on run argv
	set listName to "Today"
	if (count of argv) > 0 then
		set listName to item 1 of argv
	end if
	
	tell application "Things3"
		try
			set theList to list listName
			set todoList to to dos of theList
			set output to ""
			repeat with t in todoList
				set todoTitle to name of t
				set todoStatus to status of t
				set todoDue to ""
				try
					set todoDue to due date of t
					set todoDue to " [fällig: " & date string of todoDue & "]"
				end try
				set todoTags to ""
				try
					set tagStr to tag names of t
					if tagStr is not "" then
						set todoTags to " [" & tagStr & "]"
					end if
				end try
				set output to output & "- " & todoTitle & todoDue & todoTags & linefeed
			end repeat
			
			if output is "" then
				return "Keine offenen To-dos in \"" & listName & "\"."
			end if
			return "📋 " & listName & ":" & linefeed & output
		on error errMsg
			return "❌ Fehler: " & errMsg
		end try
	end tell
end run
