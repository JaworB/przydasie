# Koncepcje Ansible

Kompletny przewodnik po koncepcjach Ansible używanych w provisioningu infrastruktury.

## Koncepcje

### Podstawy
1. [[01-Playbooks_PL]] - Struktura i wykonanie playbooków
2. [[02-Inventory_PL]] - Inventory i grupy hostów
3. [[03-Roles_PL]] - Struktura i organizacja ról
4. [[04-Modules_PL]] - Typy i użycie modułów

### Koncepcje główne
5. [[05-Conditionals_PL]] - When i warunki
6. [[06-Loops_PL]] - Konstrukcje pętli i iteracja
7. [[07-Variables_PL]] - Zmienne i priorytet zmiennych
8. [[08-Vault_PL]] - Szyfrowanie Ansible Vault

### Koncepcje zaawansowane
9. [[09-Templates_PL]] - Szablony Jinja2
10. [[10-Handlers_PL]] - Handlery i powiadomienia
11. [[11-Privilege-Escalation_PL]] - Become i eskalacja uprawnień
12. [[12-Facts_PL]] - Zbierane fakty i ansible_facts
13. [[13-Lookups_PL]] - Pluginy lookup
14. [[14-Filters_PL]] - Filtry Jinja2
15. [[15-Delegation_PL]] - Delegacja i akcje lokalne
16. [[16-Collections_PL]] - Kolekcje Ansible

### Dodatkowe koncepcje
17. [[17-Tags_PL]] - Tagi do selektywnego wykonania
18. [[18-Blocks_PL]] - Bloki i obsługa błędów
19. [[19-Error-Handling_PL]] - Wzorce obsługi błędów

## Przegląd

Ten przewodnik obejmuje koncepcje Ansible używane w:

- `scripts/ansible/provisioning/provisioning.yml` - Główny playbook provisioningu
- `scripts/ansible/provisioning/inventory.yml` - Inventory hostów
- `scripts/ansible/provisioning/roles/*/` - Role wielokrotnego użytku

## Powiązane

- [[../../Manuals/Arch-po-instalacji/02-DisplayLink-Dock-Setup_PL]] - Powiązana konfiguracja
