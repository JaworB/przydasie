# 18-Blocks

Blocks group tasks and enable error handling.

## Block Syntax

```yaml
- name: Block name
  block:
    - name: Task 1
      module1:
        option: value

    - name: Task 2
      module2:
        option: value
  rescue:
    - name: Rescue task
      module3:
        option: value
  always:
    - name: Always task
      module4:
        option: value
```

## Block Sections

| Section | Purpose |
|---------|---------|
| `block` | Main tasks to execute |
| `rescue` | Tasks if block fails |
| `always` | Tasks that always run |

## Block with Error Handling

```yaml
- name: Install package with fallback
  block:
    - name: Try to install package
      ansible.builtin.apt:
        name: special-package
        state: present
  rescue:
    - name: Install alternative
      ansible.builtin.apt:
        name: standard-package
        state: present
    - name: Notify about failure
      debug:
        msg: "Original package not available, installed alternative"
  always:
    - name: Always notify
      debug:
        msg: "Installation attempt completed"
```

## Block with When Condition

```yaml
- name: Block with condition
  when: ansible_os_family == "Debian"
  block:
    - name: Task 1
      debug:
        msg: "Debian-specific task"

    - name: Task 2
      debug:
        msg: "Another Debian task"
```

## Block with Tags

```yaml
- name: Tagged block
  tags: web
  block:
    - name: Task 1
      debug:
        msg: "Web task"

    - name: Task 2
      debug:
        msg: "Another web task"
```

## Nested Blocks

```yaml
- name: Outer block
  block:
    - name: Inner block 1
      block:
        - name: Task 1
          debug:
            msg: "Task 1"

    - name: Inner block 2
      block:
        - name: Task 2
          debug:
            msg: "Task 2"
```

## Use Cases

1. **Error handling** - Graceful failure and recovery
2. **Grouping** - Organize related tasks
3. **Conditional blocks** - Apply condition to multiple tasks
4. **Cleanup** - Always run cleanup tasks
5. **Retry logic** - Combine with `until` for retry

## Related

- [[17-Tags]] - Previous: Tags
- [[19-Error-Handling]] - Next: Error Handling
