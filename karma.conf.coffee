jadeifyRender = require 'goodeggs-jadeify'
ngAnnotatify = require 'ng-annotatify'

module.exports = (config) ->

  config.set

    # base path that will be used to resolve all patterns (eg. files, exclude)
    basePath: process.cwd(),

    # list of files / patterns to load in the browser
    files: [
      'node_modules/angular/angular.js'
      'node_modules/angular-mocks/angular-mocks.js'

      # load css so that we can do some basic visual testing
      'public/build/app.css'

      # entry point for app (will watch all required files)
      'src/client/app/index.coffee'

      # test files
      'src/client/**/*.karma.coffee'
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
      'karma-browserify'
      'karma-spec-reporter'
      'karma-mocha'
      'karma-sinon-chai'
      'karma-jquery'
      'karma-chai-jquery'
      'karma-chrome-launcher'
      'karma-chai'
    ]

    # list of files to exclude
    exclude: [
    ],

    # preprocess matching files before serving them to the browser
    # available preprocessors: https:#npmjs.org/browse/keyword/karma-preprocessor
    preprocessors:
      'src/client/app/index.coffee': ['browserify']
      '**/*karma.coffee': ['browserify']

    browserify:
      debug: true
      transform: [
        # global transform so thaat we can require .coffee files from node_modules
        ["coffeeify", {global: true}]
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
