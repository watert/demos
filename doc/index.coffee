define "app/views/list",["app/base"], (App)->
	App.Views.List = class ListView extends Backbone.View
		tmpl:_.template """
			<a href="?f=<%=name%>" class="list-group-item"><%=name%></a>
		"""
		render:()->
			for f in @data
				tmpl = @tmpl f
				@$el.append tmpl
		initialize:(options)->
			@data = options.data
			if @data then @render()				
require [ "app/base","marked","data","app/views/list"], (App,marked,data)->
	window.App = App
	App.data = data

	new App.Views.List
		el:$("#mdList")[0]
		data: {name:i} for i in data.files
	$.get data.markdown,(md)->
		dom = $("#mdContent")
		dom.html(marked.parse(md))
		title = dom.find("h1,h2").eq(0).text()
		$("title").html title