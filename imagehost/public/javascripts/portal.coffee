require ["backbone"],(Backbone)->
	GalleryView = Backbone.View.extend
		descTmpl = _.template """
			path: <code><%=path%></code>
			image count: <code><%=images.length%></code>
		"""
		render:()->
			@$(".desc").html @descTmpl @collection
		initialize:(options)->
			@collection - options.collection
			@render
	ImageView = Backbone.View.extend
		tmpl: _.template """
			<div class="img-container">
				<img src="uploads/<%=path%>" alt="" class="img">
			</div>
		"""
		tagName:"div"
		className:"image-item pull-left img-polaroid"
		initialize:(model)->
			@$el.html @tmpl model.toJSON()
			img = @$("img")
			img[0].onload = ()->
				img.css "margin-top":(img.width()-img.height())/2
				#console.log img.height(),img.width(),img
	GalleryCollection = Backbone.Collection.extend
		url:"gallery/"
		initialize:(path="path")->
			@url += path
			console.log @url
			@
		parse:(data)->
			@data = data
			data.images
	$ ->
		path = "path"
		collection = new GalleryCollection(path)
		collection.on "sync",(data)->
			$el = $(".gallery")
			$el.empty()
			@each (img)->
				view = new ImageView img
				$el.append view.$el

		collection.fetch()