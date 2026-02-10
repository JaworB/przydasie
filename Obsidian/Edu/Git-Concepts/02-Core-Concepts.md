# Core Concepts

Essential Git concepts every developer must understand.

## Repository

A **repository** (repo) is a project directory containing all project files and Git's tracking data.

```
project/
├── .git/          # Hidden folder with all Git data
├── src/           # Your source code
└── README.md      # Documentation
```

**Types:**
- **Local repo**: `.git` folder on your machine
- **Remote repo**: Server (GitHub, GitLab) hosting the project

## Commit

A **commit** is a snapshot of your project at a specific point in time.

```
A---B---C---D---E  (main branch)
```

Each commit contains:
- **SHA-1 hash**: Unique identifier (e.g., `a1b2c3d`)
- **Author**: Who made the change
- **Date**: When it was made
- **Message**: Description of changes
- **Parent**: Previous commit
- **Files**: Snapshot of project state

## Branch

A **branch** is an independent line of development.

```
main:     A---B---C---D---E
               \
feature:        F---G---H---I
```

**Key branches:**
- **main/master**: Primary stable branch
- **develop**: Integration branch for features
- **feature/**: New feature development
- **bugfix/**: Bug fixes
- **hotfix/**: Emergency production fixes

## HEAD

**HEAD** is a pointer to your current location (current commit).

```
HEAD -> main -> E
```

Or when on a branch:
```
HEAD -> feature -> I
```

**Detached HEAD**: When you checkout a specific commit (not a branch):
```
HEAD (detached) -> C
```

## Working Directory

The **working directory** contains your actual project files - what you see and edit.

```
+-------------------+
|   Working Dir     |
|  (your files)    |
|  index.html      |
|  style.css       |
|  app.js          |
+-------------------+
```

## Staging Area (Index)

The **staging area** is where you prepare changes before committing.

```
+-------------------+      git add       +-------------------+
|   Working Dir     |  ----------------> |   Staging Area    |
|  (your files)    |                    |   (Index)        |
+-------------------+                    +-------------------+
```

## Git Architecture Diagram

```
+-------------------+
|   Remote Repo    |
|  (GitHub/GitLab) |
|                  |
+---------+---------+
          |
          | git push / git pull
          v
+---------+---------+
|    Local Repo     |
|  (.git folder)    |
|  - Commits       |
|  - Branches      |
|  - Tags          |
+---------+---------+
          |
          | git commit
          v
+---------+---------+
|   Staging Area    |
|     (Index)       |
|  - Staged files  |
+---------+---------+
          |
          | git add
          v
+---------+---------+
|  Working Directory|
|    (your files)   |
+-------------------+
```

## Related

- See [[03-Git-Internals]] for how Git stores data
- See [[05-Basic-Workflow]] for using these concepts
- See [[08-Branching]] for branch management

## Next Steps

Proceed to [[03-Git-Internals]] to understand how Git stores data internally.
