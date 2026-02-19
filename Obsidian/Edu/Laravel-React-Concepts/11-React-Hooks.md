# 11 - React Hooks

Hooks let you use state and other React features in functional components.

## useState

```jsx
import { useState } from 'react';

function Counter() {
  const [count, setCount] = useState(0);
  return <button onClick={() => setCount(c => c+1)}>{count}</button>;
}
```

## useEffect

Run side effects after render:

```jsx
import { useEffect } from 'react';

function UserData({ userId }) {
  const [user, setUser] = useState(null);

  useEffect(() => {
    fetch(`/api/users/${userId}`)
      .then(res => res.json())
      .then(data => setUser(data));
  }, [userId]);  // Dependency array

  return <div>{user?.name}</div>;
}
```

### Effect Cleanup

```jsx
useEffect(() => {
  const subscription = api.subscribe(id);
  
  return () => {
    subscription.unsubscribe();
  };
}, [id]);
```

## useContext

Access context without nesting:

```jsx
import { useContext } from 'react';
import { ThemeContext } from './ThemeContext';

function Button() {
  const theme = useContext(ThemeContext);
  return <button className={theme}>Click</button>;
}
```

## useRef

Mutable ref that doesn't trigger re-render:

```jsx
import { useRef } from 'react';

function FocusInput() {
  const inputRef = useRef(null);

  return (
    <input ref={inputRef} />
    <button onClick={() => inputRef.current.focus()}>Focus</button>
  );
}
```

## useMemo / useCallback

Optimize performance:

```jsx
// Memoize computed value
const sortedItems = useMemo(() => {
  return items.sort((a, b) => a.name.localeCompare(b.name));
}, [items]);

// Memoize function
const handleClick = useCallback(() => {
  console.log(count);
}, [count]);
```

## Custom Hooks

```jsx
function useLocalStorage(key, initialValue) {
  const [value, setValue] = useState(() => {
    const stored = localStorage.getItem(key);
    return stored ? JSON.parse(stored) : initialValue;
  });

  useEffect(() => {
    localStorage.setItem(key, JSON.stringify(value));
  }, [key, value]);

  return [value, setValue];
}
```

## Rules of Hooks

1. Only call hooks at top level
2. Only call hooks from React functions
3. Dependency array should be accurate

## Next Steps

- [[12-React-Routing]] - React Router
