_ = require('underscore')
mongoose = require('mongoose')
fs = require "fs"
oid = (id = null)-> mongoose.Types.ObjectId(id)
shordid = ()-> parseInt(oid(),16).toString(36)

Gallery = mongoose.model "galleries",mongoose.Schema
	name: String
	path: String
	images:[]
_.extend Gallery,
	getPath:(path,callback)->
		Gallery.findOne {path:path},(err,data)->
			console.log "fineone ret",err or "noerr",data
			if err then console.log "err",err
			if not data 
				data = new Gallery(path:path)
				console.log "if not data",data
				data.save (err,data)->
					callback err,data
			else 
				callback err,data
	addImages:(path,images,callback)->
		Gallery.getPath path,(err,model)->
			_.each images,(fd)->
				name = "#{shordid()}.#{fd.name}"
				destPath = "#{__dirname}/../uploads/#{name}"
				image = 
					name : fd.name
					path : name
				model.images.push image
				fs.rename fd.path,destPath
				# console.log "#{__dirname}/../uploads/#{name}"
			model.save (err,data)->
				console.log "data",data
				callback err,data

# Gallery.statics.get = (path)->

# Gallery.addFile = (path,files)->

exports.list = (req, res)->
	path = req.params.path
	Gallery.getPath path,(err,data)->
		res.json data.toJSON()
	# res.json [path,"hello"]
exports.post = (req, res)->
	images = req.files.images
	# console.log req.params.path,"post"
	# Gallery.findOne {path:req.params.path},(err,data)->
	# 	console.log "findone in post",err,data
	Gallery.addImages req.params.path,images,(err,data)->
		res.json data
	# console.log _.methods req.files.images[0],req.files.images[0],
	# res.send("respond with a resource")
if "test" in process.argv
	console.log "connect?"
	mongoose.connect "localhost/test"
	console.log mongoose
	Gallery.getPath "path",(err,data)-> console.log "getpath test",err,data
	fpath = "/var/folders/5c/1b2w3n8109x7t8wdhnntkhj40000gn/T/0cd557b8947a071498cc7509408420fa"
	name = "长颈路.jpg"
