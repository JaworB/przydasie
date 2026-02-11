# 19-Error-Handling

Obsługa błędów kontroluje, jak Ansible reaguje na niepowodzenia zadań.

## Ignoruj błędy

```yaml
- name: Zadanie, które może się nie powieść
  command: /bin/false
  ignore_errors: yes  # Kontynuuj nawet jeśli się nie powiedzie
```

## Tryb sprawdzania

```yaml
- name: Zadanie tylko w trybie sprawdzania
  command: /bin/wrażliwe-polecenie
  check_mode: yes
  diff: yes
```

## Changed When

```yaml
- name: Sprawdź czy plik zawiera wzorzec
  command: grep -q "wzorzec" /sciezka/do/pliku
  register: wynik_grep
  changed_when: wynik_grep.rc == 0
```

## Failed When

```yaml
- name: Błąd jeśli mało miejsca na dysku
  ansible.builtin.shell: df / | tail -1 | awk '{print $5}' | tr -d '%'
  register: użycie_dysku
  failed_when: (użycie_dysku.stdout | int) > 90
```

## Ponów zadanie

```yaml
- name: Ponawiaj aż do sukcesu
  command: /bin/polacz-z-usluga
  register: wynik
  until: wynik.rc == 0
  retries: 5
  delay: 10
```

## Block rescue

```yaml
- name: Block z rescue
  block:
    - name: Zadanie, które może się nie powieść
      command: /bin/false
  rescue:
    - name: Zadanie odzyskiwania
      debug:
        msg: "Zadanie nie powiodło się, uruchamiam rescue"
    - name: Upewnij się, że usługa działa
      service:
        name: usluga-zapasowa
        state: started
```

## Zawsze uruchamiaj

```yaml
- name: Zadanie z always
  block:
    - name: Zadanie 1
      command: /bin/false
  rescue:
    - name: Rescue
      debug:
        msg: "Niepowodzenie"
  always:
    - name: Zawsze uruchamiaj
      debug:
        msg: "To zawsze się uruchamia"
```

## Wszystkie błędy fatalne

```yaml
- name: Play z fatalnymi błędami
  hosts: all
  any_errors_fatal: yes  # Każdy błąd zatrzymuje cały play
  tasks:
    - name: Krytyczne zadanie
      command: /bin/krytyczne
```

## Zmienione w bloku

```yaml
- name: Złożone wykrywanie zmian
  block:
    - name: Pobierz bieżącą konfigurację
      command: cat /etc/app.conf
      register: bieżąca_konfiguracja

    - name: Zapisz nową konfigurację
      copy:
        content: |
          nowa konfiguracja
        dest: /etc/app.conf
        backup: yes
      register: wynik_zapisu

    - name: Wykryj zmianę
      set_fact:
        konfiguracja_zmieniona: "{{ wynik_zapisu.changed }}"
  always:
    - name: Powiadom o zmianie
      debug:
        msg: "Konfiguracja została zaktualizowana"
    - name: Restart jeśli zmieniono
      service:
        name: aplikacja
        state: restarted
      when: konfiguracja_zmieniona | bool
```

## Najlepsze praktyki

1. **Używaj ignore_errors oszczędnie** - Tylko dla naprawdę opcjonalnych zadań
2. **Używaj bloków rescue** - Dla łagodnej degradacji
3. **Definiuj warunki błędów** - `failed_when` dla złożonej logiki
4. **Używaj ponawiania** - Dla zależności usług zewnętrznych
5. **Any_errors_fatal** - Dla krytycznych wdrożeń na wielu hostach

## Powiązane

- [[18-Blocks_PL]] - Poprzednie: Bloki
- [[01-Playbooks_PL]] - Powrót do: Playbooki
