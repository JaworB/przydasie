# Async Basics

Handling asynchronous operations in JavaScript.

## Callbacks (Traditional)

```javascript
// Callback pattern
function fetchData(callback) {
  setTimeout(() => {
    callback({ data: "Some data" });
  }, 1000);
}

fetchData((result) => {
  console.log(result.data);
});
```

## Promises

```javascript
// Creating a promise
const fetchData = () => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      const success = true;
      if (success) {
        resolve({ data: "Some data" });
      } else {
        reject(new Error("Failed to fetch"));
      }
    }, 1000);
  });
};

// Consuming promises
fetchData()
  .then(result => {
    console.log(result.data);
    return result;
  })
  .catch(error => {
    console.error(error);
  });
```

## async/await (ES8+)

```javascript
async function getData() {
  try {
    const result = await fetchData();
    console.log(result.data);
    return result;
  } catch (error) {
    console.error(error);
  }
}

// Arrow function async
const getData = async () => {
  const result = await fetchData();
  return result;
};
```

## Parallel Operations

```javascript
const fetch1 = fetchData();
const fetch2 = fetchData();

// Promise.all - wait for all
Promise.all([fetch1, fetch2])
  .then(([result1, result2]) => {
    console.log(result1, result2);
  })
  .catch(error => console.error(error));

// Promise.race - first to complete
Promise.race([fetch1, fetch2])
  .then(result => console.log(result));
```

## Related

- [[07-Loops]] - Previous: Loops
- [[09-Modules]] - Next: Modules
- [[03-Functions]] - Functions

## Next Steps

Proceed to [[09-Modules]] to learn about JavaScript modules.
