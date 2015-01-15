
/**
 * Module dependencies.
 */
require("coffee-script");
var express = require('express')
  , routes = require('./routes')
  , user = require('./routes/user')
  , http = require('http')
  , path = require('path');

var app = express();
var mongoose = require('mongoose');
mongoose.connect('localhost/test');

// all environments
app.set('port', process.env.PORT || 3002);
app.set('views', __dirname + '/views');
app.set('view engine', 'jade');

app.use(require("less-middleware")({
	src: __dirname + '/public',
	compress: true
}));
app.use(require("connect-coffee-script")({
	src: __dirname + '/public',
	compress: true
}));

app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.bodyParser());
app.use(express.methodOverride());
app.use(app.router);
app.use(express.static(path.join(__dirname, 'public')));
app.use("/uploads",express.static(path.join(__dirname, 'uploads')));

// development only
if ('development' == app.get('env')) {
  app.use(express.errorHandler());
}

app.get('/', routes.index);
app.get('/users', user.list);

var gallery = require("./routes/gallery.coffee");
app.get('/gallery/:path', gallery.list);
app.post('/upload/:path', gallery.post);

http.createServer(app).listen(app.get('port'), function(){
  console.log('Express server listening on port ' + app.get('port'));
});
