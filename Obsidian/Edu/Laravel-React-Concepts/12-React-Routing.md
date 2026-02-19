# 12 - React Router

Client-side routing for React applications.

## Installation

```bash
npm install react-router-dom
```

## Basic Setup

```jsx
// main.jsx
import { BrowserRouter } from 'react-router-dom';
import App from './App';

root.render(
  <BrowserRouter>
    <App />
  </BrowserRouter>
);
```

## Routes Configuration

```jsx
// App.jsx
import { Routes, Route, Link } from 'react-router-dom';
import Home from './pages/Home';
import About from './pages/About';
import Post from './pages/Post';

function App() {
  return (
    <div>
      <nav>
        <Link to="/">Home</Link>
        <Link to="/about">About</Link>
      </nav>

      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/about" element={<About />} />
        <Route path="/post/:id" element={<Post />} />
      </Routes>
    </div>
  );
}
```

## Dynamic Routes

```jsx
// Route with parameter
<Route path="/post/:id" element={<Post />} />

// In component
import { useParams } from 'react-router-dom';

function Post() {
  const { id } = useParams();
  return <h1>Post #{id}</h1>;
}
```

## Navigation

```jsx
import { useNavigate } from 'react-router-dom';

function LoginButton() {
  const navigate = useNavigate();
  
  const handleLogin = () => {
    // After login
    navigate('/dashboard');
  };
  
  return <button onClick={handleLogin}>Login</button>;
}
```

## Nested Routes

```jsx
<Route path="/dashboard" element={<Dashboard />}>
  <Route path="settings" element={<Settings />} />
  <Route path="profile" element={<Profile />} />
</Route>
```

```jsx
// Dashboard.jsx
import { Outlet } from 'react-router-dom';

function Dashboard() {
  return (
    <div>
      <h1>Dashboard</h1>
      <Outlet />
    </div>
  );
}
```

## 404 Page

```jsx
<Route path="*" element={<NotFound />} />
```

## Next Steps

- [[13-Laravel-API]] - Laravel as REST API
