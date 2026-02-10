# Git Concepts

Comprehensive reference guide for Git version control system.

---

## 1. Introduction

Git is a **distributed version control system** that tracks changes in source code during software development. It enables multiple developers to collaborate, maintain history, and manage different versions of a project.

### Key Features

- **Distributed**: Every developer has a full copy of the repository
- **Non-linear**: Supports parallel development via branches
- **Track changes**: Records every modification
- **Backup**: Complete history stored locally
- **Collaboration**: Remote servers sync changes

---

## 2. Core Concepts

### 2.1 Repository

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

---

### 2.2 Commit

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

---

### 2.3 Branch

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

---

### 2.4 HEAD

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

---

### 2.5 Working Directory

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

---

### 2.6 Staging Area (Index)

The **staging area** is where you prepare changes before committing.

```
+-------------------+      git add       +-------------------+
|   Working Dir     |  ----------------> |   Staging Area    |
|  (your files)    |                    |   (Index)        |
+-------------------+                    +-------------------+
```

---

### 2.7 Git Architecture Diagram

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

---

## 3. Git Internals

### 3.1 SHA-1 Hash

Git uses **SHA-1** (Secure Hash Algorithm 1) to create unique identifiers.

```bash
# Each object gets a 40-character hex hash
a1b2c3d4e5f6789abcdef0123456789abcdef01

# First few characters are usually enough
a1b2c3d
```

**Why SHA-1?**
- Unique identifier for each object
- Content-addressable storage
- Integrity verification

---

### 3.2 Git Objects

Git stores everything as one of four object types:

#### Blob (Binary Large Object)
Stores file content (not metadata).

```
Hash = SHA1("file content")
```

#### Tree
Stores directory structure and file references.

```
tree/
  ├── file1.txt (blob)
  ├── file2.txt (blob)
  └── subdir/   (tree)
```

#### Commit
Links trees with metadata.

```
commit
  ├── tree: project snapshot
  ├── parent: previous commit
  ├── author: who wrote it
  ├── committer: who applied it
  └── message: description
```

#### Tag
Marks a specific commit (used for releases).

```
tag: v1.0.0 -> commit ABC123
```

---

### 3.3 Object Storage

```
.git/
├── objects/
│   ├── a1/
│   │   └── b2c3d4...  (compressed blob)
│   ├── b2/
│   │   └── c3d4e5...  (compressed commit)
│   └── info/          # Object info
│   └── pack/          # Packed objects
├── refs/
│   ├── heads/         # Branch references
│   └── tags/          # Tag references
└── HEAD               # Current HEAD
```

---

## 4. Getting Started

### 4.1 git init

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

---

### 4.2 git clone

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

---

## 5. Basic Workflow

### 5.1 git status

Show working tree status.

```bash
# Show full status
git status

# Short format
git status -s

# Show branch info
git status -b

# Show untracked files
git status -u

# Example output (full):
On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  modified:   src/index.js
  deleted:     lib/utils.py

Untracked files:
  new-feature/
```

**Status codes (-s):**
```
 M  - Modified in working dir, staged in index
M   - Modified in index, staged in working dir
??  - Untracked
A   - Added to index
D   - Deleted from index
```

---

### 5.2 git add

Add changes to staging area.

```bash
# Stage specific file
git add path/to/file.txt

# Stage all changes
git add .

# Stage all changes (recursive)
git add -A

# Stage new and modified files (not deleted)
git add --update

# Interactive staging
git add -i

# Stage portions of files
git add -p

# Dry run
git add --dry-run path/
```

**Example:**
```bash
$ git add src/app.js lib/utils.py
$ git status
Changes to be committed:
  new file:   src/app.js
  modified:   lib/utils.py
```

---

### 5.3 git commit

Commit staged changes.

```bash
# Commit with message
git commit -m "Add user authentication"

# Commit with multi-line message
git commit -m "Title" -m "Body description"

# Amend last commit
git commit --amend

# Amend without changing message
git commit --amend --no-edit

# Commit as different author
git commit --author="Name <email>"

# Change commit date
git commit --date="2024-01-15"

# Skip hooks
git commit --no-verify

# Show diff in message editor
git commit -v
```

