# 15-Delegation

Delegation runs tasks on a different host than the target.

## Delegate_to Syntax

```yaml
- name: Task on different host
  delegate_to: hostname
  module_name:
    option: value
```

## Examples from Repository

### Delegate to Localhost

```yaml
- name: Create backup directory on controller
  delegate_to: localhost
  ansible.builtin.file:
    path: "{{ playbook_dir }}/ssh_keys/{{ inventory_hostname }}"
    state: directory
    mode: '0755'
```

## Delegate to Specific Host

```yaml
- name: Get facts from load balancer
  delegate_to: lb01
  ansible.builtin.setup:
    filter: "*eth0*"

- name: Add server to load balancer pool
  community.general.haproxy:
    state: present
    host: "{{ inventory_hostname }}"
    backend: web
  delegate_to: lb01
```

## Delegate with Facts

```yaml
- name: Gather facts on specific host
  delegate_to: "{{ item }}"
  setup:
  loop: "{{ groups['load_balancers'] }}"
```

## Local Actions

```yaml
- name: Run locally
  delegate_to: localhost
  local_action:
    module: community.general.slack
    token: "{{ slack_token }}"
    msg: "Deployment complete"

# Shorthand
- name: Send notification
  local_action:
    module: ansible.builtin.debug
    msg: "Task completed"
```

## Delegate Facts

By default, delegated tasks don't update `ansible_facts`. Use `gather_facts: no` or:

```yaml
- name: Gather facts on delegate
  delegate_to: "{{ new_host }}"
  setup:
  register: new_host_facts

- name: Use delegated facts
  debug:
    msg: "{{ new_host_facts.ansible_hostname }}"
```

## Use Cases

| Use Case | Example |
|----------|---------|
| Controller operations | Create files locally, fetch certificates |
| Load balancer config | Add/remove hosts from pool |
| DNS updates | Register host in DNS |
| Notifications | Send Slack/email alerts |
| Database operations | Run migrations on DB server |

## Related

- [[14-Filters]] - Previous: Filters
- [[16-Collections]] - Next: Collections
