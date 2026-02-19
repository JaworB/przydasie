# 03 - Laravel Controllers

Controllers handle request logic in Laravel.

## Creating a Controller

```bash
php artisan make:controller UserController
```

## Basic Controller

```php
<?php

namespace App\Http\Controllers;

class UserController extends Controller
{
    public function index()
    {
        $users = User::all();
        return view('users.index', compact('users'));
    }

    public function show($id)
    {
        $user = User::findOrFail($id);
        return view('users.show', compact('user'));
    }

    public function store(Request $request)
    {
        // Validate and create
    }
}
```

## Route Binding

```php
// routes/web.php
Route::get('/user/{user}', [UserController::class, 'show']);
```

```php
public function show(User $user)
{
    return $user; // Automatic model binding
}
```

## Resource Controller

```bash
php artisan make:controller PostController --resource
```

```php
class PostController extends Controller
{
    public function index() {}
    public function create() {}
    public function store(Request $request) {}
    public function show(Post $post) {}
    public function edit(Post $post) {}
    public function update(Request $request, Post $post) {}
    public function destroy(Post $post) {}
}
```

## Dependency Injection

```php
public function show(Request $request, User $user)
{
    // Request and Model injected
}
```

## Next Steps

- [[04-Laravel-Blade]] - Blade Templates
