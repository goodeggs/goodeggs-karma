Server = require('karma').Server
path = require 'path'

module.exports.run = ({files, sourcemap, watch} = {}, done) ->
  config =
    configFile: path.resolve(__dirname, '..', 'karma.conf.coffee')

  if files?
    config.files = files
  if watch is true
    config.singleRun = false
    config.reporters = ['dots']
  if sourcemap?
    config.browserify.debug = sourcemap

  server = new Server(config, done)
  server.start()
