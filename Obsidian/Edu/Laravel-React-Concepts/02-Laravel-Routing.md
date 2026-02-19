# 02 - Laravel Routing

Routing in Laravel - defining URLs and handling requests.

## Basic Routing

### Simple route

```php
// routes/web.php
Route::get('/hello', function () {
    return 'Hello World';
});
```

### Route with view

```php
Route::view('/welcome', 'welcome');
```

### Route with parameter

```php
Route::get('/user/{id}', function ($id) {
    return 'User ' . $id;
});
```

### Optional parameter

```php
Route::get('/user/{name?}', function ($name = 'Guest') {
    return $name;
});
```

## HTTP Methods

```php
Route::get('/page', fn() => view('page'));
Route::post('/submit', fn() => 'Submitted');
Route::put('/update', fn() => 'Updated');
Route::delete('/delete', fn() => 'Deleted');
```

### HTTP method combinations

```php
Route::match(['get', 'post'], '/form', fn() => 'Form');
Route::any('/any', fn() => 'Any method');
```

## Named Routes

```php
Route::get('/profile', fn() => 'Profile')->name('profile');

// URL generation
$url = route('profile');
```

## Route Groups

```php
Route::prefix('admin')->group(function () {
    Route::get('/dashboard', fn() => 'Admin Dashboard');
    Route::get('/users', fn() => 'Users');
});
```

## Middleware

```php
Route::middleware(['auth'])->group(function () {
    Route::get('/dashboard', fn() => 'Dashboard');
});
```

## Zasoby (Resource Routes)

```php
Route::resource('posts', PostController::class);
```

Generuje:
- `GET /posts` - index
- `GET /posts/create` - create
- `POST /posts` - store
- `GET /posts/{post}` - show
- `GET /posts/{post}/edit` - edit
- `PUT /posts/{post}` - update
- `DELETE /posts/{post}` - destroy

## Następne kroki

- [[03-Laravel-Controllers]] - Kontrolery
