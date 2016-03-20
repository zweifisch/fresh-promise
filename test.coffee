chai = require 'chai'
promised = require "chai-as-promised";
chai.use(promised);
chai.should()

Cache = require './index'

sleep = (time)->
    new Promise (resolve)-> setTimeout resolve, time

describe 'Cache', ->

    it 'should act like a promise', ->

        promise = new Cache 10, ->
            new Promise (resolve)-> resolve yes
        sleep(5).then promise.destroy
        promise.should.eventually.equal yes

    it 'should act like a promise', ->

        promise = new Cache 10, -> Promise.resolve 1
        inc = (x)-> x + 1
        sleep(10).then promise.destroy
        promise.then(inc).then(inc).should.eventually.equal 3

    it 'should invalidate', ->

        numbers = [1, 2, 3]
        cached = new Cache 10, ->
            Promise.resolve numbers.pop()
        sleep(70).then cached.destroy
        Promise.all([
            cached
            cached
            sleep(20).then(-> cached)
            sleep(35).then(-> cached)
        ]).should.eventually.deep.equal [3, 3, 2, 1]

    it 'should invalidate', ->

        counter = 0
        cached = new Cache 10, ->
            counter = counter + 1
            if counter % 2
                Promise.reject "odd"
            else
                Promise.resolve counter
        sleep(90).then cached.destroy
        Promise.all([
            cached
            sleep(5).then -> cached
            sleep(15).then -> cached
            sleep(28).then -> cached
            sleep(35).then -> cached
        ]).should.eventually.deep.equal [2, 2, 4, 6, 6]

    it 'should retry', ->

        numbers = [1, 2, 3, 4]
        cached = new Cache 1000, ->
            new Promise (resolve, reject)->
                number = numbers.shift()
                if number > 2
                    resolve number
                else
                    reject Error "#{number} is Too Small!"
        sleep(10).then cached.destroy
        cached.should.eventually.equal 3

    it 'should retry hard', ->

        counter = 0
        cached = new Cache 1000, ->
            counter = counter + 1
            if counter < 1000
                Promise.reject Error "Be patient!"
            else
                Promise.resolve "finally"
        sleep(10).then cached.destroy
        cached.should.eventually.equal "finally"
