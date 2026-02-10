# Getting Started

Initialize or clone a Git repository.

## git init

Initialize a new Git repository.

```bash
# Create new repository
git init

# Create in specific directory
git init my-project

# Options:
--initial-branch=NAME     # Set initial branch name
--bare                    # Create bare repository (for servers)
-q, --quiet               # Suppress output
```

**Example:**
```bash
$ git init my-project
Initialized empty Git repository in /home/user/my-project/.git/
```

## git clone

Copy an existing remote repository.

```bash
# Clone via HTTPS
git clone https://github.com/username/repo.git

# Clone via SSH
git clone git@github.com:username/repo.git

# Clone to specific directory
git clone url my-project

# Clone specific branch
git clone -b branch-name url

# Clone with depth (shallow clone)
git clone --depth 1 url
```

**Example:**
```bash
$ git clone git@github.com:username/przydasie.git
Cloning into 'przydasie'...
remote: Enumerating objects: 100, done.
Receiving objects: 100% (100/100), 1.2 MB, done.
```

## Related

- See [[02-Core-Concepts]] for repository concepts
- See [[05-Basic-Workflow]] for next steps after init/clone
- See [[12-Remotes]] for remote operations

## Next Steps

Proceed to [[05-Basic-Workflow]] to learn the basic Git workflow.
