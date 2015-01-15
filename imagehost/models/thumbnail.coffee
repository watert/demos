_ = require "underscore"
imagemagick = require "imagemagick"
thumbnailsQueue = []
size = 200
destPath = "#{__dirname}/../uploads/thumbnails/"
console.log __dirname

exports.crop = (f,callback)->
	
	destName = f.split("/").pop()
	destFile = "#{destPath}#{size}-#{destName}"
	config = 
		srcPath:f
		dstPath:destFile
		width:size
		height:size
		gravity:"center"
	imagemagick.crop config,(a,b,c)->
		console.log "crop",a,b,c
		callback?(a,b,c)


exports.setSize = (_size)->
	size = _size

if "debug" in process.argv
	console.log imagemagick
	f = "uploads/2gnukmyobuv4go8wwwo.长颈鹿.jpg"
	imagemagick.identify ["-format","%w*%h",f], (err, metadata)->
		if (err) then throw err
		console.log('meta',metadata)
	destName = f.split("/").pop()
	destFile = "#{destPath}#{size}-#{destName}"
	config = 
		srcPath:f
		dstPath:destFile
		width:size
		height:size
		gravity:"center"
	imagemagick.crop config,(a,b,c)->
		console.log "crop",a,b,c
	console.log config