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
};