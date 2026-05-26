---
name: things3
description: Steuere Things 3 via AppleScript – Aufgaben lesen, anlegen, bearbeiten und erledigen.
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
Lese Aufgaben, erstelle neue To-dos, setze Fälligkeitsdaten, Projekte, Bereiche und Tags — alles vom Terminal/Agenten aus.

> **⏳ In Arbeit** – Die konkreten AppleScript-Blöcke werden noch ergänzt, sobald die Things-Dokumentation vorliegt.

## Wann verwenden

- Aufgaben in Things abfragen / anzeigen
- Neue To-dos mit Fälligkeitsdatum, Projekt oder Tag anlegen
- Aufgaben als erledigt markieren, verschieben oder löschen
- Projekte und Bereiche verwalten

## Wann NICHT verwenden

- Kurzfristige Notizen → Apple Reminders (`remindctl`)
- Agent-interne Planung → task-management-Skill
- Komplexe Projektplanung → GitHub Issues / Notion

## Voraussetzungen

- **macOS** mit Things 3 (installiert und lizenziert)
- AppleScript-Erlaubnis: Einmalig in *Systemeinstellungen → Datenschutz → Automation* Things für `osascript` freigeben
- Test: `osascript -e 'tell application "Things3" to get name of every to do'`

## Grundlagen

Things 3 hat ein umfangreiches AppleScript-Dictionary. Die wichtigsten Objekte:

| Objekt | Beschreibung |
|--------|-------------|
| `to do` | Eine einzelne Aufgabe |
| `project` | Ein Projekt (enthält to-dos) |
| `area` | Ein Bereich (sammelt Projekte) |
| `tag` | Ein Tag / Schlagwort |

## Ordnerstruktur

```
things3/
├── SKILL.md          # Diese Skill-Definition
└── scripts/           # AppleScript-Dateien
    ├── list-todos.applescript
    ├── add-todo.applescript
    ├── complete-todo.applescript
    └── ...
```

## Verwendung (Grundgerüst)

AppleScript wird via `osascript` ausgeführt:

```bash
# Alle offenen Aufgaben auflisten
osascript scripts/list-todos.applescript

# Neue Aufgabe anlegen
osascript scripts/add-todo.applescript "Titel" --due "2026-06-01" --project "MeinProjekt"
```

> **Hinweis**: Die konkreten AppleScript-Blöcke folgen, sobald die Things-Dokumentation zur Verfügung steht.

## To-do (nächste Schritte)

- [ ] AppleScript-Dokumentation von Things einarbeiten
- [ ] `scripts/list-todos.applescript` erstellen
- [ ] `scripts/add-todo.applescript` erstellen
- [ ] `scripts/complete-todo.applescript` erstellen
- [ ] Tags, Projekte, Bereiche abdecken
- [ ] Test-Suite definieren

---

*Skeleton erstellt – wird mit AppleScript-Details befüllt*
