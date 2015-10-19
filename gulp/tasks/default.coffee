gulp = require 'gulp'
path = require '../path'
env = require '../env'
runSequence  = require 'run-sequence'
browserSync = require 'browser-sync'


gulp.task 'default', ->
  # production
  if(env.isProduction == true)
    runSequence 'clearCache', 'cleanBuild', ['copyFile', 'imageSprite'], ['jade', 'stylus', 'browserify', 'imageMin']

  # development
  else
    runSequence 'cleanBuild', ['copyFile', 'imageSprite'], ['jade', 'stylus', 'browserify'], 'browserSync'

    # watch file
    gulp.watch path.source.root + '**/*.jade', ->
      runSequence 'jade', 'bsReload'
    gulp.watch path.source.stylesheets + '**/*.styl', ->
      runSequence 'stylus', 'bsReload'
    gulp.watch path.source.fonts + '*', ->
      runSequence 'copyFile', 'bsReload'
    gulp.watch path.source.sprite + '*', ->
      runSequence 'imageSprite', 'stylus', 'bsReload'