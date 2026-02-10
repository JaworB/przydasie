# 06-Loops

Loops repeat tasks over multiple items.

## Loop Syntax

```yaml
- name: Task name
  module_name:
    option: "{{ item }}"
  loop:
    - item1
    - item2
    - item3
```

## Loop with Dictionary

```yaml
- name: Create users
  ansible.builtin.user:
    name: "{{ item.username }}"
    groups: "{{ item.groups }}"
  loop: "{{ user_list }}"
```

Where `user_list` is:
```yaml
user_list:
  - username: alice
    groups: wheel
  - username: bob
    groups: developers
```

## Examples from Repository

### Loop over User Details

```yaml
- name: Create groups
  ansible.builtin.group:
    name: "{{ item.groups }}"
    state: present
  when: item.groups is defined
  loop: "{{ role_users_user_details }}"

- name: Create users - with password
  ansible.builtin.user:
    name: "{{ item.username }}"
    groups: "{{ item.groups | default('') }}"
    append: true
    password: "{{ vault_user_password | password_hash('sha512') }}"
  loop: "{{ role_users_user_details }}"
```

### Loop over Package Lists

```yaml
- name: Install wireguard packages (Debian/Ubuntu)
  ansible.builtin.package:
    name:
      - wireguard
      - wireguard-tools
      - resolvconf
    state: present
  when: ansible_os_family == "Debian"

- name: Install Docker packages (Debian/Ubuntu)
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

### Loop with Indexed Items

```yaml
- name: Generate SSH keys
  community.crypto.openssh_keypair:
    path: "/home/{{ item.username }}/.ssh/id_rsa"
    owner: "{{ item.username }}"
  loop: "{{ role_users_user_details }}"

- name: Fetch private keys
  ansible.builtin.fetch:
    src: "/home/{{ item.username }}/.ssh/id_rsa"
    dest: "{{ playbook_dir }}/ssh_keys/{{ inventory_hostname }}/{{ item.username }}"
    flat: yes
  loop: "{{ role_users_user_details }}"
```

## Loop Control

```yaml
- name: Task with loop control
  debug:
    msg: "{{ item }} - {{ loop.index }}"
  loop:
    - a
    - b
    - c
  loop_control:
    index_var: my_index
    label: "{{ item.name }}"
```

| Loop Control Option | Purpose |
|--------------------|----------|
| `loop_control.index_var` | Set variable name for index |
| `loop_control.label` | Control item display |
| `loop_control.pause` | Pause between iterations |
| `extended` | Enable extended info |

## Related

- [[05-Conditionals]] - Previous: Conditionals
- [[07-Variables]] - Next: Variables
