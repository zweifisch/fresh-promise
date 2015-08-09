# fresh-promsie

promise that keeps itself fresh

```js
var FreshPromise = require("fresh-promise");

var cached = new FreshPromise(5000, function() {
    return Promise.resolve(Math.random());
});

cached.then(...);
cached.then(...);  // should be the same

sleep(5000).then(...);  // promise should be updated
```
