gulp = require 'gulp'
path = require '../path'


# copy files
gulp.task 'copyFile', ->
  gulp.src(
    [
      path.source.fonts + '**/*'
    ]
    base: path.source.root
  )
  .pipe gulp.dest path.build.root