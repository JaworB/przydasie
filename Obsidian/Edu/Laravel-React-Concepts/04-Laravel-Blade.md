# 04 - Laravel Blade Templates

Blade is Laravel's templating engine.

## Basic Syntax

```php
// Output variable
{{ $name }}

<!-- Escape HTML -->
{!! $html !!}

{{-- Comment --}}
```

## Control Structures

### If Statements

```php
@if ($count === 1)
    One item
@elseif ($count > 1)
    Many items
@else
    No items
@endif

@unless($authenticated)
    Not logged in
@endunless
```

### Loops

```php
@for ($i = 0; $i < 10; $i++)
    {{ $i }}
@endfor

@foreach ($users as $user)
    {{ $user->name }}
@endforeach

@forelse ($users as $user)
    {{ $user->name }}
@empty
    No users
@endforelse

@while (true)
    Infinite loop
@endwhile
```

## Including Views

```php
@include('partials.header')
@includeWhen($condition, 'partials.footer')
@includeIf('partials.missing')
```

## Layouts

### Main layout (resources/views/layouts/app.blade.php)

```php
<!DOCTYPE html>
<html>
<head>
    <title>@yield('title')</title>
</head>
<body>
    @yield('content')
</body>
</html>
```

### Child view

```php
@extends('layouts.app')

@section('title', 'Home Page')

@section('content')
    <h1>Welcome</h1>
@endsection
```

## Components

```php
@component('alert')
    @slot('title')
        Error
    @endslot
    Something went wrong!
@endcomponent
```

## Next Steps

- [[05-Laravel-Database]] - Database & Eloquent