**Example:**
```bash
$ git commit -m "Implement login feature

- Add user model
- Create login API endpoint
- Add session management

Closes #42"
```

---

### 5.4 Commit Message Best Practices

**Structure:**
```
type(scope): subject

body (optional)

footer (optional)
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation
- `style`: Formatting
- `refactor`: Restructuring
- `test`: Testing
- `chore`: Maintenance

**Example:**
```
feat(auth): Add JWT token authentication

Implement JWT-based authentication for API endpoints.

Closes #123
Reviewed-by: @team-lead
```

---

## 6. Inspection

### 6.1 git log

Show commit history.

```bash
# Basic history
git log

# Compact (one line per commit)
git log --oneline

# Show N commits
git log -5
git log --max-count=5

# Filter by author
git log --author="John"

# Filter by message
git log --grep="fix bug"

# Show file history
git log --follow path/to/file

# Show changes
git log -p

# Show stat summary
git log --stat

# Graph visualization
git log --graph --oneline

# Time-based filter
git log --since="2024-01-01"
git log --until="2024-12-31"

# Pretty formats
git log --pretty=format:"%h - %s"
git log --pretty=format:"%h %ad %s" --date=short
```

**Format placeholders:**
```
%h    - Abbreviated commit hash
%H    - Full commit hash
%s    - Subject
%b    - Body
%ad   - Author date
%an   - Author name
%ae   - Author email
%cd   - Committer date
%cn   - Committer name
```

**Example:**
```bash
$ git log --oneline --graph
* a1b2c3d (HEAD -> main) Fix: Resolve memory leak
* d4e5f6g Merge pull request #45
|\
| * g7h8i9j feat: Add caching layer
* | h0i1j2k chore: Update dependencies
|/
* k2l3m4n feat: User dashboard
```

---

### 6.2 git diff

Show changes between commits, working directory, and staging area.

```bash
# Show unstaged changes
git diff

# Show staged changes
git diff --cached
git diff --staged

# Compare branches
git diff main..feature

# Compare specific files
git diff path/to/file

# Show only filenames
git diff --name-only

# Show only additions/deletions
git diff --stat

# Word diff
git diff --word-diff

# Example:
$ git diff src/auth.js
diff --git a/src/auth.js b/src/auth.js
index 1234567..89abcde 100644
--- a/src/auth.js
+++ b/src/auth.js
@@ -10,5 +10,8 @@ function login(user) {
   if (!user.password) {
     throw new Error('Password required');
   }
+  // Check if account is locked
+  if (user.isLocked) {
+    throw new Error('Account locked');
+  }
   return authenticate(user);
 }
```

---

### 6.3 git show

Show details of a specific commit or object.

```bash
# Show last commit
git show

# Show specific commit
git show abc1234

# Show commit with diff
git show -p abc1234

# Show file at specific commit
git show abc1234:path/to/file

# Show tag
git show v1.0.0

# Show parent commits
git show --parents abc1234

# Example:
$ git show abc1234
commit abc1234567890
Author: John Doe <john@example.com>
Date:   2024-01-15 10:30

    Add user registration feature

diff --git a/src/register.js b/src/register.js
...
```

---

### 6.4 git blame

Show who last modified each line in a file.

```bash
# Blame entire file
git blame path/to/file

# Blame with commit info
git blame -L 10,20 path/to/file

# Show author email
git blame -e path/to/file

# Ignore whitespace
git blame -w path/to/file

