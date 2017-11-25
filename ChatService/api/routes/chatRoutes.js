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

  app.route('/changeDriverStatus')
  	.post(chat.change_driver_status)
  	.delete(chat.delete_driver_status);

  app.route('/setDriverStatusOffline')
  	.put(chat.set_driver_status_offline);

  app.route('/deleteAllDriver')
  	.delete(chat.delete_all_driver);

  app.route('/listAllDriver')
  	.get(chat.list_all_driver);

  app.route('/findCertainLocation')
  	.get(chat.find_certain_location);

  app.route('/notifyDriver')
  .post(chat.notify_driver);

  app.route('/changeUserStatus')
    .post(chat.change_user_status)
    .delete(chat.delete_user_status)
    .get(chat.get_user_status)

};