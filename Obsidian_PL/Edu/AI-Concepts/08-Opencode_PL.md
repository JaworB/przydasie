# Opencode

Zrozumienie i rozszerzanie systemu agenta AI CLI Opencode.

## Czym jest Opencode?

Opencode to asystent AI oparty na CLI dla inżynierii oprogramowania:

| Cecha | Opis |
|-------|------|
| **CLI-first** | Interakcja przez terminal |
| **Agnostyczny modelu** | Działa z wieloma modelami AI |
| **Bogaty w narzędzia** | Rozbudowana integracja narzędzi |
| **Rozszerzalny** | Umiejętności, agenci, niestandardowe polecenia |
| **Lokalne umiejętności** | Niestandardowa wiedza domenowa |

## Architektura

```
┌─────────────────────────────────────────────────────┐
│                    Opencode                         │
├─────────────────────────────────────────────────────┤
│                                                     │
│  ┌─────────────┐    ┌─────────────┐                │
│  │   Umiejętności │───→│   Agenci    │                │
│  │ (Wiedza)    │    │ (Zachowanie)│                │
│  └─────────────┘    └──────┬──────┘                │
│                            ↓                        │
│                   ┌─────────────┐                  │
│                   │    Narzędzia│                  │
│                   │  (Działania)│                  │
│                   └──────┬──────┘                  │
│                          ↓                          │
│                   ┌─────────────┐                  │
│                   │    CLI      │                  │
│                   │ (Interfejs) │                  │
│                   └─────────────┘                  │
│                                                     │
└─────────────────────────────────────────────────────┘
          ↓
┌─────────────────────────────────────────────────────┐
│ Zewnętrzne: Modele AI (OpenAI, Anthropic, Minimax)  │
└─────────────────────────────────────────────────────┘
```

## Rozpoczęcie pracy

### Instalacja

```bash
# Via menedżer pakietów (Omarchy)
omarchy-install-opencode

# Lub via pip
pip install opencode
```

### Podstawowe użycie

```bash
# Rozpocznij sesję interaktywną
opencode

# Pojedyncze zapytanie
opencode "Napraw błąd w main.py"

# Użyj określonego agenta
opencode --agent build "Napisz zestaw testów"
```

## Umiejętności

Umiejętności dostarczają wiedzy domenowo-specyficznej:

### Wbudowane umiejętności

| Umiejętność | Cel |
|------------|-----|
| **Omarchy** | Konfiguracja pulpitu Linux/Omarchy |
| **Omarchy-Custom** | Niestandardowe dostosowania pulpitu użytkownika |

### Ładowanie umiejętności

```bash
# Załaduj umiejętność
skill <nazwa_umiejętności>

# Przykład
skill Omarchy
```

### Niestandardowe umiejętności

Umiejętności to pliki Markdown ze specjalną strukturą:

```
~/.opencode/skills/
└── <nazwa-umiejętności>/
    └── SKILL.md
```

#### Struktura umiejętności

```markdown
---
name: <Nazwa umiejętności>
description: >
  Krótki opis kiedy używać tej umiejętności
---

# <Nazwa umiejętności>

## Kiedy ta umiejętność MUSI być użyta

- Specyficzne wyzwalacze aktywacji umiejętności

## Kluczowe koncepcje

[Wiedza domenowo-specyficzna]

## Polecenia

[Istotne polecenia]

## Przykłady

[Przykłady użycia]
```

#### Studium przypadku: Umiejętność Omarchy-Custom

Twoja niestandardowa umiejętność demonstruje efektywny projekt umiejętności:

**Lokalizacja:** `repos/przydasie/AI/omarchy-custom-skill/SKILL.md`

**Struktura:**

```markdown
---
name: Omarchy-Custom
description: >
  Rozszerzona umiejętność Omarchy z dostosowaniami użytkownika
  dla pulpitu Hyprland z stacją dokującą DisplayLink.
---

# Umiejętność Omarchy-Custom

## Kiedy ta umiejętność MUSI być użyta

- Edycja plików ~/.config/hypr/
- Niestandardowe skróty klawiszowe (SUPER+M, SUPER+SHIFT+V)
- Konfiguracja wyświetlacza (stacja dokująca DisplayLink, układ pionowy)
- Niestandardowe skrypty (toggle-dock-mode.sh, itp.)

## Niestandardowe skróty klawiszowe

| Skrót | Akcja | Polecenie |
|-------|-------|-----------|
| SUPER + M | Przełącz tryb dokowania | ~/.local/bin/toggle-dock-mode.sh |
| SUPER + SHIFT + V | Napraw kursor | ~/.local/bin/fix-cursor-vertical.sh |

## Niestandardowa konfiguracja wyświetlacza

monitor = DVI-I-1, 3440x1440@50.00, 0x0, 1
monitor = eDP-1, preferred, 0x1440, 2
env = GDK_SCALE,2

## Niestandardowe skrypty

Znajdujące się w ~/.local/bin/:
- toggle-dock-mode.sh
- fix-cursor-vertical.sh
- toggle-audio-output.sh
- lid-handler-daemon.sh

## Powiązana dokumentacja

[[Obsidian/Manuals/Hyprland-Configuration/index_PL]]
```

