# 15 - Final Project: Blog Application

Build a complete blog with Laravel API and React frontend.

## Project Overview

Create a simple blog where users can:
- View list of posts
- Read individual posts
- Create new posts (with authentication)
- Edit/delete own posts

## Architecture

```
Laravel (Backend)          React (Frontend)
├── /api/posts             ├── / (Home - post list)
├── /api/posts/{id}        ├── /post/:id (single post)
├── /api/auth/login        ├── /login (auth)
└── Sanctum auth           └── /admin (dashboard)
```

## Step 1: Laravel Backend

### Setup
```bash
composer create-project laravel/laravel blog-api
cd blog-api
composer require laravel/sanctum
php artisan vendor:publish --provider="Laravel\Sanctum\SanctumServiceProvider"
php artisan migrate
```

### Models
```bash
php artisan make:model Post -m
php artisan make:resource PostResource
php artisan make:controller Api/PostController
```

### Routes (routes/api.php)
```php
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', [AuthController::class, 'user']);
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::apiResource('/posts', PostController::class);
});
```

## Step 2: React Frontend

### Setup
```bash
npm create vite@latest blog-client -- --template react
cd blog-client
npm install axios react-router-dom
```

### Structure
```
src/
├── components/
│   ├── Navbar.jsx
│   ├── PostCard.jsx
│   └── ProtectedRoute.jsx
├── pages/
│   ├── Home.jsx
│   ├── Post.jsx
│   ├── Login.jsx
│   ├── Register.jsx
│   └── Admin.jsx
├── context/
│   └── AuthContext.jsx
├── api/
│   └── axios.js
└── App.jsx
```

## Step 3: Implementation

### 1. Auth Context (React)
```jsx
// context/AuthContext.jsx
import { createContext, useState, useEffect } from 'react';
import axios from '../api/axios';

export const AuthContext = createContext();

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null);

  useEffect(() => {
    axios.get('/user')
      .then(res => setUser(res.data))
      .catch(() => setUser(null));
  }, []);

  const login = async (email, password) => {
    const res = await axios.post('/login', { email, password });
    localStorage.setItem('token', res.data.token);
    setUser(res.data.user);
  };

  const logout = async () => {
    await axios.post('/logout');
    localStorage.removeItem('token');
    setUser(null);
  };

  return (
    <AuthContext.Provider value={{ user, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
}
```

### 2. Post List (Home)

```jsx
// pages/Home.jsx
import { useEffect, useState } from 'react';
import axios from '../api/axios';
import { Link } from 'react-router-dom';

export default function Home() {
  const [posts, setPosts] = useState([]);

  useEffect(() => {
    axios.get('/posts')
      .then(res => setPosts(res.data.data));
  }, []);

  return (
    <div>
      <h1>Blog Posts</h1>
      {posts.map(post => (
        <div key={post.id}>
          <h2><Link to={`/post/${post.id}`}>{post.title}</Link></h2>
          <p>{post.excerpt}</p>
        </div>
      ))}
    </div>
  );
}
```

### 3. Post Detail

```jsx
// pages/Post.jsx
import { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import axios from '../api/axios';

export default function Post() {
  const { id } = useParams();
  const [post, setPost] = useState(null);

  useEffect(() => {
    axios.get(`/posts/${id}`)
      .then(res => setPost(res.data.data));
  }, [id]);

  if (!post) return <div>Loading...</div>;

  return (
    <article>
      <h1>{post.title}</h1>
      <p>{post.content}</p>
      <small>By {post.user?.name}</small>
    </article>
  );
}
```

## Step 4: Testing

```bash
# Backend tests
php artisan test

# Frontend
npm run build
```

## Enhancements

- Add pagination
- Add categories/tags
- Add comments
- Add image upload
- Add search
- Write unit tests

## Summary

This project covers:
- Laravel REST API
- Laravel Sanctum authentication
- React routing
- React context for auth
- Axios for HTTP requests
- Protected routes
- CRUD operations

## Resources

- Laravel: https://laravel.com/docs
- React: https://react.dev
- Laravel Sanctum: https://laravel.com/docs/sanctum
