'use strict';
module.exports = function(app) {
  var chat = require('../controllers/chatController');

//   app.use(function(req, res, next) {
//   	res.header("Access-Control-Allow-Origin", "*");
//   	res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
//   		next();
// 	});

// app.get('/', function(req, res, next) {
//   // Handle the get for this route
// });

// app.post('/', function(req, res, next) {
//  // Handle the post for this route
// });
  
  app.route('/sendChat')
    .post(chat.send_chat);

  app.route('/listAllChat')
  	.get(chat.list_all_chat);

  app.route('/findCertainChat')
  	.post(chat.find_certain_chat);

  app.route('/deleteAllChat')
  	.delete(chat.delete_all_chat);
};