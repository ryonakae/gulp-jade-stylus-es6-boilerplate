gulp = require 'gulp'
path = require '../path'


gulp.task 'watch', ->
  gulp.watch path.source.root + '**/*.jade', ['jade']
  gulp.watch path.source.stylesheets + '**/*.styl', ['stylus']
  gulp.watch path.source.fonts + '*', ['copyFile']
  gulp.watch path.source.sprite + '*', ->
    runSequence 'imageSprite', 'stylus'