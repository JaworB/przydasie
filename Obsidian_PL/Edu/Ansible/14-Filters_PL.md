# 14-Filters

Filtry Jinja2 przekształcają dane w szablonach i zmiennych.

## Składnia filtra

```yaml
{{ zmienna | nazwa_filtra }}
{{ zmienna | nazwa_filtra(param) }}
```

## Filtry ciągów znaków

```yaml
# Duże/małe litery
{{ nazwa | upper }}      # "HELLO"
{{ nazwa | lower }}      # "hello"

# Pierwsza litera wielka
{{ nazwa | capitalize }}  # "Hello"

# Format tytułu
{{ nazwa | title }}      # "Hello World"

# Usuwanie białych znaków
{{ nazwa | trim }}       # "bez spacji"
{{ nazwa | lstrip }}     # Usuń lewe
{{ nazwa | rstrip }}     # Usuń prawe

# Zamiana
{{ nazwa | replace('stare', 'nowe') }}
```

## Filtr domyślny

```yaml
# Z domyślną
{{ zmienna | default('wartość') }}
{{ zmienna | default(false) }}  # Zachowaj wartości falsy

# Zagnieżdżona domyślna
{{ some.nested.var | default('wartość') }}
```

## Filtry liczbowe

```yaml
# Konwertuj na integer
{{ '42' | int }}

# Konwertuj na float
{{ '3.14' | float }}

# Zaokrąglij liczby
{{ 3.14159 | round(2) }}     # 3.14

# Min/max
{{ [1, 2, 3] | min }}        # 1
{{ [1, 2, 3] | max }}        # 3

# Suma
{{ [1, 2, 3] | sum }}        # 6
```

## Filtry list

```yaml
# Pierwszy/ostatni
{{ [1, 2, 3] | first }}      # 1
{{ [1, 2, 3] | last }}       # 3

# Długość
{{ lista | length }}

# Sortuj
{{ [3, 1, 2] | sort }}        # [1, 2, 3]

# Unikalne
{{ [1, 2, 2, 3] | unique }}  # [1, 2, 3]

# Połącz
{{ ['a', 'b', 'c'] | join(', ') }}  # "a, b, c"

# Mapuj
{{ użytkownicy | map(attribute='name') | list }}

# Wybierz
{{ liczby | select("even") | list }}
```

## Filtry ścieżek

```yaml
# Nazwa bazowa
{{ ścieżka | basename }}  "plik.txt"

# Katalog nadrzędny
{{ ścieżka | dirname }}   # "/sciezka/do"

# Ścieżka rzeczywista
{{ ścieżka | realpath }}

# Rozszerz użytkownika
{{ ścieżka | expanduser }}
```

## Filtry konwersji danych

```yaml
# Do JSON
{{ dane | to_json }}    # {"klucz": "wartość"}
{{ dane | to_nice_json }}

# Do YAML
{{ dane | to_yaml }}
{{ dane | to_nice_yaml }}

# Z JSON/YAML
{{ json_ciąg | from_json }}
{{ yaml_ciąg | from_yaml }}

# Do boolean
{{ 'yes' | bool }}
{{ 1 | bool }}
```

## Filtr hasła hash

```yaml
# Hash hasła
{{ hasło | password_hash('sha512') }}
{{ hasło | password_hash('sha256') }}
{{ hasło | password_hash('md5') }}
```

## Przykłady z repozytorium

### Filtr domyślny

```yaml
- name: Twórz użytkowników
  ansible.builtin.user:
    name: "{{ item.username }}"
    groups: "{{ item.groups | default('') }}"  # Użyj pustego ciągu jeśli niezdefiniowane
    append: true
```

### Domyślna z portem

```yaml
- name: Konfiguruj SSHD
  ansible.posix.sshd:
    port: "{{ role_ssh_sshport | default('2229') }}"  # Domyślnie 2229
```

### Filtr hasła hash

```yaml
- name: Twórz użytkowników - z hasłem
  ansible.builtin.user:
    name: "{{ item.username }}"
    password: "{{ vault_user_password | password_hash('sha512') }}"
  loop: "{{ role_users_user_details }}"
```

## Powiązane

- [[13-Lookups_PL]] - Poprzednie: Lookupy
- [[15-Delegation_PL]] - Następne: Delegacja
