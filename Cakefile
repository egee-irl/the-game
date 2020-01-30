{ exec, spawn } = require 'child_process'

build = () ->
  exec 'coffee --compile --output public/dist src/'

clean = () ->
  exec 'rm -rf dist/*'
  exec 'touch dist/.gitkeep'

task 'build', 'Description of task', ->
  build()

task 'rebuild', 'Description of task', ->
  build()
  clean()

task 'clean', 'Description of task', ->
  clean()