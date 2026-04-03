# bogusz-theme

Custom Plymouth theme z logo Omarchy.

## Wymagania

- Plymouth zainstalowany i skonfigurowany
- Uprawnienia sudo

## Instalacja

```bash
cd plymouth/bogusz-theme
./install.sh
```

Lub ręcznie:

```bash
sudo cp -r bogusz-theme/ /usr/share/plymouth/themes/
sudo plymouth-set-default-theme bogusz-theme
sudo plymouth-set-default-theme --rebuild-initrd
```

## Struktura

| Plik | Opis |
|------|------|
| `bogusz-theme.plymouth` | Konfiguracja theme |
| `omarchy.script` | Skrypt renderujący Plymouth |
| `logo.png` | Logo (400×717px) |
| `bullet.png` | Ikona punktu hasła |
| `entry.png` | Pole hasła |
| `lock.png` | Ikona lock |
| `progress_bar.png` | Pasek postępu |
| `progress_box.png` | Tło paska postępu |

## Źródło logo

Logo pochodzi z `omarchyconf/default/plymouth/logo.png`, przeskalowane do rozmiaru 400×717px (proporcjonalnie do oryginału 1227×2201).