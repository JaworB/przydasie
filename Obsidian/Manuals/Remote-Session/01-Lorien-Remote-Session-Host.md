# Lorien as a remote session host

Lorien runs 24/7, so it hosts long-lived interactive sessions (e.g. Claude Code) that need to survive disconnects and be reachable from any device — gondor, rivendell, a phone, a browser — without losing state. The setup has three independent pieces: a dedicated service user, SSH key trust from that user out to other hosts, and a persistent terminal session with two ways in (raw tmux, or Claude Code's own Remote Control).

## Dedicated user: `remote_session`

A separate Linux user on lorien, not `jawor` or `root`, so these sessions run under their own identity/home directory instead of borrowing an admin account.

```bash
ssh lorien   # connects as root, per ~/.ssh/config
useradd -m -s /bin/bash remote_session
```

**No sudo.** The account was initially given passwordless (`NOPASSWD ALL`) sudo + `wheel` membership on the assumption a coding session might need to install packages locally. In practice, the actual work (editing files, running project code) happens over SSH out to another host — see below — not on lorien itself, and an audit of lorien's sudo log after a full session showed `remote_session` had never invoked its own sudo grant. On a shared 24/7 host (rsyslog server, container backups, game servers) with a session reachable remotely via a Remote Control link, passwordless root sitting unused is pure downside, so it was removed:

```bash
rm -f /etc/sudoers.d/remote_session
gpasswd -d remote_session wheel
```

If a concrete need for local privileged commands shows up later, prefer scoping the sudoers entry to that specific command over re-granting `ALL`.

## Outbound key trust

`remote_session` gets its own SSH keypair, generated on lorien:

```bash
install -d -m 700 -o remote_session -g remote_session /home/remote_session/.ssh
sudo -u remote_session ssh-keygen -t ed25519 -N "" -f /home/remote_session/.ssh/id_ed25519 -C "remote_session@lorien"
```

The public key is authorized on the accounts `remote_session` needs to reach *outbound* — i.e. added to their `~/.ssh/authorized_keys`, not the other way round:

- `jawor@gondor` — so a session on lorien can SSH out to edit files that live on gondor
- `root@lorien` (loopback) — so it can also reach lorien's own filesystem outside its own home, as root

This is one-directional by design: it lets `remote_session` reach *out* to trusted hosts. It does **not** set up inbound login — from another machine you still can't `ssh remote_session@lorien` directly (no key of yours is in *its* `authorized_keys`). Getting in currently always goes through the existing `root@lorien` trust:

```bash
ssh lorien "sudo -u remote_session <command>"
```

If direct inbound login as `remote_session` is ever wanted, that means adding gondor's/rivendell's own public keys to `/home/remote_session/.ssh/authorized_keys` — not done yet.

## Persistent session: tmux

A named tmux session keeps the process (and its state) alive across disconnects, and lets multiple hosts attach to the *same* session rather than each starting their own:

```bash
ssh lorien "sudo -u remote_session tmux new-session -d -s claude"
```

Attaching from any host on the VPN, once through the root proxy:

```bash
ssh lorien "sudo -u remote_session tmux attach -t claude"
```

Useful tmux commands for this setup:

```bash
ssh lorien "sudo -u remote_session tmux list-sessions"           # what's running
ssh lorien "sudo -u remote_session tmux new-session -d -s NAME"  # start another, named
ssh lorien "sudo -u remote_session tmux capture-pane -t claude -p"  # peek without attaching
```

## Remote Control: browser/phone access

Inside the tmux session, Claude Code's own `--remote-control` flag adds a second, independent way in — a `claude.ai/code/...` link that can be opened from Claude Desktop, a browser, or a phone, live-syncing with the terminal session:

```bash
claude --remote-control lorien
```

The `[name]` argument (`lorien` here) just labels the session for identification; it doesn't change access control. Output on start looks like:

```
/remote-control is active · Continue here, on your phone, or at
https://claude.ai/code/session_<id>
```

Both access paths — `tmux attach` and the Remote Control link — point at the same running process, so state stays consistent regardless of which one is used to look at or drive it.

## Summary of the moving parts

| Piece | Purpose |
|---|---|
| `remote_session` user (no sudo) | Isolated identity to run sessions under |
| `remote_session`'s own ed25519 key, authorized on `jawor@gondor` + `root@lorien` | Lets a session on lorien reach out to edit files on trusted hosts |
| tmux session (`sudo -u remote_session tmux ...`) | Keeps the process alive across disconnects; multiple hosts can attach to the same one |
| `claude --remote-control <name>` | Adds a browser/phone-reachable link to the same session, no SSH needed for that path |
