# 08 - React Introduction

React is a JavaScript library for building user interfaces.

## Why React?

- Component-based
- Virtual DOM
- Declarative
- One-way data flow

## Creating a React App

```bash
# With Vite (recommended)
npm create vite@latest my-app -- --template react
cd my-app
npm install
npm run dev

# With Create React App
npx create-react-app my-app
cd my-app
npm start
```

## Project Structure

```
my-app/
├── src/
│   ├── App.jsx
│   ├── main.jsx
│   └── index.css
├── index.html
├── package.json
└── vite.config.js
```

## First Component

```jsx
// App.jsx
function App() {
  return <h1>Hello World</h1>;
}

export default App;
```

## Running React

```bash
npm run dev    # Vite
npm start      # CRA
```

## JSX Rules

- Return single root element
- Close all tags (`<br />`)
- Use camelCase for attributes
- Use className instead of class

## Next Steps

- [[09-React-Components]] - Components & JSX
