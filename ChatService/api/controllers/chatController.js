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

exports.find_certain_chat = function(req, res) {
	var temp = new Pair(req.body);
	console.log(temp.sender);
	console.log(temp.receiver);
	Chat.find({sender : temp.sender , receiver : temp.receiver},function(err, Chat){
		if(err)
			res.send(err);
		res.json(Chat);
	});
};

exports.change_driver_status = function(req, res) {
	var new_token = new Token(req.body);
	new_token.save(function(err, new_token) {
		if (err) return console.error(err);
		res.send('Driver Status Online');
	});
};

exports.delete_driver_status = function(req, res) {
	var new_token = new Token(req.body);
	Token.remove({name : new_token.name}, function(err, new_token) {
		if (err) return console.error(err);
		res.send('Driver Status Offline')
	});
};

exports.list_all_driver = function(req, res) {
  Token.find({}, function(err, Token) {
    if (err)
      res.send(err);
    res.json(Token);
  });
};

exports.find_certain_location = function(req, res) {
	var new_token = new Token(req.body);
	Token.find({location: {$in: [new_token.location]}}, function(err, new_token){
		if(err)
			res.send(err);
		res.json(new_token);
	});
};