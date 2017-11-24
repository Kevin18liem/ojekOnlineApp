'use strict';

var mongoose = require('mongoose');
var Token = mongoose.model('Token');
var Chat = mongoose.model('Chat');
var Pair = mongoose.model('Pair');

exports.send_chat = function(req, res){
	var new_chat = new Chat(req.body);
	new_chat.save(function(err, new_chat){
		if(err) return console.error(err);
		new_chat.validate_saved();
		res.send('Saved');
	});
};

exports.list_all_chat = function(req, res) {
  Chat.find({}, function(err, Chat) {
    if (err)
      res.send(err);
    res.json(Chat);
  });
};

exports.find_certain_chat = function(req, res, next) {
	var temp = new Pair(req.body);
	console.log(temp.sender);
	console.log(temp.receiver);
	Chat.find({$or:[{sender : temp.sender , receiver : temp.receiver},{sender : temp.receiver , receiver : temp.sender}]},function(err, Chat){
		if(err)
			res.send(err);
		res.json(Chat);
	});
};

exports.delete_all_chat = function(req, res){
	Chat.remove({}, function(err, Chat){
		if(err)
			res.send(err);
		res.send("All chat deleted");
	});	
};