# 🛠️ Dev Skills

**Eigene, handverlesene AI-Agent-Skills** — zentrale Sammlung für alle selbst erstellten Skills.

## Zweck

Dieses Repository enthält ausschließlich **selbst geschriebene Skills** für AI Coding Agents (pi, Claude Code, Codex o.Ä.).  
Hier **keine** heruntergeladenen oder fremden Skills — die haben ihren Platz in `~/.agents/skills/` bzw. `~/.pi/agent/skills/`.

## Struktur

```
skills/
├── README.md            # Du bist hier
├── things3/             # Things.app AppleScript-Integration
│   ├── SKILL.md         # Skill-Definition
│   └── scripts/         # AppleScript-Dateien
└── …                    # Weitere Skills kommen dazu
```

Jeder Skill lebt in einem eigenen Unterordner mit einer `SKILL.md` als Einstiegspunkt.  
Hilfsskripte, Konfigurationen oder Beispiele kommen in `scripts/`, `examples/` o.Ä. innerhalb des Skill-Ordners.

## Konventionen

| Aspekt | Regel |
|--------|-------|
| **Sprache** | Skills in Deutsch oder Englisch — je nach Zielgruppe |
| **Format** | `SKILL.md` mit YAML-Frontmatter (name, description, platforms etc.) |
| **Version** | SemVer via `version`-Feld im Frontmatter |
| **Skripte** | AppleScript, Shell, Python — was zum Skill passt |
| **Testbarkeit** | Jeder Skill enthält einen Abschnitt „Testen“ oder Beispiele |

## 🔒 Public Repo – Datenschutz & Sicherheit

Dieses Repository ist **öffentlich** — alles hier landet auf GitHub für alle sichtbar.

**Daher gilt für jeden Skill und jede Datei:**

- ❌ **Keine** API-Keys, Tokens, Passwörter oder Secrets — auch nicht in kommentierten Code-Blöcken
- ❌ **Keine** Pfade mit Benutzernamen (`/Users/deinname/...`) — nutze Platzhalter wie `~/`, `$HOME` oder `$USER`
- ❌ **Keine** persönlichen Daten, Hostnames, IPs, MAC-Adressen
- ❌ **Keine** `.env`-Dateien oder Config-Dumps mit lokalen Werten
- ✅ Nur **generische, abstrahierte Skripte und Anleitungen**
- ✅ Beispiel-Konfigurationen immer mit Platzhaltern (`your-api-key`, `example.com`, `mein-projekt`)

> **Pull Requests willkommen** — aber auch hier gilt: Keine Secrets, keine persönlichen Daten.

## Verwendung

Die Skills können von jedem Agenten direkt referenziert werden:

```bash
# Beispiel: pi verwendet den Skill
# (wird automatisch via available_skills geladen)
```

Oder via `read`-Tool im Agenten-Kontext.

---

*Erstellt: Mai 2026*
