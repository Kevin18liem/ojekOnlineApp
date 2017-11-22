//server.js

const express = require('express');
const MongoClient = require('mongodb').MongoClient
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
var Task = require('./api/model/todoListModel');
// const bodyParser = require('body-parser');

const app = express();

const port = 7000;

mongoose.Promise = global.Promise;
mongoose.connect('mongodb://127.0.0.1:27017')

app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());

var routes = require('./api/routes/todoListRoutes');
routes(app)

// require('./api/routes')(app, {});
app.listen(port, () => {
  console.log('We are live on ' + port);
});