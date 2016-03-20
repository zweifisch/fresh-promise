# fresh-promsie

[![NPM Version][npm-image]][npm-url]
[![Build Status][travis-image]][travis-url]

promise that keeps itself fresh

```js
var FreshPromise = require("fresh-promise");

var cached = new FreshPromise(5000/*ttl*/, function() {
    return Promise.resolve(Math.random());
});

cached.then(...);
cached.then(...);  // should be the same

sleep(5000).then(...);  // promise should be updated
```

[npm-image]: https://img.shields.io/npm/v/fresh-promise.svg?style=flat
[npm-url]: https://npmjs.org/package/fresh-promise
[travis-image]: https://img.shields.io/travis/zweifisch/fresh-promise.svg?style=flat
[travis-url]: https://travis-ci.org/zweifisch/fresh-promise
