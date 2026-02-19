# 07 - Laravel Forms & Validation

Handling form requests and validation in Laravel.

## Creating Forms

```php
<form method="POST" action="{{ route('posts.store') }}">
    @csrf
    <input type="text" name="title">
    <textarea name="content"></textarea>
    <button type="submit">Submit</button>
</form>
```

## Form Methods

```php
@method('PUT')  // for update
@method('DELETE')  // for delete
```

## Request Validation

```php
public function store(Request $request)
{
    $validated = $request->validate([
        'title' => 'required|string|max:255',
        'content' => 'required|string',
        'email' => 'required|email',
        'age' => 'nullable|integer|min:18',
    ]);

    Post::create($validated);
}
```

## Validation Rules

| Rule | Description |
|------|-------------|
| required | Field must be present |
| email | Must be valid email |
| min/max | Length/number limits |
| string/numeric | Type check |
| unique:table | Check database |
| confirmed | Password confirmation |
| image | File must be image |

## Custom Error Messages

```php
$request->validate([
    'title' => 'required|string|max:255',
], [
    'title.required' => 'Please enter a title',
    'title.max' => 'Title is too long',
]);
```

## Form Request Class

```bash
php artisan make:request StorePostRequest
```

```php
<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StorePostRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        return [
            'title' => 'required|string|max:255',
            'content' => 'required|string',
        ];
    }
}
```

```php
public function store(StorePostRequest $request)
{
    $validated = $request->validated();
    // Create post
}
```

## Displaying Errors

```php
@error('title')
    <span class="error">{{ $message }}</span>
@enderror
```

## Old Input

```php
<input type="text" name="title" value="{{ old('title') }}">
```

## Next Steps

- [[08-React-Intro]] - Introduction to React
