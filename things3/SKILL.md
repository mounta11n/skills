---
name: things3
description: Steuere Things 3 via AppleScript – Aufgaben lesen, anlegen, bearbeiten, erledigen, Projekte, Bereiche & Tags verwalten.
version: 1.0.0
author: mounta11n
license: MIT
platforms: [macos]
metadata:
  tags: [things, tasks, gtd, applescript, macos, productivity]
prerequisites:
  commands: [osascript]
  apps: [Things3]
---

# Things 3 – AppleScript Skill

Automatisiere [Things 3](https://culturedcode.com/things/) von Cultured Code über AppleScript.  
Lese, erstelle, bearbeite und erledige Aufgaben — alles vom Terminal / Agenten aus.

> **Quelle:** [Things AppleScript Commands (Support-Artikel 4562654)](https://culturedcode.com/things/support/articles/4562654/)

## Wann verwenden

- Aufgaben in Things abfragen / anzeigen (Inbox, Today, Anytime, Upcoming, Someday)
- Neue To-dos mit Fälligkeitsdatum, Projekt, Bereich oder Tag anlegen
- Aufgaben erledigen, verschieben, löschen
- Projekte und Bereiche verwalten
- Tags anlegen, umbenennen, zuweisen
- Quick Entry Popover öffnen (mit Vorausfüllung)

## Wann NICHT verwenden

- Kurzfristige Notizen → Apple Reminders (`remindctl`)
- Agent-interne Planung → task-management-Skill
- Komplexe Projektplanung → GitHub Issues / Notion

## Voraussetzungen

- **macOS** mit Things 3 (installiert)
- AppleScript-Erlaubnis: Einmalig in *Systemeinstellungen → Datenschutz → Automation* Things für `osascript` freigeben
- Test: `osascript -e 'tell application "Things3" to get name of every to do'`

## Ordnerstruktur

```
things3/
├── SKILL.md                         # Diese Skill-Definition
└── scripts/
    ├── list-todos.applescript       # To-dos auflisten (Inbox, Today, etc.)
    ├── add-todo.applescript         # Neues To-do anlegen
    ├── complete-todo.applescript    # To-do erledigen / löschen
    ├── list-projects.applescript    # Projekte auflisten
    └── quick-entry.applescript      # Quick Entry öffnen
```

## Kurzreferenz (Terminal)

```bash
# To-dos einer Liste anzeigen
osascript scripts/list-todos.applescript "Today"

# Neues To-do anlegen (Titel)
osascript scripts/add-todo.applescript "Milch kaufen"

# Mit Fälligkeitsdatum
osascript scripts/add-todo.applescript "Steuererklärung" --due "2026-06-15"

# In ein Projekt
osascript scripts/add-todo.applescript "API bauen" --project "App v2"

# To-do erledigen
osascript scripts/completed-todo.applescript "Milch kaufen"

# Quick Entry öffnen
osascript scripts/quick-entry.applescript "Neue Idee" --notes "Hier Details"
```

---

# Vollständiges AppleScript-Referenz

## 1. Grundlagen – Built-in Lists

Jede Liste in Things' Sidebar ist via `list "..."` erreichbar:

| Liste            | AppleScript-ID         |
|------------------|------------------------|
| 📥 Inbox         | `list "Inbox"`         |
| 📅 Today         | `list "Today"`         |
| 🕐 Anytime       | `list "Anytime"`       |
| 📆 Upcoming      | `list "Upcoming"`      |
| 💤 Someday       | `list "Someday"`       |
| 📓 Logbook       | `list "Logbook"`       |
| 🗑️ Trash         | `list "Trash"`         |

> **Hinweis:** Bei nicht-englischer Things-Sprache den Namen wie in der App verwenden.

```applescript
tell application "Things3"
    set inboxToDos to to dos of list "Inbox"
    repeat with inboxToDo in inboxToDos
        -- verarbeite inboxToDo
    end repeat
end tell
```

---

## 2. To-Dos

### 2.1 To-dos abrufen

```applescript
-- Alle To-dos
tell application "Things3"
    repeat with toDo in to dos
        -- ...
    end repeat
end tell

-- Bestimmtes To-do per Name
tell application "Things3"
    set callMom to to do named "Call mom"
end tell
```

### 2.2 To-dos einer Liste

```applescript
tell application "Things3"
    repeat with inboxToDo in to dos of list "Inbox"
        -- ...
    end repeat
end tell
```

### 2.3 To-dos eines Projekts

```applescript
tell application "Things3"
    repeat with romeToDo in to dos of project "Vacation in Rome"
        -- ...
    end repeat
end tell
```

### 2.4 To-dos eines Bereichs

```applescript
tell application "Things3"
    repeat with familyToDo in to dos of area "Family"
        -- ...
    end repeat
end tell
```

### 2.5 Neues To-do anlegen

```applescript
tell application "Things3"
    set newToDo to make new to do ¬
        with properties {name:"New to-do", due date:current date}
end tell
```

Mit Ziel-Container:

```applescript
-- Am Anfang von "Today"
set newToDo to make new to do with properties {name:"Install Xcode"} ¬
    at beginning of list "Today"

-- In Liste "Someday"
tell list "Someday"
    set newToDo to make new to do ¬
        with properties {name:"New to-do for someday"}
end tell

-- In Projekt "Groceries"
set newToDo to make new to do with properties {name:"Buy milk"} ¬
    at beginning of project "Groceries"

-- In Bereich "Work"
set newToDo to make new to do with properties {name:"New work to-do"} ¬
    at beginning of area "Work"
```

### 2.6 Properties setzen

```applescript
tell application "Things3"
    set newToDo to make new to do ¬
        with properties {name:"New to-do", due date:current date} ¬
        at beginning of list "Anytime"

    set name of newToDo to "Umbenannt!"
    set notes of newToDo to "www.apple.com" & linefeed & "Details."
    set due date of newToDo to (current date) + 7 * days
    set completion date of newToDo to current date
    set tag names of newToDo to "Home, Mac"
end tell
```

Weitere Properties: `creation date`, `modification date`, `cancellation date`, `status` (open/completed/canceled)

### 2.7 To-do löschen

```applescript
tell application "Things3"
    set aToDo to to do named "To-do to remove"
    delete aToDo
end tell
```

---

## 3. Projekte

### 3.1 Projekte abrufen

```applescript
tell application "Things3"
    repeat with aProject in projects
        -- ...
    end repeat
    set myProject to project "My Project"
end tell
```

### 3.2 Neues Projekt anlegen

```applescript
tell application "Things3"
    set newProject to make new project ¬
        with properties {name:"My Project", notes:"Some notes."}
end tell
```

### 3.3 Projekt-Properties

```applescript
tell application "Things3"
    set newProject to make new project ¬
        with properties {name:"My Project", notes:"Some notes."}
    set name of newProject to "Umbenannt!"
    set due date of newProject to (current date) + 7 * days
    set tag names of newProject to "Home, Mac"
end tell
```

### 3.4 Projekt löschen

```applescript
tell application "Things3"
    set xProject to project named "Project to remove"
    delete xProject
end tell
```

---

## 4. Bereiche (Areas)

### 4.1 Bereiche abrufen

```applescript
tell application "Things3"
    repeat with anArea in areas
        -- ...
    end repeat
    set personalArea to area "Personal"
end tell
```

### 4.2 Neuen Bereich anlegen

```applescript
tell application "Things3"
    set newArea to make new area ¬
        with properties {name:"Health"}
end tell
```

### 4.3 Bereich löschen

```applescript
tell application "Things3"
    set xArea to area named "Area to Delete"
    delete xArea
end tell
```

---

## 5. Tags

### 5.1 Alle Tags abrufen

```applescript
tell application "Things3"
    repeat with aTag in tags
        -- ...
    end repeat
end tell
```

### 5.2 Tags eines Items lesen

```applescript
tell application "Things3"
    set aToDo to first to do of list "Inbox"
    set tagNames to tag names of aToDo       -- als String "Home, Mac"
    set tagList to tags of aToDo             -- als Objekte
end tell
```

### 5.3 Neuen Tag anlegen

```applescript
tell application "Things3"
    set newTag to make new tag with properties {name:"Home"}
end tell
```

### 5.4 Tags zuweisen

```applescript
tell application "Things3"
    set tag names of aToDo to "Home, Mac"
end tell
```

### 5.5 Tag umbenennen

```applescript
tell application "Things3"
    set name of tag "Errands" to "Shopping"
end tell
```

### 5.6 Tag-Hierarchie

```applescript
tell application "Things3"
    set parent tag of tag "Home" to tag "Places"
end tell
```

### 5.7 Tag löschen

```applescript
tell application "Things3"
    delete tag "Errands"
end tell
```

---

## 6. Verschieben & Organisieren

### 6.1 In eine Built-in-Liste verschieben

```applescript
tell application "Things3"
    move newToDo to list "Today"
end tell
```

### 6.2 In Logbook verschieben (erledigen)

```applescript
tell application "Things3"
    move finishedProject to list "Logbook"
    -- oder:
    set status of finishedToDo to completed
    set status of canceledToDo to canceled
end tell
```

### 6.3 Terminieren (nach Upcoming)

```applescript
tell application "Things3"
    schedule toDo for (current date) + 1 * days
end tell
```

### 6.4 In Projekt/Bereich verschieben

```applescript
tell application "Things3"
    set area of aToDo to area "Shopping"
    set project of aToDo to project "Groceries"
    set area of aProject to area "Home"
end tell
```

### 6.5 Von Elternobjekt lösen

```applescript
tell application "Things3"
    delete project of orphanToDo      -- aus Projekt lösen
    delete area of orphanProject      -- aus Bereich lösen
end tell
```

---

## 7. UI-Interaktionen

### 7.1 Ausgewählte To-dos abrufen

```applescript
tell application "Things3"
    repeat with selectedToDo in selected to dos
        move selectedToDo to list "Today"
    end repeat
end tell
```

### 7.2 Item in der App anzeigen

```applescript
tell application "Things3"
    show to do "Book flights"
    show project "Vacation in Rome"
    show area "Personal"
end tell
```

### 7.3 Item zum Bearbeiten öffnen

```applescript
tell application "Things3"
    edit toDoToEdit
    edit projectToEdit
end tell
```

---

## 8. Quick Entry

```applescript
-- Einfach öffnen
tell application "Things3"
    show quick entry panel
end tell

-- Mit Vorausfüllung
tell application "Things3"
    show quick entry panel with properties ¬
        {name:"Buy flowers", notes:"She loves tulips."}
end tell

-- Mit Autofill (Inhalt aus Zwischenablage/Vordergrund-App)
tell application "Things3"
    show quick entry panel with autofill yes
end tell
```

---

## 9. Sonstiges

### 9.1 Properties leeren

```applescript
set tag names of newToDo to ""
```

### 9.2 Papierkorb leeren

```applescript
tell application "Things3"
    empty trash
end tell
```

### 9.3 Erledigtes ins Logbook übertragen

```applescript
tell application "Things3"
    log completed now
end tell
```

---

## Nützliche Patterns

### To-dos als JSON-ähnliche Ausgabe (für Agenten-Parsing)

```bash
osascript -e '
tell application "Things3"
    set output to ""
    repeat with t in to dos of list "Today"
        set output to output & "- " & name of t & " [ID: " & id of t & "]" & linefeed
    end repeat
    return output
end tell'
```

### Mehrere To-dos auf einmal anlegen

```applescript
tell application "Things3"
    set shoppingList to {"Milch", "Brot", "Eier", "Käse"}
    repeat with itemName in shoppingList
        make new to do with properties {name:itemName} ¬
            at beginning of project "Einkaufen"
    end repeat
end tell
```
