gulp = require 'gulp'
path = require '../path'
env = require '../env'
browserify = require 'browserify'
babelify = require 'babelify'
watchify = require 'watchify'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
merge = require 'utils-merge'
uglify = require 'gulp-uglify'
sourcemaps = require 'gulp-sourcemaps'
gutil = require 'gulp-util'
gulpif = require 'gulp-if'


# path
# パスの先頭に ./ をつけないと何故かエラー出る
srcPath = './' + path.source.javascripts + 'main.js'
destPath = './' + path.build.javascripts


# browserify
# gulp.task 'browserify', ['bower'], ->
gulp.task 'browserify', ->
  compile env.isProduction


# compile task
compile = ->
  option =
    transform: [babelify]
    debug: true
    extensions: ['.js']
  bundler = null

  # production
  if(env.isProduction == true)
    bundler = browserify(srcPath, option)
  # development
  else
    bundler = watchify browserify(srcPath, option)

  bundle = ->
    bundler
      .bundle()
      .on 'error', (err)->
        console.log gutil.log 'Browserify Error: \n' + err.message
      .pipe source 'bundle.js'
      .pipe buffer()
      .pipe gulpif env.isProduction == false, sourcemaps.init
        loadMaps: true
      .pipe gulpif env.isProduction == false, sourcemaps.write './'
      .pipe gulpif env.isProduction == true, uglify
        preserveComments: 'some'
      .pipe gulp.dest destPath

  bundler.on 'update', ->
    bundle()
  bundler.on 'log', (msg)->
    gutil.log 'Finished', '\'' + gutil.colors.cyan('watchify') + '\'', msg

  bundle()