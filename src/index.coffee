karma = require('karma').server
path = require 'path'

module.exports.run = (newConfig, done) ->
  config =
    configFile: path.resolve(__dirname, '..', 'karma.conf.coffee')

  for key, value of newConfig
    config[key] = value

  karma.start config, done

