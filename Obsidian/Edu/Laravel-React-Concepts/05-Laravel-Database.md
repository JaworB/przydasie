# 05 - Laravel Database & Eloquent

Eloquent is Laravel's ORM (Object-Relational Mapper).

## Configuration

```php
// .env
DB_CONNECTION=sqlite
# or MySQL
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=myapp
DB_USERNAME=root
DB_PASSWORD=
```

## Creating Models

```bash
php artisan make:model Post
```

## Model Definition

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Post extends Model
{
    protected $fillable = ['title', 'content', 'user_id'];
    protected $hidden = ['password'];
    protected $casts = ['published' => 'boolean'];
}
```

## CRUD Operations

### Create

```php
$post = Post::create([
    'title' => 'My Post',
    'content' => 'Content here'
]);
```

### Read

```php
// All
$posts = Post::all();

// Find
$post = Post::find(1);

// Where
$posts = Post::where('published', true)->get();
```

### Update

```php
$post = Post::find(1);
$post->title = 'New Title';
$post->save();
```

### Delete

```php
$post = Post::find(1);
$post->delete();

// Or
Post::destroy(1);
```

## Relationships

### One to Many

```php
// User model
public function posts()
{
    return $this->hasMany(Post::class);
}

// Post model
public function user()
{
    return $this->belongsTo(User::class);
}
```

### Many to Many

```php
// User model
public function roles()
{
    return $this->belongsToMany(Role::class);
}
```

## Query Builder

```php
DB::table('posts')
    ->select('title', 'content')
    ->where('published', true)
    ->orderBy('created_at', 'desc')
    ->limit(10)
    ->get();
```

## Next Steps

- [[06-Laravel-Migrations]] - Migrations & Seeders
