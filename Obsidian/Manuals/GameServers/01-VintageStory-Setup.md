# Vintage Story Dedicated Server

Runs on **lorien** via Podman Compose. Compose source of truth: `docker/gameserver/docker-compose.yml` in this repo, deployed to `/home/gameservers/docker-compose.yaml` on lorien.

## Image

`ghcr.io/darkmatterproductions/vintagestory:latest` (switched from `ralnoc/vintagestory` on 2026-07-28 — that Docker Hub image was stale, stuck on game version 1.22.2 for 2+ months despite the `latest` tag). The image bakes the game version in at build time; there is **no runtime env var** (e.g. `GAME_VERSION`) to select a version — check `in.dmpsys.vs.version` label on the pulled image to know what you'll get:

```bash
podman inspect ghcr.io/darkmatterproductions/vintagestory:latest --format '{{index .Config.Labels "in.dmpsys.vs.version"}}'
```

## Rootless: manage as the `gameservers` user, not root

The containers run **rootless** under the `gameservers` user's own Podman namespace (separate container store from root's). Manage them as that user, not root:

```bash
ssh lorien
su - gameservers
podman ps -a
cd ~ && podman compose up -d
```

Both containers have `restart: always`, and `podman-restart.service` is enabled for `gameservers` (`systemctl --user enable --now podman-restart.service`, works headless thanks to `loginctl enable-linger gameservers`, already set) — they come back automatically after a host reboot.

**History (resolved 2026-07-28):** for a while the live containers had drifted into running under **root's** rootful Podman instead — someone had run `podman compose up -d` as root directly at some point, silently diverging from the `gameservers` rootless setup the deployment files implied. Managing via `su - gameservers -c 'podman ...'` during that period operated on an entirely different, empty container store and silently created phantom containers instead of touching the real (root-owned) ones. Migrated back to rootless — see "Migrating rootful → rootless" below if this ever recurs.

There was also a stale leftover Quadlet at `~/.config/containers/systemd/VintageStory.container` (now renamed to `.stale-disabled`) pointing at a completely different, abandoned image (`docker.io/sknnr/vintage-story-server`) from an earlier, superseded setup attempt. It was inactive but easy to mistake for the "intended" management path — it wasn't; the compose file is the source of truth.

## Updating the server

```bash
ssh lorien
su - gameservers
podman pull ghcr.io/darkmatterproductions/vintagestory:latest
podman stop VintageStory && podman rm VintageStory
cd ~ && podman compose up -d
podman logs VintageStory --tail 20   # confirm "Dedicated Server now running on Port 42420"
```

Back up `Saves/` before a major-version bump:

```bash
tar -czf /home/gameservers/vintage-story-data/manual-backups/pre-upgrade-$(date +%Y%m%d-%H%M%S).tar.gz \
  -C /home/gameservers/vintage-story-data Saves
```

## Mods

Dropped as `.zip` files into `/home/gameservers/vintage-story-data/Mods/` on lorien (bind-mounted from `./vintage-story-data`). Owned by the rootless-namespace-mapped host uid/gid for the in-container `vintagestory` user (`1100` in-container → **`590923`** on host — see "Migrating rootful → rootless" below for how that mapping is derived; it changed from a plain `1100:1100` after the 2026-07-28 rootless migration). Downloading as root and then `chown 590923:590923 <file>` is the simplest way to get new mods in, since `gameservers` itself can't write directly into a directory now owned by the mapped uid. Restart the container to load new/updated mods:

```bash
podman restart VintageStory
podman logs VintageStory 2>&1 | grep -E 'Found [0-9]+ mods|Could not resolve'
```

