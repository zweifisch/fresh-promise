
class Cache

    constructor: (@ttl, @source)->
        reset = =>
            @promise = null
            setTimeout reset, @ttl if @ttl
        setTimeout reset, @ttl

    then: (args...)->
        @promise = @source() unless @promise
        @promise.then args...

    catch: (args...)->
        @promise = @source() unless @promise
        @promise.catch args...

    destroy: ->
        @ttl = 0
    
module.exports = Cache
