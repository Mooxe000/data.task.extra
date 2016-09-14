{ curryN } = require 'ramda'

module.exports = (Task) ->

  Task.all = (arr) ->
    arr.reduce (result, func) ->
      result.ap func
    ,
      Task.of curryN arr.length
      , -> Array::slice.call arguments

  Task