Mods are versioned per game version on [mods.vintagestory.at](https://mods.vintagestory.at) — always check the mod's file list for a version tagged to the running game version before downloading. Not every mod publishes a build for every point release; the latest available build is often forward-compatible even if tagged for an older point release, but check community comments when in doubt.

Known unavailable for 1.22.x (as of 2026-07-29, checked directly on the mod DB): `XLib` and `XSkills` (official, mod IDs 244/247) are both dead upstream, stuck on game 1.21.0 — a community fork chain (`xlibfork`, `xskillsfork` by El_Neuman, `xskillsgilded`) is officially tagged for 1.22.5 and installed instead (see below). `wildfarmingrevival` has no 1.22.x build at all yet (author states it's in progress) — nothing to install.

Currently installed (as of 2026-07-29, game version 1.22.5): BetterRuins, BetterTraders, Buried+Hostility, CarryOn(+Lib), CaveSymphony, Conquest Blocklayer Overhaul, ForestSymphony, Knapster, PlayerLists, ProspectTogether, StepUpAdvanced, animalcages, bedspawnv2, configlib, hangingoillamps, primitivesurvival, realsmoke, rustboundmagic, statushudcont, vsimgui, vsroofing, zoombuttonreborn, buzzwords 1.8.2, chiseltools 1.17.4, BloodTrail 1.2.5, butchering 1.13.6, **ExpandedFoods** 2.0.0-dev.12 (WIP branch — no stable build exists for 1.22.x), **ACulinaryArtillery** 2.0.0-dev.21 (WIP dependency required by ExpandedFoods), **FromGoldenCombs** 2.0.8 (tagged 1.22.0-1.22.3, closest available to 1.22.5), **XLib Fork** 1.0.31, **xSkills Fork** 1.0.90, **xSkills Gilded** 1.3.45 (community fork chain, all three officially tagged 1.22.0-pre.1–1.22.5 — the fork bundles its own mod-ID spoofing so no extra "compatibility fix" mod was needed).

Known pre-existing (not caused by mod updates) benign log noise: `realsmoke` throws a `Cannot find CoolNow function on BlockEntityFirepit` exception on certain firepit block-entity init — server keeps running fine.

**Mod breakage after the 1.22.5 bump:** `buzzwords` 1.8.0 crashed every tick with `Field not found: Entity.ServerPos` (obsolete reflection target), flooding the log and overloading the tick loop. Fixed by updating to `buzzwords` 1.8.2, which replaced that reference — confirmed no recurrence after restart. **Lesson: after a game-version bump, watch `podman logs VintageStory --tail 50` for a minute or two after restart, not just the boot log — API-breakage in mods that use reflection can show up only once entities start ticking.**

## Regenerating the world

Not required after a version bump — Vintage Story auto-migrates existing saves via its block/item remapper (see server log: `Remapper: Updating a saved world from earlier game version`). Only do this deliberately, e.g. to start fresh with a new mod's worldgen. It **replaces the live save** — archive first, don't delete:

```bash
ssh lorien
su - gameservers
podman stop VintageStory
cd /home/gameservers/vintage-story-data
mkdir -p archived-worlds
mv Saves "archived-worlds/Saves-$(date +%Y%m%d-%H%M%S)"
mkdir -p Saves && chown 590923:590923 Saves   # rootless-mapped uid, see below — not a plain 1100
podman start VintageStory
podman logs VintageStory 2>&1 | grep 'Create new save game data'   # confirms fresh world
```

Done twice: 2026-07-28 (post-1.22.5-upgrade, at the user's request) and 2026-07-29 (user didn't like the generated terrain, asked for another). Old worlds archived under `archived-worlds/Saves-*/` on lorien.

**First-login client crash on a brand-new world (2026-07-29):** right after the first regeneration, the connecting client crashed with a `NullReferenceException` in `Entity.Initialize` → `SyncedTreeAttribute.FromBytes` while deserializing the player entity's first sync packet — the server itself stayed up fine (`Player X got removed. Reason: The Players client crashed`). This matches a known, once-fixed (in vanilla 1.20.12) race condition in the order entity data loads client-side on a very first spawn into a new world ([VintageStory-Issues#6025](https://github.com/anegostudios/VintageStory-Issues/issues/6025)); it likely resurfaced because the newly installed entity-attribute-heavy mods (xSkills/xLib/rustboundmagic/aculinaryartillery) register many more watchers on the player entity than vanilla does, making the same timing window more likely to be hit. **Fix: just reconnect** — the entity is no longer "new" server-side on the second attempt, and it did not recur. Only worth digging further (and suspecting a specific mod) if it happens repeatedly rather than once on first spawn.

## Migrating rootful → rootless

If the containers ever end up running under root again, moving them back to the `gameservers` user's rootless Podman isn't just "stop as root, start as gameservers" — bind-mounted data ownership has to be remapped for the user namespace, or the container can't read/write its own files.

`gameservers` has subuid/subgid range `589824:65536` (`/etc/subuid`, `/etc/subgid`). Rootless Podman maps container-internal uid `N` (for `N >= 1`) to host uid `589823 + N`. Get the exact mapping (don't assume — depends on `/etc/subuid`):

```bash
su - gameservers -c 'podman unshare cat /proc/self/uid_map'
```

The image's in-container users: `vintagestory` = uid 1100, `steam` (stationeers) = uid 10000. With the `589824:65536` range that's host uid `590923` and `599823` respectively.

```bash
ssh lorien   # as root
podman stop VintageStory stationeers && podman rm VintageStory stationeers

# Remap ownership to the rootless-namespace-mapped host UIDs (as root — some files
# get created by the container's root-level init step and aren't chownable via
# `podman unshare` as a non-root user):
chown -R 590923:590923 /home/gameservers/vintage-story-data /home/gameservers/vintage-story-server
chown -R 599823:599823 /home/gameservers/stationeers-data /home/gameservers/stationeers.env

su - gameservers -c 'cd ~ && podman compose up -d'
su - gameservers -c 'podman update --restart=always VintageStory'
su - gameservers -c 'podman update --restart=always stationeers'
su - gameservers -c 'XDG_RUNTIME_DIR=/run/user/1001 systemctl --user enable --now podman-restart.service'
```

Verify: `podman ps -a` as root should show nothing; `su - gameservers -c 'podman ps -a'` should show both containers `Up`, and `podman logs VintageStory` should have no `Permission denied`/`Operation not permitted` lines.
