gulp = require 'gulp'
path = require '../path'
env = require '../env'
browserify = require 'browserify'
babelify = require 'babelify'
watchify = require 'watchify'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
uglify = require 'gulp-uglify'
sourcemaps = require 'gulp-sourcemaps'
gutil = require 'gulp-util'
gulpif = require 'gulp-if'
prettyHrtime = require 'pretty-hrtime'
eslint = require 'gulp-eslint'
plumber = require 'gulp-plumber'
glob = require 'glob'


srcFiles = glob.sync './' + path.source.javascripts + '*.{js,coffee,jsx,vue}'
destPath = './' + path.build.javascripts


# bundle function
bundleScript = (isProduction) ->
  for file in srcFiles
    options =
      entries: file
      transform: [[babelify, { 'presets': ['es2015'] }]]

    if(isProduction == true)
      bundler = browserify options
    else
      bundler = watchify browserify options

    bundle = ->
      bundleFile = file.replace(/.+\/(.+)\.(js|coffee|jsx|vue)/g, '$1') + '.js'

      bundler
        .bundle()
        .on 'error', (err)->
          gutil.log 'Browserify Error: \n' + gutil.colors.red(err.message)
        .pipe source bundleFile
        .pipe buffer()
        .pipe gulpif isProduction == false, sourcemaps.init loadMaps: true
        .pipe gulpif isProduction == false, sourcemaps.write './'
        .pipe gulpif isProduction == true, uglify preserveComments: 'some'
        .on 'end', ->
          gutil.log 'Finished', "'" + gutil.colors.cyan('Browserify Bundled') + "'", gutil.colors.green(bundleFile)
        .pipe gulp.dest destPath

    bundler.on 'update', bundle
    bundle()


gulp.task 'browserify', ->
  bundleScript env.isProduction