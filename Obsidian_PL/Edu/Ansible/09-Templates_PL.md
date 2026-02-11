# 09-Templates

Szablony Jinja2 generują pliki konfiguracyjne dynamicznie.

## Składnia szablonu

```jinja2
# Zmienna
{{ nazwa_zmiennej }}

# Warunek
{% if warunek %}
  Treść
{% endif %}

# Pętla
{% for element in elementy %}
  {{ element }}
{% endfor %}

# Komentarze
{# To jest komentarz #}
```

## Moduł szablonu

```yaml
- name: Kopiuj szablon
  ansible.builtin.template:
    src: szablon.j2
    dest: /etc/app.conf
    owner: root
    group: root
    mode: '0644'
    validate: polecenie %s %s
```

## Przykłady z repozytorium

### Szablon WireGuard (wireguard_template.j2)

```jinja2
[Interface]
PrivateKey = {{ wireguard_private_key }}
Address = {{ wireguard_addresses }}
DNS = 10.66.66.1,1.0.0.1

[Peer]
PublicKey = {{ wireguard_public_key }}
PresharedKey = {{ wireguard_preshared_key }}
Endpoint = {{ wireguard_endpoint }}
AllowedIPs = {{ wireguard_allowed_ips }}
PersistentKeepalive = 25
```

### Zadanie szablonu

```yaml
- name: Kopiuj szablon konfiguracji
  ansible.builtin.template:
    src: wireguard_template.j2
    dest: /etc/wireguard/wg0.conf
    mode: '0644'
    owner: root

- name: Kopiuj plik konfiguracji rsyslog
  ansible.builtin.template:
    src: rsyslog_template.j2
    dest: /etc/rsyslog.conf
    mode: '0644'
    owner: root
```

## Filtry szablonów

```jinja2
# Wartość domyślna
{{ zmienna | default('wartość') }}

# Duże/małe
{{ nazwa | upper }}
{{ nazwa | lower }}

# Operacje na ciągach
{{ ścieżka | basename }}
{{ url | basename }}
{{ treść | trim }}

# Operacje na listach
{{ lista | join(', ') }}
{{ lista | length }}

# JSON/YAML
{{ dane | to_json }}
{{ dane | to_yaml }}
{{ json_ciąg | from_json }}
```

## Testy szablonów

```jinja2
{% if ansible_os_family == "Debian" %}
# Konfiguracja specyficzna dla Debian
{% endif %}

{% if wireguard_private_key is defined %}
PrivateKey = {{ wireguard_private_key }}
{% endif %}

{% for użytkownik in lista_użytkowników %}
Użytkownik: {{ użytkownik.name }}
{% endfor %}
```

## Zmienne automatyczne

| Zmienna | Opis |
|---------|------|
| `ansible_managed` | Standardowy nagłówek |
| `template_host` | Host przetwarzający szablon |
| `template_uid` | UID właściciela szablonu |
| `template_path` | Ścieżka do szablonu |
| `template_fullpath` | Pełna ścieżka do szablonu |
| `template_run_date` | Data przetworzenia szablonu |

## Najlepsze praktyki

1. **Waliduj szablony** - Użyj opcji `validate:`
2. **Ustaw odpowiednie uprawnienia** - `mode:`, `owner:`, `group:`
3. **Używaj opisowych nazw** - `app_config.j2`, nie `conf.j2`
4. **Dodawaj nagłówki** - Dołącz komentarz ansible_managed
5. **Używaj zmiennych dla wrażliwych danych** - Nigdy nie wpisuj haseł na stałe

## Powiązane

- [[08-Vault_PL]] - Poprzednie: Vault
- [[10-Handlers_PL]] - Następne: Handlery
