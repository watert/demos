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
      setSize: function() {
        var h, img, w, _ref;
        img = this.$("img");
        _ref = [img.width(), img.height()], w = _ref[0], h = _ref[1];
        if (h > w) {
          return img.css({
            "width": this.size,
            "margin-top": (w - h) * 0.5 * this.size / w
          });
        } else {
          return img.css({
            "height": this.size,
            "margin-left": (h - w) * 0.5 * this.size / h
          });
        }
      },
      initialize: function(model) {
        var img,
          _this = this;
        this.$el.html(this.tmpl(model.toJSON()));
        this.$(".img-container").css({
          width: this.size,
          height: this.size
        });
        img = this.$("img");
        return img[0].onload = function() {
          console.log("onload");
          return _this.setSize();
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
        return this.each(function(img) {
          var view;
          view = new ImageView(img);
          return $el.append(view.$el);
        });
      });
      collection.fetch({
        success: function() {
          return collection.trigger("reset");
        }
      });
      return require(["jquery-file-upload", "bootstrap"], function(jqfupload) {
        return $(function() {
          return $(".btn-upload").fileupload({
            done: function(e, data) {
              var json;
              json = data.result;
              collection.reset(json);
              return console.log("done,e,data.result", e, data.result);
            }
          });
        });
      });
    });
  });

}).call(this);
