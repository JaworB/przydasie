# Koncepcje skryptów Bash

Kompletny przewodnik po koncepcjach skryptowania bash używanych w automatyzacji Hyprland.

## Koncepcje

### Podstawy
1. [[01-Shebang_PL]] - Wybór interpretera
2. [[02-Functions_PL]] - Funkcje i zakres
3. [[03-Variables_PL]] - Zmienne globalne vs lokalne
4. [[04-Conditionals_PL]] - Nawiasy testowe i warunki
5. [[05-Control-Flow_PL]] - Pętle i iteracja

### Koncepcje główne
6. [[06-Command-Substitution_PL]] - Przechwytywanie wyjścia
7. [[07-Error-Handling_PL]] - Obsługa błędów i kody wyjścia
8. [[08-Process-Management_PL]] - Procesy w tle
9. [[09-Logical-Operators_PL]] - Operatory AND i OR
10. [[10-Hyprland-Integration_PL]] - Polecenia hyprctl

### Wzorce i praktyki
11. [[11-Sleep-and-Timing_PL]] - Timery i opóźnienia
12. [[12-Toggle-Pattern_PL]] - Przełącznik stanów
13. [[13-Event-Detection-Pattern_PL]] - Wykrywanie zmian stanu
14. [[14-Best-Practices_PL]] - Najlepsze praktyki daemon
15. [[15-Quick-Reference_PL]] - Tabele i podsumowania

## Przegląd

Ten przewodnik obejmuje koncepcje bash używane w:

- `Manuals/Arch_after_install/scripts/lid-handler-daemon.sh` - Daemon w tle do zarządzania monitorami
- `Manuals/Arch_after_install/scripts/toggle-dock-mode.sh` - Przełączanie między trybem dock/normal
- `Manuals/Arch_after_install/scripts/fix-cursor-vertical.sh` - Rekalingulacja kursora

## Powiązane

- [[../../Manuals/Arch-po-instalacji/01-DisplayLink-Setup_PL]] - Indeks konfiguracji DisplayLink
- [[../../Manuals/Arch-po-instalacji/02-DisplayLink-Dock-Setup_PL]] - Przewodnik instalacji sterowników
- [[../../Manuals/Arch-po-instalacji/03-Lid-Switch-Automation_PL]] - Implementacja daemon w świecie rzeczywistym
- [[../../Manuals/Konfiguracja-Hyprland/Wlasne-skrypty/index_PL]] - Skrypty referencyjne
