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
		setSize:(size)->
			@size = size
			img = @$("img")
			[w,h] = [img.width(),img.height()]
			if not w then return #image not loaded
			console.log w,h
			if h>w then img.css 
				"width":size
				"margin-top":(w-h)*0.5*@size/w
			else img.css 
				"height":size
				"margin-left":(h-w)*0.5*@size/h
			@$(".img-container").css width:@size,height:@size
		initialize:(model)->
			@$el.html @tmpl(model.toJSON())
			img = @$("img")
			img[0].onload = ()=>
				console.log "onload"
				@setSize(@size)
	GalleryCollection = Backbone.Collection.extend
		url:"gallery/"
		initialize:(path="path")->
			@path = path
			@url += path
			console.log @url
			@
		parse:(data)->
			console.log "parseData",data
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
				img.view = view
				$el.append view.$el
			# console.log App.trigger
			App.trigger "gallery-loaded"
		App.imgs = collection
		App.on "resize",(size)->
			collection.each (model)-> model.view.setSize size
		App.on "gallery-loaded", ->
			itemDom = $(".image-item:eq(0)")
			h1 = $(".gallery-container").height()
			h2 = $(".gallery-title").outerHeight()
			size = h1 -  h2 - ( itemDom.outerHeight()-itemDom.height() )
			App.trigger "resize",size
		collection.fetch success:()->
			collection.trigger "reset"
		require ["jquery-file-upload"],(jqfupload)->
			$ -> $(".btn-upload").fileupload
				done:(e,data)->
					data = data.result
					data = collection.parse(data)
					collection.reset data
					#collection.trigger "sync"
					console.log "done,e,data.result",e,data.result