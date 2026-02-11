# Lazygit - Terminalowy interfejs Git

Prosty terminalowy interfejs dla poleceń Git, napisany w Go z biblioteką gocui.

## Czym jest Lazygit?

Lazygit zapewnia intuicyjny interfejs dla common operacji Git bez opuszczania terminala. Łączy moc Git z użytecznością TUI (Text User Interface).

## Korzyści

- **Wizualny diff**: Zobacz zmiany bez zapamiętywania flag
- **Stage'owanie linia po linii**: Granularna kontrola nad tym, co trafia do commitów
- **Rozwiązywanie konfliktów**: Wizualna obsługa konfliktów scalenia
- **Gałęzie**: Łatwe przełączanie i zarządzanie gałęziami
- **Szybkość**: Sterowanie klawiaturą, brak przełączania kontekstu do GUI

## Instalacja

```bash
# Arch Linux (AUR)
yay -S lazygit

# macOS (Homebrew)
brew install lazygit

# Nix
nix-env -iA nixpkgs.lazygit

# Go
go install github.com/jesseduffield/lazygit@latest

# Wydanie binarne
curl -Lo lazygit.tar.gz https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_Linux_x86_64.tar.gz
tar -xzf lazygit.tar.gz
sudo mv lazygit /usr/local/bin/
```

## Główny interfejs

![Główny interfejs Lazygit](images/lazygit-main.png)

## Klawisze nawigacji

### Globalna nawigacja

| Klawisz | Akcja |
|---------|-------|
| `Tab` | Przełącz między panelami |
| `Ctrl+R` | Odśwież |
| `Ctrl+C` | Wyjdź |
| `Ctrl+P` | Poprzedni widok |
| `Ctrl+N` | Następny widok |
| `Esc` | Wstecz / Anuluj |
| `/` | Filtr (szukaj) |
| `↑/↓` | Nawiguj |
| `←/→` | Rozwiń/zwiń |

### Panel plików

| Klawisz | Akcja |
|---------|-------|
| `Space` | Stage'/unstage plik |
| `Enter` | Pokaż diff |
| `A` | Stage'uj wszystkie zmiany |
| `Ctrl+A` | Stage'uj wszystkie zmiany |
| `Ctrl+U` | Unstage wszystkie |
| `D` | Odrzuć zmiany (z potwierdzeniem) |
| `M` | Pokaż konflikty scalania |
| `O` | Otwórz w edytorze |

## Typowe przepływy pracy

### Szybki commit

```
1. Panel plików: Wybierz zmienione pliki
2. Space: Stage'uj pliki
3. c: Otwórz wiadomość commit
4. Napisz wiadomość
5. Enter: Potwierdź commit
6. P: Wyślij do zdalnego
```

### Utwórz gałąź funkcji

```
1. Panel gałęzi
2. c: Utwórz gałąź
3. Wpisz nazwę gałęzi (np. feature/nowe-logowanie)
4. Enter: Utwórz
5. Panel plików: Wprowadź zmiany
6. Stage'uj, commit
```

## Konfiguracja

### Plik skrótów klawiszowych (`~/.config/jesseduffield/lazygit/`)

```yaml
# ~/.config/jesseduffield/lazygit/config.yml

gui:
  authorColors:
    "jan.kowalski@przyklad.com": "cyan"
  dateFormat: "2006-01-02 15:04"
  theme:
    activeBorderColor:
      - green
      - bold
    inactiveBorderColor:
      - white
  scrollHeight: 2
  sidePanelWidth: 0.25

keybinding:
  files:
    toggleStagedAll: "C-a"
    refreshFiles: "C-r"
  commits:
    copyCommitMessage: "C-y"
```

## Integracja z koncepcjami Git

Ta sekcja łączy użycie lazygit z koncepcjami omówionymi w innych modułach:

| Koncepcja | Moduł | Odpowiednik w Lazygit |
|-----------|-------|----------------------|
| Podstawowy przepływ pracy | [[05-Basic-Workflow_PL]] | Files → Space → c → commit |
| Inspekcja | [[06-Inspection_PL]] | Panel commitów, Enter na commicie |
| Cofanie | [[07-Undo-Fix_PL]] | Ctrl+Z cofanie, A amend |
| Gałęzie | [[08-Branching_PL]] | Panel gałęzi (c, M, D) |
| Rebase | [[09-Rebase_PL]] | Ctrl+B interaktywny rebase |
| Schowek | [[11-Stashing_PL]] | Panel schowka |
| Zdalne | [[12-Remotes_PL]] | P push, p pull |
| Tagi | [[13-Tags_PL]] | Panel tagów (konfiguracja niestandardowa) |

## Wskazówki i triki

- **Masowe stage'owanie**: `Ctrl+A` stage'uje wszystkie, `Ctrl+U` unstage'uje wszystkie
- **Szybki push**: `P` z domyślnym zdalnym/gałęzią
- **Pull + rebase**: Ustaw `pull.mode = rebase` w konfiguracji
- **Wyróżnianie diff**: Używa delta jeśli zainstalowane
- **Wsparcie myszy**: Włącz z `mouse: true` w konfiguracji
- **Niestandardowe panele**: Dodaj commit/stash/gałęzie do głównego widoku
- **Kopiuj hash commit**: `y` w panelu commitów

## Rozwiązywanie problemów

| Problem | Rozwiązanie |
|---------|-------------|
| Kolory się nie wyświetlają | Ustaw `TERM=xterm-256color` |
| Wolne przy dużych repo | Wyłącz telemetrię, zmniejsz częstotliwość odświeżania |
| Konflikty skrótów | Sprawdź skróty emulatora terminala |
| Edytor się nie otwiera | Ustaw zmienne środowiskowe `EDITOR` i `GIT_EDITOR` |

## Zasoby zewnętrzne

- [Lazygit GitHub](https://github.com/jesseduffield/lazygit)
- [Dokumentacja Lazygit](https://lazygit.org/docs/)
- [Wiki Lazygit](https://github.com/jesseduffield/lazygit/wiki)
- [Przewodnik instalacji](https://github.com/jesseduffield/lazygit#installation)

## Powiązane

- [[05-Basic-Workflow_PL]] - Podstawowy przepływ pracy Git
- [[06-Inspection_PL]] - Inspekcja stanu repozytorium
- [[07-Undo-Fix_PL]] - Cofanie zmian
- [[08-Branching_PL]] - Operacje gałęzi
- [[09-Rebase_PL]] - Operacje rebase

## Następne kroki

Przejdź do [[Git-GitHub-Workflow/index_PL]] dla przepływów pracy specyficznych dla GitHub, lub wróć do [[index_PL]] do pełnego przeglądu.
