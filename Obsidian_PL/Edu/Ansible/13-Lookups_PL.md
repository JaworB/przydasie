# 13-Lookups

Lookupy pobierają dane ze źródeł zewnętrznych.

## Składnia lookup

```yaml
{{ lookup('nazwa_wtyczki', 'argument') }}
```

## Wbudowane lookupy

### Lookup pliku

```yaml
# Odczytaj zawartość pliku
{{ lookup('file', '~/.ssh/id_rsa.pub') }}

# W zadaniu
- name: Autoryzuj klucz pub admina
  ansible.posix.authorized_key:
    user: "{{ item.username }}"
    state: present
    key: "{{ lookup('file', 'files/main.pub') }}"
  loop: "{{ role_users_user_details }}"
```

### Lookup szablonu

```yaml
# Odczytaj plik szablonu
{{ lookup('template', 'config.j2') }}
```

### Lookup hasła

```yaml
# Generuj losowe hasło
{{ lookup('password', '/dev/null length=32 chars=ascii_letters,digits') }}

# Użyj istniejącego pliku haseł
{{ lookup('password', 'secrets/password.txt') }}
```

### Lookup CSV

```yaml
# Odczytaj plik CSV
{{ lookup('csvfile', 'file=users.csv delimiter=, col=1') }}
```

### Lookup Ini

```yaml
# Odczytaj plik INI
{{ lookup('ini', 'section=value file=app.ini') }}
```

### Lookup DNS

```yaml
# Rekordy DNS
{{ lookup('dnstxt', 'example.com') }}
```

### Lookup zmiennych środowiskowych

```yaml
# Zmienna środowiskowa
{{ lookup('env', 'HOME') }}
```

### Lookup pipeline

```yaml
# Przepuść przez polecenie
{{ lookup('pipe', 'date +%Y-%m-%d') }}
```

## Lookup szablonu w zadaniach

```yaml
- name: Odczytaj klucz publiczny SSH
  debug:
    msg: "{{ lookup('file', 'files/main.pub') }}"

- name: Autoryzuj klucze
  ansible.posix.authorized_key:
    user: admin
    state: present
    key: "{{ lookup('file', 'files/main.pub') }}"
```

## Lookup hasła

```yaml
- name: Generuj losowe hasło
  debug:
    msg: "{{ lookup('password', '/dev/null length=16 chars=ascii_letters,digits') }}"

- name: Twórz użytkownika z hasłem
  ansible.builtin.user:
    name: testuser
    password: "{{ lookup('password', '/dev/null length=16') | password_hash('sha512') }}"
```

## Lookup środowiskowy

```yaml
- name: Użyj zmiennej środowiskowej
  debug:
    msg: "Katalog domowy: {{ lookup('env', 'HOME') }}"
```

## Powiązane

- [[12-Facts_PL]] - Poprzednie: Fakty
- [[14-Filters_PL]] - Następne: Filtry
