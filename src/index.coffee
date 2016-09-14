{ curryN } = require 'ramda'

module.exports = (Task) ->

  Task.all = (arr) ->
    arr.reduce (result, func) ->
      result.ap func
    ,
      Task.of curryN arr.length
      , -> Array::slice.call arguments

  Task.seq = (arr) ->
    _result = []
    arr.reduce (result, func, index) ->
      result.chain (last) ->
        _result.push last unless last is null
        unless index is arr.length - 1
        then func
        else func.chain (latest) ->
          _result.push latest
          Task.of _result
    , Task.of null

  Task
