# 10 - React Props & State

Props pass data to components. State manages dynamic data.

## Props (Read-only)

```jsx
// Parent component
function App() {
  return <Greeting name="John" age={25} />;
}

// Child component
function Greeting({ name, age }) {
  return <h1>Hello, {name}! You are {age}.</h1>;
}
```

## State with useState

```jsx
import { useState } from 'react';

function Counter() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <p>Count: {count}</p>
      <button onClick={() => setCount(count + 1)}>
        Increment
      </button>
    </div>
  );
}
```

## State with Multiple Values

```jsx
function Form() {
  const [name, setName] = useState('');
  const [email, setEmail] = useState('');

  return (
    <form>
      <input 
        value={name}
        onChange={e => setName(e.target.value)}
      />
      <input 
        value={email}
        onChange={e => setEmail(e.target.value)}
      />
    </form>
  );
}
```

## Object State

```jsx
function Profile() {
  const [user, setUser] = useState({
    name: '',
    email: ''
  });

  const updateName = (name) => {
    setUser({ ...user, name });
  };
}
```

## State vs Props

| Props | State |
|-------|-------|
| Passed from parent | Managed in component |
| Read-only | Can be updated |
| External data | Internal data |

## Updating State Based on Previous

```jsx
// Correct way
setCount(prevCount => prevCount + 1);

// Common mistake
setCount(count + 1);  // May use stale value
```

## Next Steps

- [[11-React-Hooks]] - React Hooks