# Example:
$ git blame src/app.js
^a1b2c3d (Alice    2024-01-01)  import React from 'react';
^d4e5f6g (Bob      2024-01-05)  import { useState } from 'react';
^g7h8i9j (Carol   2024-01-10)  function App() {
h0i1j2k3 (Dave     2024-01-15)    const [count, setCount] = useState(0);
```

---

### 6.5 git branch

Manage branches.

```bash
# List branches
git branch

# List all branches (including remote)
git branch -a

# List with last commit
git branch -v

# List merged branches
git branch --merged

# List unmerged branches
git branch --no-merged

# Create new branch
git branch feature/login

# Create and switch
git checkout -b feature/login
git switch -c feature/login

# Delete branch
git branch -d feature/login    # Safe delete
git branch -D feature/login    # Force delete

# Rename branch
git branch -m old-name new-name

# Delete remote branch
git push origin --delete feature/login
```

---

## 7. Undo & Fix Mistakes

### 7.1 git restore

Restore files from index or commit.

```bash
# Restore from staging area
git restore --staged path/to/file

# Restore from last commit
git restore path/to/file

# Restore to specific commit
git restore --source=abc1234 path/to/file

# Restore all files
git restore .

# Restore with working dir cleanup
git restore --worktree --source=HEAD -- path/

# Example:
$ git status
Changes not staged for commit:
  modified:   src/config.js

$ git restore src/config.js
# File is now back to last committed state
```

---

### 7.2 git reset

Move HEAD to a previous commit.

```bash
# Soft reset (keep changes staged)
git reset --soft HEAD~1

# Mixed reset (default, keep changes in working dir)
git reset HEAD~1

# Hard reset (discard all changes)
git reset --hard HEAD~1

# Reset to specific commit
git reset --hard abc1234

# Reset only specific files
git reset HEAD~1 -- path/to/file

# Mixed reset details:
# - Moves HEAD
# - Keeps changes in staging area
# - Does NOT touch working directory
```

**Reset vs Revert:**

| Reset | Revert |
|-------|--------|
| Rewrites history | Creates new commit |
| Changes commit pointer | Preserves history |
| Dangerous on shared branches | Safe for collaboration |

---

### 7.3 git revert

Create new commit that undoes changes.

```bash
# Revert last commit
git revert HEAD

# Revert specific commit
git revert abc1234

# Revert without auto-commit
git revert --no-commit abc1234
git revert --continue

# Revert merge commit
git revert -m 1 abc1234

# Example:
$ git log --oneline
a1b2c3d Add feature (current)
d4e5f6g Fix bug

$ git revert a1b2c3d
[main f6g7h8i] Revert "Add feature"
```

---

### 7.4 git commit --amend

Modify the last commit.

```bash
# Change last commit message
git commit --amend -m "New message"

# Add files to last commit
git add forgotten-file.txt
git commit --amend --no-edit

# Change author
git commit --amend --author="Name <email>"

# ⚠️ WARNING: Don't amend public commits!
```

---

### 7.5 git clean

Remove untracked files.

```bash
# Preview what would be deleted
git clean --dry-run
git clean -n

# Remove untracked files
git clean -f

# Remove untracked directories
git clean -fd

# Remove ignored files
git clean -fX

# Remove everything (including ignored)
git clean -fx

# Example:
$ git status
Untracked files:
  debug.log
  temp/

$ git clean -fd
Removing debug.log
Removing temp/
```

---

## 8. Branching & Merging

### 8.1 Branching Diagram

```
                    feature/login
                    |
A---B---C---D---E---+---F---G---H  (main)
            \       \
             \       \
              I---J---K---L---M---N  (feature/auth)
```

---

### 8.2 git merge

Join branch history.

```bash
# Merge feature into current branch
git merge feature-branch

# Fast-forward merge
git merge feature-branch

# No fast-forward (creates merge commit)
git merge --no-ff feature-branch

# Squash commits
git merge --squash feature-branch
git commit -m "Merge feature"

# Merge with strategy
git merge -X ours feature-branch     # Prefer our changes
git merge -X theirs feature-branch   # Prefer their changes

# Abort merge
git merge --abort

# Example fast-forward:
# Before:
# main:     A---B---C
#                  \
# feature:           D---E---F

$ git checkout main
$ git merge feature
# After:
# main:     A---B---C---D---E---F
```

---

### 8.3 Merge Types

**Fast-forward merge:**
```
Before:                     After:
A---B---C  main             A---B---C---D---E---F  main
        \                                    /
         D---E---F  feature ---------------
```

**No fast-forward merge:**
```
Before:                     After:
A---B---C  main             A---B---C-------G  main
        \                  /         \
         D---E---F  feature           D---E---F  feature
                                    (G = merge commit)
```

---

### 8.4 Conflict Resolution

**When conflicts occur:**
```
<<<<<<< HEAD
const name = "Alice";
=======
const name = "Bob";
>>>>>>> feature-branch
```

**Resolution steps:**

```bash
# 1. Open file and fix conflicts
vim path/to/file

# 2. Mark as resolved
git add path/to/file

# 3. Complete merge
git commit
```

**Conflict markers:**
```
<<<<<<< HEAD
(current branch changes)
=======
(incoming branch changes)
>>>>>>> branch-name
```

**Commands for conflict info:**
```bash
# Show conflicted files
git diff --name-only --diff-filter=U

# Show all changes including common ancestor
git diff --base

# Show changes from our branch
git diff --ours

# Show changes from their branch
git diff --theirs
```

---

### 8.5 git checkout / git switch

Switch branches.

```bash
# Switch to existing branch
git checkout feature-branch
git switch feature-branch

# Create and switch
git checkout -b new-branch
git switch -c new-branch

# Switch to previous branch
git checkout -
git switch -

# Detach HEAD (switch to specific commit)
git checkout abc1234

# Force switch (discard local changes)
git checkout -f feature-branch
git switch -f feature-branch

# ⚠️ WARNING: Uncommitted changes may be lost!
```

---

## 9. Interactive Rebase

Rewrite commit history interactively.

```bash
# Start interactive rebase
git rebase -i HEAD~N

# Or from specific commit
git rebase -i abc1234
```

**Commands in interactive mode:**

| Command | Description |
|---------|-------------|
| `pick` | Keep commit as-is |
| `reword` | Change commit message |
| `edit` | Stop at this commit to amend |
| `squash` | Combine with previous commit |
| `fixup` | Like squash but discard message |
| `drop` | Remove commit |
| `exec` | Run shell command |

**Example:**
```
pick a1b2c3d Add user model
pick d4e5f6g Add login page
squash g7h8i9j Fix typo in user model
pick i0j1k2l Add logout functionality
```

---

### 9.1 Squashing Commits

**Before rebase:**
```
pick Add user model
pick Add login API
pick Fix typo
pick Add logout
```

**After rebase:**
```
pick Add user model
fixup Add login API
fixup Fix typo
pick Add logout
```

**Result:** All combined into one "Add user model" commit

---

### 9.2 Reword Commit Message

```
pick a1b2c3d Add user model
reword d4e5f6g Add login API  <-- editor opens, change message
pick g7h8i9j Add logout
```

---

### 9.3 Edit Single Commit

```
edit a1b2c3d Add user model
# Git stops at this commit

# Make changes
git add forgotten-file.txt
git commit --amend

# Continue rebase
git rebase --continue
```

---

### 9.4 git rebase Options

```bash
# Abort rebase
git rebase --abort

# Skip commit
git rebase --skip

# Continue after conflicts
git rebase --continue

# Rebase onto different base
git rebase --onto new-base old-base branch

# Interactive rebase
git rebase -i HEAD~10

# Preserve merges
git rebase -p

# Rebase without changing dates
git rebase --no-ignore-date
```

---

## 10. Git Bisect

Binary search to find the commit that introduced a bug.

### 10.1 How It Works

```
Search range: 100 commits

Step 1: Test commit 50  -> BAD
Step 2: Test commit 25  -> GOOD
Step 3: Test commit 37  -> BAD
Step 4: Test commit 31  -> GOOD
Step 5: Test commit 34  -> BAD
Found: First bad commit at position 34
```

---

### 10.2 Manual Bisect

```bash
# Start bisect
git bisect start

# Mark current commit as bad
git bisect bad

# Mark a known good commit
git bisect good v1.0.0

# Git checks out middle commit
# ... test the code ...

# Mark result
git bisect good    # or git bisect bad

# Repeat until Git finds it

# End bisect
git bisect reset
```

---

### 10.3 Automated Bisect

```bash
# Run test script automatically
git bisect start
git bisect bad
git bisect good v1.0.0
git bisect run ./test.sh

# Exit codes:
# 0 = good (pass)
# 1 = bad (fail)
# 125 = skip this commit
```

**Test script example:**
```bash
#!/bin/bash
# test.sh - Run tests and exit with code

npm test
exit $?
```

---

### 10.4 Bisect Commands Reference

| Command | Description |
|---------|-------------|
| `git bisect start` | Begin bisect session |
| `git bisect bad` | Mark current as bad |
| `git bisect good <commit>` | Mark commit as good |
| `git bisect skip <commit>` | Skip commit |
| `git bisect run <script>` | Automated testing |
| `git bisect reset` | End session |
| `git bisect log` | Show bisect history |
| `git bisect visualize` | Show progress (GUI) |

---

### 10.5 Bisect Example Session

```bash
$ git bisect start
Bisecting: 12 commits left to test after this (roughly 4 steps)

$ git bisect bad
Bisecting: 12 commits left to test (roughly 4 steps)

$ git bisect good v1.0.0
Bisecting: 6 commits left to test (roughly 3 steps)

# Git checks out commit abc1234
# ... run tests ...
$ npm test
Tests failed!

$ git bisect bad
Bisecting: 3 commits left to test (roughly 2 steps)

# Git checks out def5678
# ... run tests ...
$ npm test
Tests passed!

$ git bisect good
abc1234 is the first bad commit
commit abc1234
Author: Developer <dev@example.com>
Date:   2024-01-15

    Add new authentication logic

$ git bisect reset
Bisect reset manually.
```

---

## 11. Stashing

Save changes without committing.

### 11.1 git stash

```bash
# Save current changes
git stash

# Save with message
git stash save "Work in progress"

# Save untracked files too
git stash -u
git stash --include-untracked

# Save all (including ignored)
git stash -a

# Save to specific stash
git stash save "message" --index
```

---

### 11.2 git stash pop

```bash
# Apply last stash and remove it
git stash pop

# Apply specific stash
git stash pop stash@{2}

# Apply without removing
git stash apply
git stash apply stash@{1}
```

---

### 11.3 git stash list

```bash
# List all stashes
git stash list

# Show stash contents
git stash show
git stash show -p

# Show specific stash
git stash show stash@{0}
```

---

### 11.4 git stash drop

```bash
# Remove last stash
git stash drop

# Remove specific stash
git stash drop stash@{2}

# Clear all stashes
git stash clear
```

---

### 11.5 Partial Stashing

```bash
# Stash specific files
git stash push path/to/file1 path/to/file2

# Stash interactively
git stash push -p
# Select hunks to stash:
# y - stash this hunk
# n - don't stash this hunk
# q - quit, don't stash any more
# a - stash this and all remaining
# d - don't stash this or any remaining
```

---

### 11.6 Stash Workflow Example

```bash
$ git status
On branch feature/login
Changes to be committed:
  new file:   src/auth.js

Changes not staged for commit:
  modified:   src/config.js

Untracked files:
  debug.log

# Stash everything
$ git stash -u -m "WIP: Authentication feature"

$ git status
On branch feature/login
nothing to commit (clean)

# ... switch to another branch ...
$ git checkout main

# ... do work ...

# ... back to feature ...
$ git checkout feature/login
$ git stash pop
# Changes restored!
```

---

## 12. Remote Operations

### 12.1 git remote

Manage remote repositories.

```bash
# List remotes
git remote -v

# Add remote
git remote add origin git@github.com:user/repo.git

# Rename remote
git remote rename origin upstream

# Remove remote
git remote remove origin

# Change remote URL
git remote set-url origin new-url

# Show remote details
git remote show origin

# Add all remotes
git remote update

# Prune deleted remote branches
git remote prune origin
```

---

### 12.2 git push

Send commits to remote.

```bash
# Push to remote
git push origin main

# Set upstream and push
git push -u origin feature-branch

# Push all branches
git push --all origin

# Push tags
git push origin v1.0.0
git push --tags

# Delete remote branch
git push origin --delete feature-branch

# Force push
git push --force
git push -f

# ⚠️ WARNING: Never force push to main!

# Push with tags and branches
git push --follow-tags

# Dry run
git push --dry-run
```

---

### 12.3 git fetch

Download objects without merging.

```bash
# Fetch from all remotes
git fetch

# Fetch from specific remote
git fetch origin

# Fetch specific branch
git fetch origin feature-branch

# Fetch all remotes
git fetch --all

# Prune deleted refs
git fetch --prune

# Fetch with tags
git fetch --tags
```

---

### 12.4 git pull

Fetch and merge.

```bash
# Pull (fetch + merge)
git pull origin main

# Pull with rebase instead of merge
git pull --rebase origin main

# Pull specific branch
git pull origin feature-branch

# Pull without auto-commit
git pull --no-commit

# Pull and abort on conflicts
git pull --abort

# Strategies
git pull -X ours           # Prefer ours
git pull -X theirs         # Prefer theirs
```

---

### 12.5 git clone

Copy remote repository.

```bash
# Clone via SSH
git clone git@github.com:user/repo.git

# Clone via HTTPS
git clone https://github.com/user/repo.git

# Clone to specific directory
git clone url my-project

# Shallow clone (1 commit depth)
git clone --depth 1 url

# Clone specific branch
git clone -b branch-name url

# Clone with all remotes
git clone --mirror url
```

---

### 12.6 Remote Workflow Diagram

```
Local Repo                    Remote Repo (origin)
     |                              |
     |   git push                   |
     |----------------------------->|  Push commits
     |                              |
     |   git fetch                  |
     |<-----------------------------|  Download objects
     |                              |
     |   git merge                  |
     |   (in .git/refs/heads/)      |
     |                              |
     |   git push --force           |
     |----------------------------->|  ⚠️ Rewrites history!
```

---

## 13. Tags

Mark specific commits (releases).

### 13.1 Lightweight Tag

```bash
# Create lightweight tag
git tag v1.0.0

# List tags
git tag

# List with pattern
git tag -l "v1.*"

# Delete tag
git tag -d v1.0.0
```

---

### 13.2 Annotated Tag

```bash
# Create annotated tag (stores in Git DB)
git tag -a v1.0.0 -m "Release version 1.0.0"

# Show tag
git show v1.0.0

# Create tag from specific commit
git tag -a v1.0.0 abc1234

# Sign tag (GPG)
git tag -s v1.0.0 -m "Signed release"

# Verify tag
git tag -v v1.0.0
```

---

### 13.3 Push Tags

```bash
# Push single tag
git push origin v1.0.0

# Push all tags
git push --tags

# Delete remote tag
git push origin --delete v1.0.0
```

---

## 14. Aliases

Common shortcuts.

```bash
# Create alias
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.df diff

# Complex aliases
git config --global alias.unstage 'reset HEAD --'
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'

# Useful aliases
git config --global alias.lg "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# Use alias
git lg
```

**Common aliases:**
```bash
git config --global alias.st status
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.ci commit
git config --global alias.df diff
git config --global alias.lg "log --oneline --graph"
git config --global alias.unstage 'reset HEAD --'
git config --global alias.undo 'reset --soft HEAD~1'
git config --global alias.cleanup 'branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
```

---

## 15. Tips & Best Practices

### 15.1 Commit Guidelines

| Do | Don't |
|-----|-------|
| Write clear, concise messages | Use vague messages like "fix" |
| One logical change per commit | Bundle unrelated changes |
| Use imperative mood | Use past tense |
| Keep subject < 50 characters | Write long subject lines |
| Reference issues (#123) | Don't reference issues |

---

### 15.2 Branch Naming

**Conventions:**
```
feature/name          # New feature
bugfix/name           # Bug fix
hotfix/name           # Emergency fix
release/version       # Release preparation
docs/name             # Documentation
refactor/name         # Code restructuring
test/name             # Tests
```

**Examples:**
```
feature/user-authentication
bugfix/login-crash
hotfix/security-patch
release/v1.0.0
docs/update-readme
```

---

### 15.3 Workflow Recommendations

**Feature Branch Workflow:**
```
1. Create branch from main
2. Make commits
3. Push to remote
4. Create pull request
5. Review and merge
6. Delete branch
```

**Git Flow:**
```
main:     A---B---C---D---E---F---G
                 \             \
develop:          H---I---J---K---L
                  |\
feature:          M---N---O---P---Q
```

---

### 15.4 Useful Tips

```bash
# Auto-correct commands
git config --global help.autocorrect 1

# Colored output
git config --global color.ui auto

# Default editor
git config --global core.editor vim

# Line endings
git config --global core.autocrlf input

# Pull strategy
git config --global pull.rebase false  # Merge
git config --global pull.rebase true   # Rebase

# Rebase when pulling
git config --global branch.autoSetupRebase always

# Set default branch
git config --global init.defaultBranch main

# Ignore file mode changes
git config --global core.fileMode false
```

---

### 15.5 ⚠️ Important Warnings

| Warning | Prevention |
|---------|------------|
| Force push to shared branch | Never `git push -f` on main/dev |
| Delete unmerged branch | Use `git branch -d` (safe) |
| Commit sensitive data | Use `.gitignore`, `git rm --cached` |
| Lose commits | Don't `git reset --hard` unsaved work |
| Merge conflicts | Pull frequently, rebase often |

---

## 16. Quick Cheatsheet

### Setup & Config
| Command | Description |
|---------|-------------|
| `git config --global user.name "Name"` | Set username |
| `git config --global user.email "email"` | Set email |
| `git config --global init.defaultBranch main` | Set default branch |
| `git config --list` | Show all config |

### Getting Started
| Command | Description |
|---------|-------------|
| `git init` | Initialize repository |
| `git clone url` | Clone remote repository |
| `git clone -b branch url` | Clone specific branch |

### Basic Workflow
| Command | Description |
|---------|-------------|
| `git status` | Show working tree status |
| `git add .` | Stage all changes |
| `git add file` | Stage specific file |
| `git commit -m "msg"` | Commit staged changes |
| `git commit -am "msg"` | Stage and commit all |

### Branching
| Command | Description |
|---------|-------------|
| `git branch` | List branches |
| `git branch name` | Create branch |
| `git checkout -b name` | Create and switch |
| `git switch name` | Switch branch |
| `git checkout name` | Switch branch |
| `git branch -d name` | Delete branch |
| `git branch -D name` | Force delete |

### Merging
| Command | Description |
|---------|-------------|
| `git merge branch` | Merge into current |
| `git merge --no-ff branch` | No fast-forward merge |
| `git merge --abort` | Abort merge |

### Remote Operations
| Command | Description |
|---------|-------------|
| `git remote -v` | List remotes |
| `git remote add name url` | Add remote |
| `git push origin branch` | Push to remote |
| `git push -u origin branch` | Push and set upstream |
| `git pull` | Fetch and merge |
| `git fetch` | Download objects |
| `git clone url` | Clone repository |

### Inspection
| Command | Description |
|---------|-------------|
| `git log` | Show commit history |
| `git log --oneline` | Compact history |
| `git log --graph` | Visual graph |
| `git diff` | Show changes |
| `git show commit` | Show commit details |
| `git blame file` | Show file authors |

### Undo
| Command | Description |
|---------|-------------|
| `git restore file` | Restore file |
| `git reset --soft HEAD~1` | Undo commit, keep changes |
| `git reset --hard HEAD~1` | Undo commit, discard changes |
| `git revert commit` | Create undo commit |
| `git commit --amend` | Modify last commit |
| `git clean -fd` | Remove untracked |

### Stashing
| Command | Description |
|---------|-------------|
| `git stash` | Save changes |
| `git stash pop` | Apply and remove |
| `git stash apply` | Apply without removing |
| `git stash list` | List stashes |
| `git stash drop` | Remove stash |

### Advanced
| Command | Description |
|---------|-------------|
| `git rebase -i HEAD~N` | Interactive rebase |
| `git bisect start` | Find buggy commit |
| `git tag -a v1.0 -m "msg"` | Create tag |
| `git cherry-pick commit` | Copy commit |

---

## 17. Related

- [[Git-GitHub-Workflow]] - Advanced workflows
- [[Ansible-Concepts]] - Ansible Vault for secrets
- [[Bash-Scripting-Concepts]] - Automation scripts

---

## 18. External Resources

- [Git Official Documentation](https://git-scm.com/doc)
- [GitHub Learning Lab](https://lab.github.com/)
- [Atlassian Git Tutorial](https://www.atlassian.com/git/tutorials)
- [Git Interactive Cheatsheet](https://ndpsoftware.com/git-cheatsheet.html)
