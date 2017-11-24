'use strict';
module.exports = function(app) {
  var chat = require('../controllers/chatController');

  // todoList Routes
  app.route('/sendChat')
    .post(chat.send_chat);

  app.route('/listAllChat')
  	.get(chat.list_all_chat);

  app.route('/findCertainChat')
  	.post(chat.find_certain_chat);

  app.route('/changeDriverStatus')
  	.post(chat.change_driver_status)
  	.delete(chat.delete_driver_status);

  app.route('/listAllDriver')
  	.get(chat.list_all_driver);

  app.route('/findCertainLocation')
  	.post(chat.find_certain_location);
};