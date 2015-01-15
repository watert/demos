(function() {
  require(["app/base", "backbone"], function(App, Backbone) {
    var GalleryCollection, GalleryView, ImageView;
    window.App = App;
    GalleryView = Backbone.View.extend({
      descTmpl: _.template("path: <code><%=path%></code>\nimage count: <code><%=images.length%></code>"),
      render: function() {
        var html;
        console.log(this.collection);
        html = this.descTmpl(this.collection.data);
        return this.$(".desc").html(html);
      },
      initialize: function(options) {
        this.collection - options.collection;
        return this.render();
      }
    });
    ImageView = Backbone.View.extend({
      tmpl: _.template("<div class=\"img-container\">\n	<img src=\"uploads/<%=path%>\" alt=\"\" class=\"img\">\n</div>"),
      tagName: "div",
      size: 100,
      className: "image-item pull-left img-polaroid",
      setSize: function(size) {
        var h, img, w, _ref;
        this.size = size;
        img = this.$("img");
        _ref = [img.width(), img.height()], w = _ref[0], h = _ref[1];
        if (!w) {
          return;
        }
        console.log(w, h);
        if (h > w) {
          img.css({
            "width": size,
            "margin-top": (w - h) * 0.5 * this.size / w
          });
        } else {
          img.css({
            "height": size,
            "margin-left": (h - w) * 0.5 * this.size / h
          });
        }
        return this.$(".img-container").css({
          width: this.size,
          height: this.size
        });
      },
      initialize: function(model) {
        var img,
          _this = this;
        this.$el.html(this.tmpl(model.toJSON()));
        img = this.$("img");
        return img[0].onload = function() {
          console.log("onload");
          return _this.setSize(_this.size);
        };
      }
    });
    GalleryCollection = Backbone.Collection.extend({
      url: "gallery/",
      initialize: function(path) {
        if (path == null) {
          path = "path";
        }
        this.path = path;
        this.url += path;
        console.log(this.url);
        return this;
      },
      parse: function(data) {
        console.log("parseData", data);
        this.data = data;
        return data.images;
      }
    });
    return $(function() {
      var $el, collection, path;
      path = "path";
      $el = $(".gallery");
      collection = new GalleryCollection(path);
      collection.on("reset", function(data) {
        new GalleryView({
          el: $(".gallery-container")[0],
          collection: collection
        });
        $el.empty();
        this.each(function(img) {
          var view;
          view = new ImageView(img);
          img.view = view;
          return $el.append(view.$el);
        });
        return App.trigger("gallery-loaded");
      });
      App.imgs = collection;
      App.on("resize", function(size) {
        return collection.each(function(model) {
          return model.view.setSize(size);
        });
      });
      App.on("gallery-loaded", function() {
        var h1, h2, itemDom, size;
        itemDom = $(".image-item:eq(0)");
        h1 = $(".gallery-container").height();
        h2 = $(".gallery-title").outerHeight();
        size = h1 - h2 - (itemDom.outerHeight() - itemDom.height());
        return App.trigger("resize", size);
      });
      collection.fetch({
        success: function() {
          return collection.trigger("reset");
        }
      });
      return require(["jquery-file-upload"], function(jqfupload) {
        return $(function() {
          return $(".btn-upload").fileupload({
            done: function(e, data) {
              data = data.result;
              data = collection.parse(data);
              collection.reset(data);
              return console.log("done,e,data.result", e, data.result);
            }
          });
        });
      });
    });
  });

}).call(this);
