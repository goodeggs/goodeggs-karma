Server = require('karma').Server
path = require 'path'

module.exports.run = (newConfig, done) ->
  config =
    configFile: path.resolve(__dirname, '..', 'karma.conf.coffee')

  for key, value of newConfig
    config[key] = value

  server = new Server(config, done)
  server.start()
