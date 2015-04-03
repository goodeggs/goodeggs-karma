path = require 'path'
coffeeify = require 'coffeeify'
jadeifyRender = require 'goodeggs-jadeify'
ngAnnotatify = require 'ng-annotatify'

module.exports = (config) ->

  config.set

    # base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: process.cwd(),

    # list of files / patterns to load in the browser
    files: [
      path.join(require.resolve('angular'), '..', 'angular.js')
      path.join(require.resolve('angular-mocks'))

      # load css so that we can do some basic visual testing
      'public/build/app.css'

      # entry point for app (will watch all required files)
      'app/index.coffee'

      # test files
      'app/**/*.karma.coffee'
      'local_modules/**/*.karma.coffee'
    ],

    # NOTE: order frameworks loaded is important. Seems to load the last one first
    frameworks: [
      'browserify'
      'mocha'
      'chai-jquery'
      'sinon-chai'
      'chai'
      'jquery-2.1.0'
    ]

    # NOTE: order plugins loaded is important. Seems to load the last one first
    # NOTE: these plugins must be in devDependencies
    plugins: [
      require 'karma-browserify'
      require 'karma-spec-reporter'
      require 'karma-mocha'
      require 'karma-sinon-chai'
      require 'karma-jquery'
      require 'karma-chai-jquery'
      require 'karma-chrome-launcher'
      require 'karma-chai'
    ]

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
    logLevel: config.LOG_INFO

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
