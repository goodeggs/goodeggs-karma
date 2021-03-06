path = require 'path'
coffeeify = require 'coffeeify'
jadeifyRender = require 'goodeggs-jadeify'
ngAnnotatify = require 'ng-annotatify'

module.exports =
  # base path that will be used to resolve all patterns (eg. files, exclude)
  basePath: process.cwd(),

  # list of files / patterns to load in the browser
  files: [
    path.join(require.resolve('angular'), '..', 'angular.js')
    path.join(require.resolve('angular-mocks'))

    # load css so that we can do some basic visual testing
    'build/public/app.css'
    {pattern: 'build/public/fonts/**', watched: false, included: false, served: true}

    # entry point for app (will watch all required files)
    'app/index.coffee'

    # test files
    'app/**/*.karma.coffee'
    'local_modules/**/*.karma.coffee'
  ],

  # serve proxy fonts to the paths found in app.css
  proxies:
    '/fonts/': '/base/build/public/fonts/'

  singleRun: true

  # NOTE: order frameworks loaded is important. Seems to load the last one first
  frameworks: [
    'browserify'
    'source-map-support'
    'mocha'
    'dirty-chai'
    'chai-jquery'
    'sinon-chai'
    'chai'
    'jquery-2.1.0'
  ]

  # NOTE: order plugins loaded is important. Seems to load the last one first
  # NOTE: these plugins must be in devDependencies
  plugins: [
    require 'karma-browserify'
    require 'karma-source-map-support'
    require 'karma-spec-reporter'
    require 'karma-mocha'
    require 'karma-dirty-chai'
    require 'karma-sinon-chai'
    require 'karma-jquery'
    require 'karma-chai-jquery'
    require 'karma-chrome-launcher'
    require 'karma-chai'
  ]

  client:
    mocha:
      timeout: 10000

  # list of files to exclude
  exclude: [
  ],

  # preprocess matching files before serving them to the browser
  # available preprocessors: https:#npmjs.org/browse/keyword/karma-preprocessor
  preprocessors:
    '**/*.coffee': ['browserify']

  browserify:
    debug: true
    transform: [
      # global transform so thaat we can require .coffee files from node_modules
      [coffeeify, {global: true}]
      [jadeifyRender, {global: true}]
      [ngAnnotatify, {global: true}]
    ]
    extensions: [
      '.coffee'
      '.jade'
      '.js'
      '.json'
    ]

  watchify:
    # ignore all node modules except of local modules
    ignoreWatch: ['**/node_modules/**', '!**/node_modules/local_modules/**']

  # test results reporter to use
  # possible values: 'dots', 'progress'
  # available reporters: https:#npmjs.org/browse/keyword/karma-reporter
  reporters: ['spec']

  # web server port
  port: 9876

  # enable / disable colors in the output (reporters and logs)
  colors: true

  # level of logging
  # possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
  logLevel: 'INFO'

  # "If any browser does not get captured within the timeout, Karma will kill it and try to launch it again.
  #  After three attempts to capture it, Karma will give up."
  # default: 60000
  captureTimeout: 60000

  # "How long does Karma wait for a browser to reconnect (in ms)." default: 2000
  browserDisconnectTimeout: 10000

  # "maximum number of tries a browser will attempt in the case of a disconnection"
  # default: 0
  browserDisconnectTolerance: 1

  # "How long will Karma wait for a message from a browser before disconnecting from it"
  # default: 10000
  browserNoActivityTimeout: 30000

  # enable / disable watching file and executing tests whenever any file changes
  autoWatch: true

  # start these browsers
  # available browser launchers: https:#npmjs.org/browse/keyword/karma-launcher
  browsers: do ->
    if process.env.TRAVIS
      ['chrome_travis']
    else
      ['Chrome']

  customLaunchers: do ->
    if process.env.TRAVIS
      chrome_travis:
        base: 'Chrome'
        flags: ['--no-sandbox']
    else
      {}
