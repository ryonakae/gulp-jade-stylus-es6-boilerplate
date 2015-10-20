gulp = require 'gulp'
path = require '../path'
browserSync = require 'browser-sync'


# browserSync
gulp.task 'browserSync', ->
  browserSync.init
    open: false
    notify: true
    reloadDelay: 800
    server:
      baseDir: path.build.root
    # logLevel: 'debug'
    # logConnections: true