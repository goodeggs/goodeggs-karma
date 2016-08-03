Server = require('karma').Server
path = require 'path'
cloneDeep = require 'lodash.clonedeep'

karmaConfig = require '../karma.conf'

module.exports.run = ({files, sourcemap, watch} = {}, done) ->
  karmaConfigClone = cloneDeep(karmaConfig)

  if files?
    karmaConfigClone.files = files
  if watch is true
    karmaConfigClone.singleRun = false
    karmaConfigClone.reporters = ['dots']
  if sourcemap?
    karmaConfigClone.browserify.debug = sourcemap

  server = new Server(karmaConfigClone, done)
  server.start()
