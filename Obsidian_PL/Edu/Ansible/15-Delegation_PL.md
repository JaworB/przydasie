# 15-Delegation

Delegacja uruchamia zadania na innym hoście niż docelowy.

## Składnia delegate_to

```yaml
- name: Zadanie na innym hoście
  delegate_to: nazwa_hosta
  nazwa_modułu:
    opcja: wartość
```

## Przykłady z repozytorium

### Deleguj do localhosta

```yaml
- name: Utwórz katalog kopii zapasowej na kontrolerze
  delegate_to: localhost
  ansible.builtin.file:
    path: "{{ playbook_dir }}/ssh_keys/{{ inventory_hostname }}"
    state: directory
    mode: '0755'
```

## Deleguj do konkretnego hosta

```yaml
- name: Pobierz fakty z load balancera
  delegate_to: lb01
  ansible.builtin.setup:
    filter: "*eth0*"

- name: Dodaj serwer do puli load balancera
  community.general.haproxy:
    state: present
    host: "{{ inventory_hostname }}"
    backend: web
  delegate_to: lb01
```

## Deleguj z faktami

```yaml
- name: Zbieraj fakty na konkretnym hoście
  delegate_to: "{{ item }}"
  setup:
  loop: "{{ groups['load_balancers'] }}"
```

## Akcje lokalne

```yaml
- name: Uruchom lokalnie
  delegate_to: localhost
  local_action:
    module: community.general.slack
    token: "{{ slack_token }}"
    msg: "Wdrożenie zakończone"

# Skrót
- name: Wyślij powiadomienie
  local_action:
    module: ansible.builtin.debug
    msg: "Zadanie zakończone"
```

## Deleguj fakty

Domyślnie delegowane zadania nie aktualizują `ansible_facts`. Użyj `gather_facts: no` lub:

```yaml
- name: Zbieraj fakty na delegowanym hoście
  delegate_to: "{{ nowy_host }}"
  setup:
  register: nowe_fakty_hosta

- name: Użyj delegowanych faktów
  debug:
    msg: "{{ nowe_fakty_hosta.ansible_hostname }}"
```

## Przypadki użycia

| Przypadek użycia | Przykład |
|------------------|----------|
| Operacje kontrolera | Twórz pliki lokalnie, pobieraj certyfikaty |
| Konfiguracja load balancera | Dodawaj/usuwaj hosty z puli |
| Aktualizacje DNS | Rejestruj host w DNS |
| Powiadomienia | Wysyłaj alerty Slack/email |
| Operacje bazodanowe | Uruchamiaj migracje na serwerze DB |

## Powiązane

- [[14-Filters_PL]] - Poprzednie: Filtry
- [[16-Collections_PL]] - Następne: Kolekcje
