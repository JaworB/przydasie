# 19-Error-Handling

Error handling controls how Ansible responds to task failures.

## Ignore Errors

```yaml
- name: Task that might fail
  command: /bin/false
  ignore_errors: yes  # Continue even if fails
```

## Check Mode

```yaml
- name: Task in check mode only
  command: /bin/sensitive-command
  check_mode: yes
  diff: yes
```

## Changed When

```yaml
- name: Check if file contains pattern
  command: grep -q "pattern" /path/to/file
  register: grep_result
  changed_when: grep_result.rc == 0
```

## Failed When

```yaml
- name: Fail if disk space is low
  ansible.builtin.shell: df / | tail -1 | awk '{print $5}' | tr -d '%'
  register: disk_usage
  failed_when: (disk_usage.stdout | int) > 90
```

## Retry Task

```yaml
- name: Retry until success
  command: /bin/connect-to-service
  register: result
  until: result.rc == 0
  retries: 5
  delay: 10
```

## Rescue Block

```yaml
- name: Block with rescue
  block:
    - name: Task that might fail
      command: /bin/false
  rescue:
    - name: Recovery task
      debug:
        msg: "Task failed, running rescue"
    - name: Ensure service is running
      service:
        name: backup-service
        state: started
```

## Always Run

```yaml
- name: Task with always
  block:
    - name: Task 1
      command: /bin/false
  rescue:
    - name: Rescue
      debug:
        msg: "Failed"
  always:
    - name: Always run
      debug:
        msg: "This always runs"
```

## Any Errors Fatal

```yaml
- name: Play with fatal errors
  hosts: all
  any_errors_fatal: yes  # Any failure stops entire play
  tasks:
    - name: Critical task
      command: /bin/critical
```

## Changed Within Block

```yaml
- name: Complex change detection
  block:
    - name: Get current config
      command: cat /etc/app.conf
      register: current_config

    - name: Write new config
      copy:
        content: |
          new config
        dest: /etc/app.conf
        backup: yes
      register: write_result

    - name: Detect change
      set_fact:
        config_changed: "{{ write_result.changed }}"
  always:
    - name: Notify on change
      debug:
        msg: "Configuration was updated"
    - name: Restart if changed
      service:
        name: app
        state: restarted
      when: config_changed | bool
```

## Best Practices

1. **Use ignore_errors sparingly** - Only for truly optional tasks
2. **Use rescue blocks** - For graceful degradation
3. **Define failure conditions** - `failed_when` for complex logic
4. **Use retry** - For external service dependencies
5. **Any_errors_fatal** - For critical multi-host deployments

## Related

- [[18-Blocks]] - Previous: Blocks
- [[01-Playbooks]] - Back to: Playbooks
