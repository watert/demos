lazy = require "lazy"
fs = require "fs"
stream = (f)->
	fs.createReadStream f
l = new lazy(stream)

lines = (linesCount,func)->
	l = new lazy(stream "access_log")
	l.lines.take(linesCount).forEach func
lines 5,(row)->
	console.log row.toString().split(" ")