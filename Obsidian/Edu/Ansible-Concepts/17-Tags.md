# 17-Tags

Tags allow selective execution of parts of a playbook.

## Tag Syntax

```yaml
- name: Task with tags
  module_name:
    option: value
  tags:
    - tag1
    - tag2

# Single tag shorthand
- name: Task
  tags: always
  debug:
    msg: "Always runs"
```

## Tag a Play

```yaml
- name: Play with tags
  hosts: all
  tags: web
  tasks:
    - name: Task
      debug:
        msg: "Tagged task"
```

## Tag a Role

```yaml
- name: Play with tagged role
  hosts: all
  roles:
    - role: nginx
      tags: web
```

## Run with Tags

```bash
# Run tagged tasks
ansible-playbook playbook.yml --tags "web"

# Skip tagged tasks
ansible-playbook playbook.yml --skip-tags "debug"

# Multiple tags
ansible-playbook playbook.yml --tags "web,db"
ansible-playbook playbook.yml --skip-tags "debug,verbose"

# List tags without running
ansible-playbook playbook.yml --list-tags
```

## Common Tag Names

| Tag | Purpose |
|-----|---------|
| `always` | Always run (unless skipped) |
| `never` | Never run (unless explicitly tagged) |
| `web` | Web server tasks |
| `db` | Database tasks |
| `security` | Security-related tasks |
| `config` | Configuration tasks |

## Tag Inheritance

Tags are inherited:
- Play tags apply to all tasks in the play
- Role tags apply to all tasks in the role
- Task tags are in addition to inherited tags

## Examples

```yaml
- name: Install packages
  ansible.builtin.apt:
    name: "{{ item }}"
  loop:
    - nginx
    - git
    - vim
  tags:
    - packages
    - web

- name: Configure nginx
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
  tags:
    - nginx
    - config
  notify: Restart nginx

- name: Start services
  service:
    name: nginx
    state: started
  tags:
    - services
    - web
```

## Related

- [[16-Collections]] - Previous: Collections
- [[18-Blocks]] - Next: Blocks
