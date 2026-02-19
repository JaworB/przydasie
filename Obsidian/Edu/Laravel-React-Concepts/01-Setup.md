# 01 - Setup

Environment configuration for learning Laravel + React.

## Docker (Laravel Sail)

Laravel Sail is the official Docker solution for Laravel.

### Requirements
- Docker Desktop installed
- Node.js 18+ (for React)

### Installation

```bash
# Utwórz nowy projekt Laravel z Sail
curl -s "https://laravel.build/my-app" | bash

# Lub z composer
composer create-project laravel/laravel my-app
cd my-app
composer require laravel/sail --dev
php artisan sail:install
```

### Starting

```bash
./vendor/bin/sail up -d
./vendor/bin/sail artisan migrate
./vendor/bin/sail npm install
```

### Aliases (optional)

```bash
# Dodaj do ~/.bashrc lub ~/.zshrc
alias sail="./vendor/bin/sail"
```

## Node.js (for React)

```bash
# Sprawdź wersję
node --version
npm --version

# Lub zainstaluj przez nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install 20
nvm use 20
```

## React w Laravel

Laravel Breeze lub Vite dla React:

```bash
# Breeze (proste)
composer require laravel/breeze --dev
php artisan breeze:install react

# Vite (bez Breeze)
npm install
npm run dev
```

## Check Installation

```bash
# Laravel działa
./vendor/bin/sail artisan --version

# React działa
npm run dev
```

## Next Steps

- [[02-Laravel-Routing]] - Routing w Laravel
