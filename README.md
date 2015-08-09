# fresh-promsie


```
promise = new Promise()
```

```js
Cache = require("fresh-promise");
cachedResult = new Cache(3600, function() {
    // returns a promise
});

cachedResult.then(...);
```
