# Tags

Mark specific commits (releases).

## Lightweight Tag

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

## Annotated Tag

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

## Push Tags

```bash
# Push single tag
git push origin v1.0.0

# Push all tags
git push --tags

# Delete remote tag
git push origin --delete v1.0.0
```

## Related

- See [[12-Remotes]] for pushing tags to remote
- See [[16-Cheatsheet]] for quick reference
- See [[05-Basic-Workflow]] for commit workflow

## Next Steps

Proceed to [[14-Aliases]] to learn about Git aliases.
