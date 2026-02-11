# Popularne polecenia

Szybka referencja poleceń GitHub.

## Repozytorium

| Polecenie | Opis |
|-----------|------|
| `gh repo create` | Utwórz nowe repo |
| `gh repo fork` | Forkuj repo |
| `gh repo clone` | Klonuj repo |
| `gh repo edit` | Edytuj ustawienia |

## Pull Requests

| Polecenie | Opis |
|-----------|------|
| `gh pr list` | Lista PR |
| `gh pr view <pr>` | Pokaż PR |
| `gh pr create` | Utwórz PR |
| `gh pr checkout <pr>` | Checkout PR |
| `gh pr merge <pr>` | Scal PR |
| `gh pr review <pr>` | Recenzja PR |

## Issues

| Polecenie | Opis |
|-----------|------|
| `gh issue list` | Lista issues |
| `gh issue create` | Utwórz issue |
| `gh issue close <issue>` | Zamknij issue |
| `gh issue reopen <issue>` | Otwórz ponownie |

## Actions

| Polecenie | Opis |
|-----------|------|
| `gh run list` | Lista uruchomień |
| `gh run view <run>` | Pokaż uruchomienie |
| `gh run rerun <run>` | Uruchom ponownie |

## Releases

| Polecenie | Opis |
|-----------|------|
| `gh release list` | Lista wydań |
| `gh release create` | Utwórz wydanie |
| `gh release delete <release>` | Usuń wydanie |

## Instalacja GitHub CLI

```bash
# Linux (Ubuntu/Debian)
curl -fsSL https://cli.github.com/packages/deb.sh | sudo bash
sudo apt install gh

# Arch
sudo pacman -S github-cli

# macOS
brew install gh
```

## Autoryzacja

```bash
gh auth login
```

## Powiązane

- Zobacz [[01-Initial-Setup_PL]] konfiguracja
- Zobacz [[index_PL]] podstawy Git
- Zobacz [[07-Best-Practices_PL]] najlepsze praktyki
