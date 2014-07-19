# Load plugins
gulp = require("gulp")
plugins = require("gulp-load-plugins")(camelize: true)
lr = require("tiny-lr")
server = lr()

# Define Paths
folders =
	source: 'Assets/Source'
	development: 'Assets/Built'
	production: "Assets/Production"
	vendorScripts: 'Assets/Source/Vendor'

files = 
	scripts: folders.source + '/Scripts'
	styles: [ folders.source + '/Styles/**/*.less',  folders.source + '/Site/**/*.less']
	images: folders.source + '/Images'
	iconFont: folders.source + '/Styles/Include/IconFont/fonts'
	php: folders.source + "/**/*.php"

vendorFiles = [
	# Jquery
	"jquery/dist/jquery.js"

	# JS Utils
	"lodash/dist/lodash.js"
	"momentjs/moment.js"
	"log/log.js"

	# Angular
	"angular/angular.js"
	"angular-animate/angular-animate.js"
	"angular-mocks/angular-mocks.js"
	"angular-sanitize/angular-sanitize.js"
]

# Lets append the correct base path to these files names
for file, index in vendorFiles
	vendorFiles[index] = folders.vendorScripts + '/' + file


# Styles
gulp.task "styles", ->
	gulp
		.src "./style.less"
		.pipe plugins.plumber()
		.pipe plugins.less()
		.pipe gulp.dest( folders.development + '/Styles' )
		.pipe plugins.minifyCss(keepSpecialComments: 1)
		.pipe plugins.livereload(server)
		.pipe gulp.dest("./")
		.pipe plugins.notify(message: "Styles task complete")


# Vendor Files
gulp.task "vendors", ->
	gulp
		.src vendorFiles
		.pipe plugins.plumber()
		.pipe plugins.concat("vendors.js")
		.pipe gulp.dest( folders.development + '/Vendor' )
		.pipe plugins.rename(suffix: ".min")
		.pipe plugins.uglify()
		.pipe plugins.livereload(server)
		.pipe gulp.dest( folders.development + '/Vendor' )
		.pipe plugins.notify(message: "Scripts task complete")


# Site Scripts
gulp.task "scripts", ->
	gulp
		.src [ files.scripts + '/**/*.coffee' ]
		.pipe plugins.plumber()
		.pipe plugins.coffee()
		.pipe plugins.concat("main.js")
		.pipe gulp.dest( folders.development + '/Scripts' )
		.pipe plugins.rename(suffix: ".min")
		.pipe plugins.uglify()
		.pipe plugins.livereload(server)
		.pipe gulp.dest( folders.development + '/Scripts' )
		.pipe plugins.notify(message: "Scripts task complete")


# Images
gulp.task "images", ->
	gulp
		.src [files.images + "/**/*"]
		.pipe(	plugins.cache(plugins.imagemin( 
			optimizationLevel: 7 
			progressive: true
			interlaced: true
		)))
		.pipe plugins.livereload(server)
		.pipe gulp.dest( folders.development + '/Images' )
		.pipe plugins.notify(message: "Images task complete")


# IconFonts
gulp.task "iconFont", ->
	gulp
		.src [ files.iconFont + "/**/*" ]
		.pipe plugins.livereload(server)
		.pipe gulp.dest( folders.development + '/IconFont' )
		.pipe plugins.notify(message: "IconFont task complete")

# Generally we want to refresh on a PHP edit (aka we've edited some html)
gulp.task "html-refresh", ->
	gulp.src files.php
		.pipe plugins.livereload(server)


# Watch
gulp.task "watch", ->
	
	# Listen on port 35729
	server.listen 35729, (err) ->
		return console.log(err) if err
		
		# Watch .less files
		gulp.watch files.styles, [ "styles" ]
		
		# Watch .coffee files
		gulp.watch files.scripts + "/**/*.coffee", [ "scripts" ]
		
		# Watch image files
		gulp.watch files.images + "/**/*", ["images"]

		gulp.watch files.php, ["html-refresh"]



# Default task
gulp.task "default", [
	"styles"
	"vendors"
	"iconFont"
	"scripts"
	"images"
	"watch"
]
