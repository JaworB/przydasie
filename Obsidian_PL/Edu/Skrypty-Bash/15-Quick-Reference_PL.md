# 15-Quick-Reference

Szybka tabela referencyjna dla koncepcji bash.

## Tabela koncepcji

| Koncepcja | Składnia | Cel |
|-----------|----------|-----|
| Shebang | `#!/bin/bash` | Interpreter |
| Funkcja | `name() { }` | Kod wielokrotny |
| Zmienna lokalna | `local x="val"` | Kontrola zakresu |
| If/else | `if [[ ]]; then; fi` | Warunki |
| Pętla while | `while true; do; done` | Pętla nieskończona |
| Podst. polecenia | `$(cmd)` | Przechwyć wyjście |
| Quiet grep | `grep -q` | Ciche dopasowanie |
| Test pliku | `[[ -f plik ]]` | Sprawdź istnienie |
| Tło | `cmd &` | Async |
| AND | `&&` | Łańcuch sukcesu |
| OR | `||` | Łańcuch błędu |
| Sleep | `sleep 2` | Opóźnienie |
| Przekieruj błąd | `2>/dev/null` | Pomijanie błędu |

## Popularne wzorce

### Wzorzec daemon

```bash
while true; do
    sprawdz_warunek
    wykonaj_akcję
    sleep 2
done
```

### Wzorzec toggle

```bash
state=false
toggle() {
    if $state; then
        akcja_a
        state=false
    else
        akcja_b
        state=true
    fi
}
```

### Wykrywanie zdarzeń

```bash
poprzedni="nieznany"
while true; do
    bieżący=$(pobierz_stan)
    if [[ "$bieżący" != "$poprzedni" ]]; then
        obsłuż_zmianę
        poprzedni="$bieżący"
    fi
    sleep interwał
done
```

## Powiązane

- [[14-Best-Practices_PL]] - Poprzednie: Najlepsze praktyki
- [[index_PL]] - Powrót do indeksu
