# 09 - React Components & JSX

Components are the building blocks of React applications.

## Functional Components

```jsx
function Greeting() {
  return <h1>Hello!</h1>;
}

// Arrow function
const Greeting = () => <h1>Hello!</h1>;
```

## Component with Props

```jsx
function Greeting({ name }) {
  return <h1>Hello, {name}!</h1>;
}

// Usage
<Greeting name="John" />
```

## Multiple Props

```jsx
function UserCard({ name, age, email }) {
  return (
    <div className="card">
      <h2>{name}</h2>
      <p>Age: {age}</p>
      <p>Email: {email}</p>
    </div>
  );
}
```

## Children Props

```jsx
function Card({ children }) {
  return <div className="card">{children}</div>;
}

// Usage
<Card>
  <h2>Title</h2>
  <p>Content</p>
</Card>
```

## Conditional Rendering

```jsx
function Greeting({ isLoggedIn }) {
  if (isLoggedIn) {
    return <h1>Welcome back!</h1>;
  }
  return <h1>Please log in</h1>;
}

// Ternary
return (
  <div>
    {isLoggedIn ? <LogoutButton /> : <LoginButton />}
  </div>
);

// And/Or
return (
  <div>
    {isLoggedIn && <Dashboard />}
  </div>
);
```

## Lists and Keys

```jsx
function UserList({ users }) {
  return (
    <ul>
      {users.map(user => (
        <li key={user.id}>{user.name}</li>
      ))}
    </ul>
  );
}
```

## Next Steps

- [[10-React-Props-State]] - Props and State
