gulp = require 'gulp'
path = require '../path'
eslint = require 'gulp-eslint'


gulp.task 'eslint', ->
  gulp.src path.source.javascripts + '**/*.js'
    .pipe eslint
      useEslintrc: true
    .pipe eslint.format()
    .pipe eslint.failAfterError()