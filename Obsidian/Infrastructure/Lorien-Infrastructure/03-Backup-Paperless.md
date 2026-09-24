# Backup Paperless

**Redesigned 2026-09-25** after Paperless itself moved to lorien (see [[05-Paperless]]) — a shire→lorien backup stopped making sense once both roles collapsed onto one host. New flow: lorien → VPS, encrypted with GPG so the VPS (the most internet-exposed host) never holds a readable copy. The old shire-side flow is kept further down for history.

## Current flow (lorien → VPS, GPG-encrypted)

```
lorien: podman exec paperless_webserver_1 document_exporter ...
     → gpg --encrypt --recipient <paperless-backup key> (public key only, on lorien)
     → rsync (restricted, write-only key) → vps:/backup/paperless/export_YYYY-MM-DD.zip.gpg
```

**Why GPG, and why asymmetric (public/private key pair) rather than a shared passphrase**: the backup destination is the VPS, the one host with real internet exposure (open 80/443/2229). Lorien only ever holds the *public* key — it can encrypt but never decrypt. The *private* key lives only on gondor (outside both lorien and the VPS), generated with:

```bash
gpg --full-generate-key   # RSA 4096, no expiry, identity "paperless-backup <email>"
gpg --export --armor paperless-backup > paperless-backup-pub.asc
```

Fingerprint (referenced as `GPG_RECIPIENT` in the script): `0F2FFFA56C891911E0D3FDF59FBD8DD110D80F98`. The `.asc` file itself isn't checked into the repo — its UID embeds a personal email address in cleartext (recoverable via `gpg --list-packets` even though it doesn't grep as plaintext), so it's kept out of version control; re-import from gondor's keyring or the user's own copy when re-provisioning lorien.

Even if lorien *and* the VPS were both compromised, the backups on the VPS stay unreadable without that private key. The tradeoff: losing the private key means losing the ability to decrypt every backup ever made — keep an offline copy (e.g. a second export kept off-network), not just the one on gondor. A hardware token (YubiKey, OpenPGP applet) is a stronger long-term home for the private key than a plain file — not set up yet as of 2026-09-25, revisit when a YubiKey is available.

### Scripts

| Script | Runs on | Purpose |
|---|---|---|
| `scripts/bash/paperless_backup.sh` | lorien, cron `0 1 * * 1` | Export, encrypt, push to VPS, prune local copies |
| `scripts/bash/paperless_backup_prune_vps.sh` | VPS, cron `0 2 * * 1` | Prune old backups on the VPS side |

Split into two scripts/two cron jobs because the SSH key lorien uses to reach the VPS is deliberately restricted (`command="/usr/local/bin/rrsync -wo /backup/paperless"` in the VPS's `authorized_keys`, `/usr/local/bin/rrsync` installed from rsync's own `support/rrsync`) — write-only rsync into that one directory, no shell access. That means lorien physically cannot trigger a remote cleanup command, so retention on the VPS side has to be a separate, locally-run cron job there instead. This is intentional least-privilege, not a workaround to remove later.

### Retention

Same policy as the old flow: 90-day retention with a 14-day freshness safety check (won't delete anything if the newest backup is itself stale — protects against silently losing all history if backups stop running).

### Manual run / testing

```bash
ssh lorien
/usr/local/bin/paperless_backup.sh
```

Confirm it actually encrypted (don't just trust the exit code):

```bash
ssh vps
file /backup/paperless/export_YYYY-MM-DD.zip.gpg   # should say "PGP RSA encrypted session key..."
```

Decrypting (on gondor, wherever the private key lives):

```bash
scp vps:/backup/paperless/export_YYYY-MM-DD.zip.gpg .
gpg --decrypt export_YYYY-MM-DD.zip.gpg > export_YYYY-MM-DD.zip
```

## Historical flow (shire → lorien, pre-2026-09-24)

Shire used to push Paperless document exports to lorien via rsync.

### Script

**Location**: pre-migration version of `scripts/bash/paperless_backup.sh` (that file now contains the current lorien→VPS version above; this history is what it used to do, runs on **shire**)

### How It Works

1. Generate export in Paperless container (document_exporter)
2. Copy export from container to host
3. rsync to lorien (init_user@10.66.66.10:/backup/paperless/)
4. Prune old backups locally (shire)
5. Prune old backups on lorien (remote cleanup)

### Safety Features

The script includes a freshness check before deleting old backups:

- **Retention**: 90 days
- **Freshness threshold**: 14 days
- **Safety rule**: Only deletes backups if the newest one is less than 14 days old

This prevents data loss if backups stop running (e.g., cron failure, network issue).

### Output

Backup file: `export_YYYY-MM-DD.zip`

Example size: ~100-198MB

### Cron

Runs weekly on shire (day/time depends on shire's crontab).

### Retention

- **Keep**: 90 days
- **Safety**: won't delete if newest backup is > 14 days old
- **Applies to**: both local (shire) and remote (lorien)

### Logs

Script outputs to stdout. Capture with cron:

```bash
/path/to/paperless_backup.sh >> /var/log/paperless-backup.log 2>&1
```

### Manual Run

```bash
# On shire
/path/to/paperless_backup.sh
```

### Directory Structure

```
/backup/paperless/
├── export_2026-04-27.zip
├── export_2026-05-04.zip
├── export_2026-05-11.zip
├── export_2026-05-18.zip
├── export_2026-05-25.zip
├── export_2026-06-01.zip
├── export_2026-06-08.zip
├── export_2026-06-15.zip
├── export_2026-06-17.zip
├── export_2026-06-22.zip
├── export_2026-06-29.zip
├── export_2026-07-06.zip
├── export_2026-07-13.zip
└── export_2026-07-20.zip
```

### Technical Details

#### Docker Commands

The script uses these Docker commands on shire:

```bash
# Generate export
docker exec paperless-webserver-1 document_exporter \
    /usr/src/paperless/export -z -zn "export_$DATE"

# Copy to host
docker cp paperless-webserver-1:/usr/src/paperless/export/export_$DATE.zip \
    "$EXPORT_DIR/export_$DATE.zip"
```

#### Remote Pruning

The script SSHes into lorien and runs a cleanup function remotely:

```bash
ssh init_user@10.66.66.10 bash -s -- "$LORIEN_DIR" "lorien" "$RETENTION_DAYS" "$FRESHNESS_THRESHOLD" <<'PRUNE'
    prune_old "$@"
PRUNE
```

## See Also

- [[01-Overview]] - System overview
- [[02-Backup-HomeAssistant]] - HA backup (pull model vs push model)
