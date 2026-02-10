# Education Index

## Programming Concepts

### Bash Scripting
- [[Bash-Scripting-Concepts/index]] - Bash scripting fundamentals (start here)
- [[Bash-Scripting-Concepts/01-Shebang]] - Shebang and interpreter
- [[Bash-Scripting-Concepts/02-Functions]] - Functions and scope
- [[Bash-Scripting-Concepts/03-Variables]] - Global vs local variables
- [[Bash-Scripting-Concepts/04-Conditionals]] - Test brackets and conditionals
- [[Bash-Scripting-Concepts/05-Control-Flow]] - While/for loops
- [[Bash-Scripting-Concepts/06-Command-Substitution]] - Output capture
- [[Bash-Scripting-Concepts/07-Error-Handling]] - Error handling and exit codes
- [[Bash-Scripting-Concepts/08-Process-Management]] - Background processes
- [[Bash-Scripting-Concepts/09-Logical-Operators]] - AND and OR operators
- [[Bash-Scripting-Concepts/10-Hyprland-Integration]] - hyprctl commands
- [[Bash-Scripting-Concepts/11-Sleep-and-Timing]] - Timing and delays
- [[Bash-Scripting-Concepts/12-Toggle-Pattern]] - State machine toggle
- [[Bash-Scripting-Concepts/13-Event-Detection-Pattern]] - State change detection
- [[Bash-Scripting-Concepts/14-Best-Practices]] - Daemon best practices
- [[Bash-Scripting-Concepts/15-Quick-Reference]] - Tables and summaries

### Ansible
- [[Ansible-Concepts/index]] - Ansible fundamentals (start here)
- [[Ansible-Concepts/01-Playbooks]] - Playbook structure
- [[Ansible-Concepts/02-Inventory]] - Inventory and groups
- [[Ansible-Concepts/03-Roles]] - Role organization
- [[Ansible-Concepts/04-Modules]] - Module usage
- [[Ansible-Concepts/05-Conditionals]] - When clauses
- [[Ansible-Concepts/06-Loops]] - Loop constructs
- [[Ansible-Concepts/07-Variables]] - Variables and precedence
- [[Ansible-Concepts/08-Vault]] - Ansible Vault encryption
- [[Ansible-Concepts/09-Templates]] - Jinja2 templating
- [[Ansible-Concepts/10-Handlers]] - Handlers and notifications
- [[Ansible-Concepts/11-Privilege-Escalation]] - Become and sudo
- [[Ansible-Concepts/12-Facts]] - Gathered facts
- [[Ansible-Concepts/13-Lookups]] - Lookup plugins
- [[Ansible-Concepts/14-Filters]] - Jinja2 filters
- [[Ansible-Concepts/15-Delegation]] - Delegation and local actions
- [[Ansible-Concepts/16-Collections]] - Ansible Collections
- [[Ansible-Concepts/17-Tags]] - Selective execution
- [[Ansible-Concepts/18-Blocks]] - Blocks
- [[Ansible-Concepts/19-Error-Handling]] - Error handling

## Topics Covered

### Bash Scripting
- Shebang and interpreter selection
- Functions and scope (local vs global variables)
- Conditionals and test brackets
- Control flow (while loops, daemon pattern)
- Command substitution and output capture
- Error handling and stderr redirection
- Process management (background processes)
- Logical operators (AND, OR)
- Common patterns (daemon, toggle, event detection)
- Hyprland integration with hyprctl

### Ansible
- Playbooks and execution flow
- Inventory management (groups, host_vars, group_vars)
- Role structure (tasks, handlers, vars, templates)
- Module types (ansible.builtin, ansible.posix, community.*)
- Conditionals (when clauses, OS detection)
- Loops (loop, with_items)
- Variables (vars, vars_files, vault)
- Templates (Jinja2)
- Handlers (notify, handlers/main.yml)
- Privilege escalation (become, sudo)
- Facts (gather_facts, ansible_facts)
- Lookups (lookup plugin)
- Filters (Jinja2 filters, password_hash)
- Delegation (delegate_to)
- Collections (community.general, community.crypto)
- Tags (selective execution)
- Blocks (grouping tasks)
- Error handling (ignore_errors, rescue)

## Related

- [[Manuals/Arch_after_install/01-DisplayLink-Setup]] - DisplayLink setup index
- [[Manuals/Arch_after_install/02-DisplayLink-Dock-Setup]] - Driver installation guide
- [[Manuals/Arch_after_install/03-Lid-Switch-Automation]] - Real-world daemon implementation
