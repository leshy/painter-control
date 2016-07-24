require! {
  path
  browserify
  ejsify
  watchify
  
  'gulp-uglify': uglify
  'gulp-rename': rename
  'gulp-util': gutil
  'gulp-livescript'
  'gulp-less': less
  'gulp-uglifycss': uglifyCss
  'vinyl-source-stream': source
  'vinyl-buffer': buffer
  'vinyl-transform': transform
  'browserify-livescript'
  'node-lessify': lessify
  'loose-envify/custom': envify
  
  'gulp-livereload': livereload

  # POSTCSS
  'css-modulesify'
  autoprefixer
  precss
  'postcss-less-parser'

  
  uglifyify
  babelify
  colors
  
  bluebird: p
  
  'child_process': { exec }
  path: { basename }
  
  leshdash: { map, head }
  
}


gulp = require('gulp-npm-run')(require 'gulp')

bInstances = {}
 
staticRoot = "./static"

# hacky way to get a browserify gulp stream (able to watch & do fast subsequent compilations)
browserifyStream = (filename, conf={}) -> 
  getBundler = ->
    if bundler = bInstances[filename] then return bundler
      
    if conf.production then bundler = browserify()
    else bundler = browserify cache: {}, debug: true # append sourcemaps to bundle (uglify will remove those for production)
    
    bundler = browserify cache: {}, debug: true # append sourcemaps to bundle (uglify will remove those for production)
    bundler.add filename
    
    bundler.transform ejsify
    bundler.transform browserifyLivescript
    bundler.transform babelify, { presets: [ 'react', 'es2015' ], extensions: [".ls"] }


    postCssOptions = do
      rootDir: __dirname + "/clientside/"
      output: './static/css/bundle.css'
      
      before: [
        precss!
      ]
      
      after: [
          autoprefixer({ browsers: ['> 1%'] }),
      ]
      
#    if conf.production
#      postCssOptions.generateScopedName = cssModulesify.generateShortName

#      postCssOptions.after.push cssnano do
#        autoprefixer: { disable: true },
#        postcssDiscardDuplicates: { disable: true },
#        postcssConvertValues: { disable: true },
#        postcssDiscardUnused: { disable: true },
#        postcssReduceIdents: { counterStyle: false, keyframes: false },
#        postcssZindex: { disable: true }

    bundler.plugin cssModulesify, postCssOptions
    
    if conf.production
      bundler.transform global: true, envify( '_': 'purge', NODE_ENV: 'production' )
#      bundler.transform global: true, uglifyify

    # makes browserify cache stuff, subsequent calls are faster
    if conf.watch
      bundler.plugin watchify

    bInstances[filename] = bundler

  gutil.log 'Bundle start', filename
  
  bundler = getBundler()
  startTime = new Date().getTime()
  
  stream = bundler.bundle()

  stream.on 'error', (error) ->
    endTime = new Date().getTime() - startTime
    gutil.log 'Bundle error', filename, endTime, 'ms', error.message
    exec "/usr/bin/notify-send -i ~/.config/awesome/icons/fa/noRed.png -t 5000 #{basename error.filename} \"#{head error.message.split('\n')}\""

  stream.on 'end', ->
    endTime = new Date().getTime() - startTime
    gutil.log 'Bundle done', filename, endTime, 'ms'
    exec "/usr/bin/notify-send  -i ~/.config/awesome/icons/fa/thumbsupGreen.png -t 2000 #{filename} \"done after #{endTime} ms\""

  stream
  .pipe source filename

bundle = (filename, basename, conf={}) ->
  browserifyStream filename, conf  
  .pipe rename do
    dirname: '/js/'
    extname: '.js'
    basename: basename
  .pipe gulp.dest staticRoot
  .on 'error', gutil.log

gulp.task 'uglify', <[ jsProd ]> ->
  root = path.join staticRoot, '/js/'
  return gulp.src [ root + "*.js", "!" + root + "*.min.js" ]
  .pipe uglify()
  .pipe rename extname: '.min.js'
  .pipe gulp.dest root

gulp.task 'uglifyCss', <[ css ]> ->
  root = path.join staticRoot, '/css/'
  return gulp.src [ root + "*.css", "!" + root + "*.min.css" ]
  .pipe uglifyCss maxLineLen: 80, uglyComments: true
  .pipe rename extname: '.min.css'
  .pipe gulp.dest root

bundleCss = (source, basename) ->
  gulp.src source
  .pipe less()
  .pipe rename do
    dirname: '/css/'
    extname: '.css'
    basename: basename
  .pipe gulp.dest staticRoot
  
gulp.task 'css', ->
  bundleCss './clientside/style.less', 'style'
  .pipe livereload()
  true

gulp.task 'js', ->
  bundle './clientside/index.ls', 'bundle', watch: true
  .pipe livereload()
  true
    
gulp.task 'landingJs', ->
  bundle './clientside/landing/index.ls', 'landing', watch: true

gulp.task 'userJsProd', ->
  bundle './clientside/user/index.ls', 'user', production: true

gulp.task 'adminJsProd', ->
  bundle './clientside/admin/index.ls', 'admin', production: true
  
gulp.task 'landingJsProd', ->
  bundle './clientside/landing/index.ls', 'landing', production: true

gulp.task 'liveReload', -> livereload.listen!

gulp.task 'jsProd', <[ userJsProd adminJsProd landingJsProd ]> -> true

logChange = (watcher) -> watcher.on 'change', -> gutil.log it.type, it.path
  
gulp.task 'watchCss', <[ liveReload ]>, ->
  logChange gulp.watch 'clientside/**/*.less', ['css']
  
gulp.task 'watchJs', <[ liveReload ]>, ->
  logChange gulp.watch 'clientside/**/*.ls', ['js']
  
gulp.task 'watch', <[ watchJs watchCss liveReload ]>

#gulp.task 'make', <[ jsProd css uglify uglifyCss ]>

