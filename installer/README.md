# installer

Własny bootstrap Arch + Hyprland/uwsm dla gondor/rivendell, w duchu Omarchy,
ale ograniczony do tego co faktycznie używane, i z automatycznym
dołączeniem do domowej infry (dotfiles sync, syslog → lorien, WireGuard).

Zastępuje ręczny proces opisany w `AI/jawor-conf/SKILL.md`.

## Krok 0 — świeża instalacja Arch

Zanim uruchomisz cokolwiek z tego katalogu, maszyna musi mieć świeżo
zainstalowany Arch Linux z działającym SSH i siecią. Pełna instrukcja
(archinstall, ustawienia, zaufanie SSH gondor→nowa maszyna):
[docs/00-fresh-install.md](docs/00-fresh-install.md).

## Krok 1 — uruchomienie instalatora

Na świeżo zainstalowanym Arch (z `openssh` + `git`, i sshd uruchomionym):

```bash
curl -fsSL https://raw.githubusercontent.com/JaworB/przydasie/arch-installer/installer/boot.sh | bash
```

Instalator:
1. wykrywa/pyta o rolę (desktop/laptop),
2. instaluje pakiety bazowe (`modules/00-base.sh`),
3. stawia dotfiles + auto-sync co 30 min (`modules/10-dotfiles.sh`),
4. przygotowuje WireGuard i startowy firewall — **bez** łączenia z VPN
   (`modules/20-wireguard-prepare.sh`, `modules/30-firewall.sh`),
5. podpina syslog-ng → lorien (`modules/40-rsyslog.sh`),
6. hardware-specific: CoolerControl / DisplayLink (`modules/90-hardware-*.sh`).

Status na bieżąco na ekranie, pełny log debugowy w `/var/log/jawor-install.log`.

## Krok 1.5 — domyślne configi Omarchy + motyw, z gondor

Osobiste dotfiles (`~/.config/hypr/hyprland.conf`) zakładają istnienie
domyślnych configów Omarchy w `~/.local/share/omarchy/default/` i aktywnego
motywu w `~/.config/omarchy/current/theme` — bez tego Hyprland startuje z
błędem `source= globbing error: found no match` i pustymi defaultami.

Repo `omarchyconf` jest **prywatne** (osobisty fork), więc nowy host nie ma
do niego dostępu z GitHuba — dane są dostarczane peer-to-peer z gondor
(który ma lokalny klon), tym samym mechanizmem zaufania SSH co
`vps-join/join-host.sh`. Z gondor:

```bash
./gondor-provision/push-omarchy-defaults.sh <lan-ip-nowego-hosta>
```

Domyślnie instaluje motyw „Miasma". Uruchom po Kroku 1, przed pierwszym
logowaniem do sesji graficznej (albo `hyprctl reload`, jeśli sesja już
działa).

## Krok 2 — dołączenie do VPN, z VPS

WireGuard **nie** jest częścią `boot.sh`, bo VPS nie ma bezpośredniej
łączności z nową maszyną (prywatna sieć domowa). Zamiast tego, z sesji
mającej dostęp do VPS i gondor:

```bash
ssh vps
JAWOR_VPS_ENDPOINT=<publiczny-ip>:<port> \
  ./vps-join/join-host.sh <hostname> <lan-ip-nowego-hosta> <vpn-ip>
```

Wymaga wcześniejszego dorzucenia klucza publicznego `jawor@gondor` do
`authorized_keys` nowego hosta (ręcznie, zaraz po bazowej instalacji Arch).

Skrypt generuje klucze, dopisuje peera na VPS, dostarcza gotowy `wg0.conf`
przez `gondor → nowy host`, podnosi `wg-quick@wg0`, i dopiero wtedy zawęża
firewall nowego hosta do SSH-tylko-z-`10.66.66.0/24`.

## Sekrety

`local.env` (kopia `local.env.example`) jest w `.gitignore` — nic
wrażliwego (klucze WG, publiczny endpoint VPS) nie trafia do tego
publicznego repo. Klucze WireGuard generowane są w locie przez
`join-host.sh` i istnieją tylko w `/etc/wireguard/` na VPS i na kliencie.

## Poza zakresem (v1)

- Własny launcher/menu pod super+space — osobny projekt później.
- Migracje wersji instalatora — moduły mają być idempotentne, bez osobnego
  mechanizmu migracji na razie.
