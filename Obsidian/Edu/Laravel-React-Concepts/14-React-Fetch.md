# 14 - Fetch & Axios in React

Making HTTP requests from React to Laravel API.

## Using Fetch

```jsx
// GET request
function PostList() {
  const [posts, setPosts] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch('/api/posts')
      .then(res => res.json())
      .then(data => {
        setPosts(data.data);
        setLoading(false);
      })
      .catch(err => console.error(err));
  }, []);

  if (loading) return <div>Loading...</div>;

  return (
    <ul>
      {posts.map(post => (
        <li key={post.id}>{post.title}</li>
      ))}
    </ul>
  );
}
```

## Using Axios (Recommended)

```bash
npm install axios
```

```jsx
import axios from 'axios';

function PostList() {
  const [posts, setPosts] = useState([]);

  useEffect(() => {
    axios.get('/api/posts')
      .then(res => setPosts(res.data.data))
      .catch(err => console.error(err));
  }, []);

  return <ul>{posts.map(p => <li key={p.id}>{p.title}</li>)}</ul>;
}
```

## POST Request

```jsx
function CreatePost() {
  const [title, setTitle] = useState('');
  const [content, setContent] = useState('');

  const handleSubmit = async (e) => {
    e.preventDefault();
    
    try {
      const res = await axios.post('/api/posts', {
        title,
        content
      });
      console.log(res.data);
    } catch (err) {
      console.error(err.response.data);
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <input value={title} onChange={e => setTitle(e.target.value)} />
      <textarea value={content} onChange={e => setContent(e.target.value)} />
      <button type="submit">Create</button>
    </form>
  );
}
```

## Authentication Headers

```jsx
// With Sanctum
const api = axios.create({
  baseURL: '/api',
  headers: {
    'Content-Type': 'application/json',
  }
});

// Add token to requests
api.interceptors.request.use(config => {
  const token = localStorage.getItem('token');
  if (token) {
    config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});
```

## Custom Hook for API

```jsx
function useApi(url) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    axios.get(url)
      .then(res => setData(res.data))
      .catch(err => setError(err))
      .finally(() => setLoading(false));
  }, [url]);

  return { data, loading, error };
}

// Usage
const { data, loading, error } = useApi('/api/posts');
```

## Error Handling

```jsx
try {
  const res = await axios.post('/api/posts', data);
} catch (err) {
  if (err.response) {
    // Server responded with error
    console.error(err.response.data.errors);
  } else if (err.request) {
    // Request made but no response
    console.error('No response');
  } else {
    console.error(err.message);
  }
}
```

## Next Steps

- [[15-Project]] - Final Project
