class Cache

    constructor: (@ttl, @source)->

    then: (cb)->
        if @promise
            @promise.then cb
        else
            wait = (resolve)=>
                @source()
                .catch => wait resolve
                .then (data)=>
                    setTimeout (=> @promise = null), @ttl if @ttl
                    resolve data
            @promise = new Promise wait
            @promise.then cb

    catch: (cb)-> this

    destroy: ->
        @ttl = null

module.exports = Cache
