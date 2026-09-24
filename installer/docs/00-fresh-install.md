# Krok 0 — świeża instalacja Arch Linux

Wykonywane ręcznie, lokalnie na maszynie (klawiatura+monitor podłączone
bezpośrednio) — to jedyny etap, który dzieje się przed jakąkolwiek
automatyzacją. Wymagane, zanim uruchomisz `installer/boot.sh`.

> **Uwaga**: to kasuje cały dysk docelowej maszyny. Upewnij się, że nic
> ważnego nie zostało na niej niezabackupowane (np. przy rivendell:
> `/etc/wireguard/wg0.conf` — patrz test end-to-end w głównym README).

## Wymagania wstępne

- pendrive z najnowszym obrazem [Arch Linux](https://archlinux.org/download/) (ISO)
- monitor + klawiatura podpięte bezpośrednio do maszyny
- dostęp do sieci — najprościej kabel LAN (DHCP działa od razu w live ISO),
  Wi-Fi też można przez `iwctl`

## 1. Boot z pendrive'a

W BIOS/UEFI wybierz boot z USB → uruchom "Arch Linux install medium".

## 2. Sieć w live ISO

Kabel LAN zwykle łapie DHCP automatycznie, sprawdź:

```bash
ping -c1 archlinux.org
```

Jeśli Wi-Fi:

```bash
iwctl
station wlan0 connect "<SSID>"
exit
```

## 3. Instalacja przez `archinstall`

Live ISO ma wbudowany interaktywny installer:

```bash
archinstall
```

Kluczowe ustawienia w kreatorze:

| Ustawienie | Wartość |
|---|---|
| Mirror region | Poland (albo zostaw auto-detect) |
| Disk configuration | wybierz docelowy dysk, wipe całości, ext4, automatyczne partycjonowanie |
| Bootloader | systemd-boot (domyślny, prostszy) |
| Hostname | `rivendell` / `gondor` — wg maszyny |
| Root password | ustaw i zapamiętaj |
| User account | `jawor`, z sudo (grupa `wheel`) |
| Profile | **Minimal** (bez Xorg/GNOME/KDE — Hyprland stawia `installer`) |
| Additional packages | `openssh git` |
| Network configuration | NetworkManager |
| Timezone | Europe/Warsaw |

Zatwierdź, poczekaj na koniec instalacji, `reboot` (i wyjmij pendrive).

## 4. Pierwsze uruchomienie

Zaloguj się (`jawor` lub `root`) i upewnij się, że sieć i SSH działają:

```bash
sudo systemctl enable --now sshd
sudo systemctl enable --now NetworkManager
ip a   # zanotuj adres IP w sieci LAN — potrzebny w kroku 6 i przy join-host.sh
```

## 5. Zaufanie SSH: gondor → nowa maszyna

Krok wymagany przez późniejszy `vps-join/join-host.sh` (VPS dostarcza config
WireGuard przez `gondor → nowy host`, bez hasła). Z gondor:

```bash
ssh-copy-id jawor@<lan-ip-nowej-maszyny>
```

## 6. Uruchom installer

Na nowej maszynie:

```bash
curl -fsSL https://raw.githubusercontent.com/JaworB/przydasie/arch-installer/installer/boot.sh | bash
```

Dalszy przebieg (moduły, potem dołączenie do VPN) opisany w głównym
[README](../README.md).
