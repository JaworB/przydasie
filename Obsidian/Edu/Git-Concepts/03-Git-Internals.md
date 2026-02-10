# Git Internals

Understanding how Git stores data internally.

## SHA-1 Hash

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

## Git Objects

Git stores everything as one of four object types:

### Blob (Binary Large Object)

Stores file content (not metadata).

```
Hash = SHA1("file content")
```

### Tree

Stores directory structure and file references.

```
tree/
  ├── file1.txt (blob)
  ├── file2.txt (blob)
  └── subdir/   (tree)
```

### Commit

Links trees with metadata.

```
commit
  ├── tree: project snapshot
  ├── parent: previous commit
  ├── author: who wrote it
  ├── committer: who applied it
  └── message: description
```

### Tag

Marks a specific commit (used for releases).

```
tag: v1.0.0 -> commit ABC123
```

## Object Storage

```
.git/
├── objects/
│   ├── a1/
│   │   └── b2c3d4...  (compressed blob)
│   ├── b2/
│   │   └── c3d4e5...  (compressed commit)
│   ├── info/          # Object info
│   └── pack/          # Packed objects
├── refs/
│   ├── heads/         # Branch references
│   └── tags/          # Tag references
└── HEAD               # Current HEAD
```

## Related

- See [[02-Core-Concepts]] for concepts these objects represent
- See [[06-Inspection]] for viewing objects with git show
- See [[04-Getting-Started]] to start using Git

## Next Steps

Proceed to [[04-Getting-Started]] to learn how to initialize or clone a repository.
