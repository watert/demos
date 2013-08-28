require ["app/base","backbone"],(App,Backbone)->
	window.App = App;
	GalleryView = Backbone.View.extend
		descTmpl : _.template """
			path: <code><%=path%></code>
			image count: <code><%=images.length%></code>
		"""
		render:()->
			console.log @collection
			html = @descTmpl @collection.data
			@$(".desc").html(html)
		initialize:(options)->
			@collection - options.collection
			@render()
	ImageView = Backbone.View.extend
		tmpl: _.template """
			<div class="img-container">
				<img src="uploads/<%=path%>" alt="" class="img">
			</div>
		"""
		tagName:"div"
		size:100
		className:"image-item pull-left img-polaroid"
		setSize:()->
			img = @$("img")
			[w,h] = [img.width(),img.height()]
			if h>w then img.css 
				"width":@size
				"margin-top":(w-h)*0.5*@size/w
			else img.css 
				"height":@size
				"margin-left":(h-w)*0.5*@size/h
		initialize:(model)->
			@$el.html @tmpl(model.toJSON())
			@$(".img-container").css width:@size,height:@size
			img = @$("img")
			img[0].onload = ()=>
				console.log "onload"
				@setSize()
	GalleryCollection = Backbone.Collection.extend
		url:"gallery/"
		initialize:(path="path")->
			@path = path
			@url += path
			console.log @url
			@
		parse:(data)->
			@data = data
			data.images
	$ ->
		path = "path"
		$el = $(".gallery")

		collection = new GalleryCollection(path)
		collection.on "reset",(data)->
			new GalleryView 
				el:$(".gallery-container")[0]
				collection:collection
			$el.empty()
			@each (img)->
				view = new ImageView img
				$el.append view.$el
		# collection.on "all",(e,a,b)-> console.log "coll on all:",e,a,b
		collection.fetch success:()->collection.trigger "reset"
		require ["jquery-file-upload","bootstrap"],(jqfupload)->
			$ -> $(".btn-upload").fileupload
				done:(e,data)->
					json = data.result
					collection.reset json
					#collection.trigger "sync"
					console.log "done,e,data.result",e,data.result