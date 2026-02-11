# Najlepsze praktyki

Rekomendacje dla bezpiecznej i efektywnej pracy z Git i GitHub.

## Konfiguracja

- [ ] Używaj SSH zamiast HTTPS
- [ ] Skonfiguruj GPG podpisywanie commitów
- [ ] Ustaw domyślną gałąź `main`
- [ ] Skonfiguruj edytor
- [ ] Włącz kolorowe wyjście
- [ ] Ustaw auto-correct

## Bezpieczeństwo

- [ ] NIE commituj sekretów
- [ ] Używaj `.gitignore`
- [ ] Używaj GitHub Secrets dla CI/CD
- [ ] Włącz 2FA na GitHub
- [ ] Rotuj klucze SSH regularnie
- [ ] Używaj GPG dla commitów

## Commitowania

- [ ] Pisz jasne wiadomości commit
- [ ] Używaj konwencji commitów (Conventional Commits)
- [ ] Jeden logiczny commit = jedna zmiana
- [ ] Commituj często
- [ ] Commituj z opisem

## Gałęzie

- [ ] Gałęzie funkcji = `feature/nazwa`
- [ ] Poprawki błędów = `bugfix/nazwa`
- [ ] Hotfixy = `hotfix/nazwa`
- [ ] Używaj PR do scalenia
- [ ] Usuwaj gałęzie po scaleniu

## Przegląd kodu

- [ ] Wymagaj PR przed scaleniem
- [ ] Wymagaj review przed merge
- [ ] Uruchamiaj testy automatycznie
- [ ] Uruchamiaj lint przed merge
- [ ] Używaj CI/CD

## Zarządzanie wersjami

- [ ] Tagi dla wydań = `v1.0.0`
- [ ] Semantyczne wersjonowanie
- [ ] Release notes dla wydań
- [ ] Changelog automatyczny

## Dziennik kontrolny przed push

```
[ ] Testy przechodzą
[ ] Lint przechodzi
[ ] Wiadomość commit jasna
[ ] Brak sekretów
[ ] Brak niepotrzebnych plików
[ ] Git status czysty
[ ] Pull z main przed push
```

## Narzędzia

- [ ] Używaj GitHub CLI (`gh`)
- [ ] Używaj pre-commit hooks
- [ ] Używaj lazygit lub innego TUI
- [ ] Skonfiguruj aliasy

## Dokumentacja

- [ ] README z instrukcją
- [ ] CONTRIBUTION.md z zasadami
- [ ] CODE_OF_CONDUCT.md
- [ ] LICENSE plik

## Powiązane

- Zobacz [[01-Initial-Setup_PL]] konfiguracja
- Zobacz [[03-Securing-Data_PL]] bezpieczeństwo
- Zobacz [[06-Warnings_PL]] ostrzeżenia
