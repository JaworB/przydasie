# 06-Loops

Pętle powtarzają zadania na wielu elementach.

## Składnia pętli

```yaml
- name: Nazwa zadania
  nazwa_modułu:
    opcja: "{{ item }}"
  loop:
    - element1
    - element2
    - element3
```

## Pętla ze słownikiem

```yaml
- name: Twórz użytkowników
  ansible.builtin.user:
    name: "{{ item.username }}"
    groups: "{{ item.groups }}"
  loop: "{{ lista_użytkowników }}"
```

Gdzie `lista_użytkowników` to:
```yaml
lista_użytkowników:
  - username: alice
    groups: wheel
  - username: bob
    groups: developers
```

## Przykłady z repozytorium

### Pętla po szczegółach użytkowników

```yaml
- name: Twórz grupy
  ansible.builtin.group:
    name: "{{ item.groups }}"
    state: present
  when: item.groups is defined
  loop: "{{ role_users_user_details }}"

- name: Twórz użytkowników - z hasłem
  ansible.builtin.user:
    name: "{{ item.username }}"
    groups: "{{ item.groups | default('') }}"
    append: true
    password: "{{ vault_user_password | password_hash('sha512') }}"
  loop: "{{ role_users_user_details }}"
```

### Pętla po listach pakietów

```yaml
- name: Zainstaluj pakiety wireguard (Debian/Ubuntu)
  ansible.builtin.package:
    name:
      - wireguard
      - wireguard-tools
      - resolvconf
    state: present
  when: ansible_os_family == "Debian"

- name: Zainstaluj pakiety Docker (Debian/Ubuntu)
  ansible.builtin.package:
    name:
      - docker-ce
      - docker-ce-cli
      - containerd.io
      - docker-buildx-plugin
      - docker-compose-plugin
    state: present
  when: ansible_os_family == "Debian"
```

### Pętla z indeksowanymi elementami

```yaml
- name: Generuj klucze SSH
  community.crypto.openssh_keypair:
    path: "/home/{{ item.username }}/.ssh/id_rsa"
    owner: "{{ item.username }}"
  loop: "{{ role_users_user_details }}"

- name: Pobierz klucze prywatne
  ansible.builtin.fetch:
    src: "/home/{{ item.username }}/.ssh/id_rsa"
    dest: "{{ playbook_dir }}/ssh_keys/{{ inventory_hostname }}/{{ item.username }}"
    flat: yes
  loop: "{{ role_users_user_details }}"
```

## Kontrola pętli

```yaml
- name: Zadanie z kontrolą pętli
  debug:
    msg: "{{ item }} - {{ loop.index }}"
  loop:
    - a
    - b
    - c
  loop_control:
    index_var: moj_indeks
    label: "{{ item.name }}"
```

| Opcja kontroli pętli | Przeznaczenie |
|---------------------|---------------|
| `loop_control.index_var` | Ustaw nazwę zmiennej dla indeksu |
| `loop_control.label` | Kontroluj wyświetlanie elementu |
| `loop_control.pause` | Pauza między iteracjami |
| `extended` | Włącz rozszerzone informacje |

## Powiązane

- [[05-Conditionals_PL]] - Poprzednie: Warunki
- [[07-Variables_PL]] - Następne: Zmienne