**Zobacz:** `repos/przydasie/AI/omarchy-custom-skill/SKILL.md`

## Agenci

Agenci definiują wzorce zachowań:

### Wbudowani agenci

| Agent | Cel |
|-------|-----|
| **build** | Generowanie kodu, edycja, testowanie |
| **general** | Pytania, wyjaśnienia, dokumentacja |
| **explore** | Analiza kodu, znajdowanie wzorców |

### Wybór agenta

```bash
# Użyj agenta build do zadań kodowania
opencode --agent build "Refaktoryzuj tę funkcję"

# Użyj explore do rozumienia
opencode --agent explore "Znajdź wszystkie punkty końcowe API"

# General do pytań
opencode "Wyjaśnij tę koncepcję"
```

### Niestandardowa konfiguracja agenta

Konfiguruj agentów w `~/.config/opencode/opencode.json`:

```json
{
  "command": {
    "git-push": {
      "description": "Wyślij zmiany do zdalnego repozytorium",
      "template": "Uruchom 'git push'...",
      "agent": "build"
    }
  }
}
```

## Niestandardowe polecenia

Definiuj szablony poleceń do wielokrotnego użytku:

### Struktura polecenia

```json
{
  "command": {
    "<nazwa-polecenia>": {
      "description": "Co robi",
      "template": "Szablon promptu",
      "agent": "Którego agenta użyć"
    }
  }
}
```

### Przykład: git-push

```json
{
  "command": {
    "git-push": {
      "description": "Wyślij zmiany do zdalnego repozytorium",
      "template": "Uruchom 'git push' aby wysłać twoje zacommitowane zmiany.\n\nWAŻNE: Potwierdź z użytkownikiem przed wykonaniem.",
      "agent": "build"
    }
  }
}
```

### Użycie

```
opencode --command git-push
```

## Narzędzia

Opencode dostarcza rozbudowane narzędzia:

| Kategoria | Narzędzia |
|-----------|-----------|
| **Plik** | read, write, edit, glob |
| **Powłoka** | bash |
| **Szukaj** | grep, codesearch, websearch |
| **Web** | webfetch |
| **Git** | commit, push, branch |
| **Meta** | skill, todowrite |

**Zobacz też:** [[05-Tools_PL]] dla szczegółowej dokumentacji narzędzi.

## Konfiguracja

### Główna konfiguracja

**Lokalizacja:** `~/.config/opencode/opencode.json`

```json
{
  "$schema": "https://opencode.ai/config.json",
  "theme": "system",
  "command": {
    "git-push": { ... }
  }
}
```

### Katalog umiejętności

```
~/.opencode/skills/
├── omarchy/
│   └── SKILL.md
└── omarchy-custom/
    └── SKILL.md → ~/repos/przydasie/AI/omarchy-custom-skill/SKILL.md
```

**Konfiguracja dowiązania symbolicznego:**
```bash
ln -sf ~/repos/przydasie/AI/omarchy-custom-skill/SKILL.md \
       ~/.opencode/skills/omarchy-custom/SKILL.md
```

## Projekt-specyficzne: AGENTS.md

Utwórz `AGENTS.md` w katalogu głównym projektu dla niestandardowych konfiguracji agentów:

```markdown
# Agenci projektu

## Niestandardowy agent: Code-Reviewer

```yaml
agent: build
model: gpt-4
description: Przegląda kod pod kątem błędów i stylu
instrukcje:
  - Sprawdź problemy bezpieczeństwa
  - Zweryfikuj istnienie testów
  - Upewnij się o dokumentacji
```

## Użycie

```bash
opencode --agent code-reviewer
```

## Powiązane

- [[Obsidian/Manuals/Hyprland-Configuration/index_PL|Dokumentacja Hyprland]] - Przykład z życia
- [[../AI-Concepts/index_PL|Koncepcje AI]] - Ogólna wiedza AI
