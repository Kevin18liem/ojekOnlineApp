var express = require('express'),
  app = express(),
  port = process.env.PORT || 3000,
  mongoose = require('mongoose'),
  Task = require('./api/model/chatModel'), //created model loading here
  bodyParser = require('body-parser');
  
// mongoose instance connection url connection
mongoose.Promise = global.Promise;
mongoose.connect('mongodb://127.0.0.1:27017'); 

app.use(function(req, res, next){
		res.setHeader('Access-Control-Allow-Origin', 'http://localhost:8000');
		res.setHeader('Access-Control-Allow-Methods', 'GET, POST, DELETE');
		res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With, content-type');
		res.setHeader('Acess-Control-Allow-Credentials', true);
		next();
	});

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());


var routes = require('./api/routes/chatRoutes'); //importing route
routes(app); //register the route

app.listen(port);


console.log('todo list RESTful API server started on: ' + port);