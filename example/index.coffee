#!/usr/bin/env coffee
fs = require 'fs'
dd = require 'ddeyes'
size = fs.stat

Task = require 'data.task'
TaskExtra = require '../index.js'
Task = TaskExtra Task

sizefp = (file) ->
  new Task (reject, resolve) ->
    size file, (err, data) ->
      if err
      then reject err
      else resolve data

Task.all [
  sizefp '../.gitignore'
  sizefp '../package.json'
]
.map (data) ->
  dd data
  data
.fork(
  (err) -> throw new Error err
  (data) ->
    # dd { data }
    return
)
