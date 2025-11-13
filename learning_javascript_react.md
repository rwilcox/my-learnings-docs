---
path: /learnings/javascript_react
title: 'Learnings: Javascript: React'
---

# Table Of Contents

<!-- toc -->

<!-- tocstop -->

# Hooks

From LLM so IDK if this is good...

`useCallback` and `useEffect` are both hooks provided by React, but they serve different purposes and are used in different contexts. Here’s a breakdown of their differences, use cases, and how they work:

### `useCallback`

#### Purpose:
-  `useCallback` is used to memoize a function, preventing it from being recreated on every render. This is particularly useful when passing functions as props to child components that rely on reference equality to prevent unnecessary re-renders.

#### Syntax:
```javascript
const memoizedCallback = useCallback(() => {
  // Your function logic here
}, [dependencies]);
```

#### Key Features:
-  **Memoization**: It returns a memoized version of the callback function that only changes if one of the dependencies has changed.
-  **Performance Optimization**: Helps avoid unnecessary re-renders of child components that depend on the function.
-  **Use Case**: Useful in scenarios where you pass a callback to a child component that uses `React.memo` or similar optimizations.

#### Example:
```javascript
const ParentComponent = () => {
  const [count, setCount] = useState(0);

  const increment = useCallback(() => {
    setCount(c => c + 1);
  }, []); // Only recreated if dependencies change

  return <ChildComponent onClick={increment} />;
};
```

### `useEffect`

#### Purpose:
-  `useEffect` is used to perform side effects in function components. This includes data fetching, subscriptions, or manually changing the DOM.

#### Syntax:
```javascript
useEffect(() => {
  // Your side-effect logic here

  return () => {
    // Cleanup logic here (optional)
  };
}, [dependencies]);
```

#### Key Features:
-  **Side Effects**: It runs after the render is committed to the screen, allowing you to perform operations that do not directly affect the rendering output.
-  **Cleanup**: It can return a cleanup function that runs when the component unmounts or before the effect runs again.
-  **Use Case**: Useful for operations like fetching data, subscribing to events, or directly manipulating the DOM.

#### Example:
```javascript
const Component = () => {
  const [data, setData] = useState(null);

  useEffect(() => {
    fetchData().then(response => setData(response));

    return () => {
      // Cleanup if necessary, e.g., unsubscribing from an event
    };
  }, []); // Runs once on mount due to empty dependency array

  return <div>{data}</div>;
};
```

### Key Differences

| Feature                | `useCallback`                                           | `useEffect`                                          |
|------------------------|--------------------------------------------------------|-----------------------------------------------------|
| **Purpose**            | Memoizes a function to prevent recreation on re-renders | Handles side effects after rendering                  |
| **Return Value**       | Returns a memoized function                             | Does not return anything (or a cleanup function)     |
| **When It Runs**       | Runs during the render phase (when the component renders) | Runs after the render phase (after paint)            |
| **Dependencies**       | Dependencies determine when the function is recreated  | Dependencies determine when the effect runs          |
| **Use Cases**          | Passing functions to child components                   | Fetching data, subscriptions, or DOM manipulations   |

### Summary
-  **Use `useCallback`** when you want to optimize performance by memoizing functions that are passed as props to child components.
-  **Use `useEffect`** when you need to perform side effects in your component, such as data fetching or subscriptions, and manage cleanup.

Both hooks are essential for managing performance and side effects in React applications, and understanding their differences helps in writing efficient and effective React components.
