# Inspection

Commands to view and inspect your repository.

## git log

Show commit history.

```bash
# Basic history
git log

# Compact (one line per commit)
git log --oneline

# Show N commits
git log -5

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

## git diff

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
```

**Example:**
```bash
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

## git show

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
```

## git blame

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
```

**Example:**
```bash
$ git blame src/app.js
^a1b2c3d (Alice    2024-01-01)  import React from 'react';
^d4e5f6g (Bob      2024-01-05)  import { useState } from 'react';
^g7h8i9j (Carol   2024-01-10)  function App() {
h0i1j2k3 (Dave     2024-01-15)    const [count, setCount] = useState(0);
```

## git branch

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

# Delete branch
git branch -d feature/login    # Safe delete
git branch -D feature/login    # Force delete
```

## Related

- See [[05-Basic-Workflow]] for the workflow that creates this history
- See [[08-Branching]] for branch management
- See [[16-Cheatsheet]] for quick reference

## Next Steps

Proceed to [[07-Undo-Fix]] to learn how to fix mistakes in Git.
