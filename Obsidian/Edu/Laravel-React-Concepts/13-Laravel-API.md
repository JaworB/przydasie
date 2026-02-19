# 13 - Laravel as REST API

Creating RESTful APIs with Laravel.

## Creating API Routes

```php
// routes/api.php

Route::get('/posts', [PostController::class, 'index']);
Route::post('/posts', [PostController::class, 'store']);
Route::get('/posts/{post}', [PostController::class, 'show']);
Route::put('/posts/{post}', [PostController::class, 'update']);
Route::delete('/posts/{post}', [PostController::class, 'destroy']);
```

## API Resource

```bash
php artisan make:resource PostResource
```

```php
<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class PostResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'title' => $this->title,
            'content' => $this->content,
            'user' => $this->whenLoaded('user'),
            'created_at' => $this->created_at->toIso8601String(),
        ];
    }
}
```

## API Controller

```php
<?php

namespace App\Http\Controllers;

use App\Http\Resources\PostResource;
use App\Models\Post;

class PostController extends Controller
{
    public function index()
    {
        $posts = Post::with('user')->latest()->get();
        return PostResource::collection($posts);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'content' => 'required|string',
        ]);

        $post = auth()->user()->posts()->create($validated);
        return new PostResource($post);
    }

    public function show(Post $post)
    {
        return new PostResource($post->load('user'));
    }
}
```

## CORS Configuration

```php
// app/Http/Middleware/HandleCors.php
// Already included in Laravel 10+
```

## API Authentication (Sanctum)

```bash
composer require laravel/sanctum
php artisan vendor:publish --provider="Laravel\Sanctum\SanctumServiceProvider"
php artisan migrate
```

```php
// routes/api.php
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', function (Request $request) {
        return $request->user();
    });
});
```

## Next Steps

- [[14-React-Fetch]] - Fetch/Axios with React
