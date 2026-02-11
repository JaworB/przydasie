# Klucze SSH

Generowanie i konfiguracja kluczy SSH dla GitHub.

## Wygeneruj klucz SSH

```bash
# Wygeneruj parę kluczy
ssh-keygen -t ed25519 -C "your_email@example.com"

# Lub RSA jeśli stary system
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
```

## Dodaj klucz do SSH Agent

```bash
# Uruchom agenta
eval "$(ssh-agent -s)"

# Dodaj klucz prywatny
ssh-add ~/.ssh/id_ed25519
```

## Dodaj klucz publiczny do GitHub

1. Wyświetl klucz publiczny:
```bash
cat ~/.ssh/id_ed25519.pub
```

2. Skopiuj wyjście

3. Na GitHub:
   - Idź do Settings → SSH and GPG keys
   - Kliknij "New SSH key"
   - Wklej klucz
   - Dodaj tytuł

## Przetestuj połączenie

```bash
ssh -T git@github.com
```

Odpowiedź powinna brzmieć:
```
Hi username! You've successfully authenticated, but GitHub does not provide shell access.
```

## Używaj SSH z repozytoriami

```bash
# Klonuj przez SSH
git clone git@github.com:username/repo.git

# Zmień zdalne na SSH
git remote set-url origin git@github.com:username/repo.git
```

## Powiązane

- Zobacz [[01-Initial-Setup_PL]] konfiguracja początkowa
- Zobacz [[03-Securing-Data_PL]] zabezpieczanie danych
- Zobacz [[../12-Remotes_PL]] operacje zdalne
