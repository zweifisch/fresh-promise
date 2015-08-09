chai = require 'chai'
promised = require "chai-as-promised";
chai.use(promised);
chai.should()

Cache = require './index'

sleep = (time)->
    new Promise (resolve)-> setTimeout resolve, time

describe 'Cache', ->

    it 'should invalidate', ->

        numbers = [1, 2, 3]

        cached = new Cache 10, ->
            new Promise (resolve)-> resolve numbers.pop()

        Promise.all([
            cached
            cached
            sleep(25).then(-> cached)
            sleep(35).then(-> cached)
        ]).should.eventually.deep.equal [3, 3, 2, 1]
