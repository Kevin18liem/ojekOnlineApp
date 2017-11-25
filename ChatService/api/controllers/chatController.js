'use strict';

var mongoose = require('mongoose');
var Token = mongoose.model('Token');
var Chat = mongoose.model('Chat');
var Pair = mongoose.model('Pair');
var userSchema = mongoose.model('userSchema');
var admin = require("firebase-admin");
var url = require('url');

var serviceAccount = require("../../mavericks-d5625-firebase-adminsdk-8bqax-8293dbfcc8.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://mavericks-d5625.firebaseio.com"
}); 

exports.send_chat = function(req, res){
	var new_chat = new Chat(req.body);
	new_chat.save(function(err, new_chat){
		if(err) return console.error(err);
		new_chat.validate_saved();
		var registrationToken = new_chat.fcmToken;
		var payload = {
		  data: {
		    score: new_chat.message,
		    time: "2:45"
		  }
		};
		// // Send a message to the device corresponding to the provided
		// // registration token.
		admin.messaging().sendToDevice(registrationToken, payload)
		  .then(function(response) {
		    // See the MessagingDevicesResponse reference documentation for
		    // the contents of response.
		    console.log("Successfully sent message:", response);
		  })
		  .catch(function(error) {
		    console.log("Error sending message:", error);
		  });
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

exports.change_driver_status = function(req, res) {
	var new_token = new Token(req.body);
	new_token.save(function(err, new_token) {
		if (err) return console.error(err);
		res.send('Driver Status Online');
	});
};

exports.set_driver_status_offline = function(req, res){
	var new_token = new Token(req.body);
	var conditions = { name: new_token.name }
  		, update = { $set: { status: "offline" }}
  		, options = { multi: true };

	Token.update(conditions, update, options, function(err, new_token){
		if(err) return console.error(err);
		res.send('Updated');
	});
}

exports.delete_driver_status = function(req, res) {
	var new_token = new Token(req.body);
	Token.remove({name : new_token.name}, function(err, new_token) {
		if (err) return console.error(err);
		res.send('Driver Status Offline')
	});
};

exports.delete_all_driver = function(req, res) {
  Token.remove({}, function(err, Token) {
    if (err)
      res.send(err);
    res.send('All driver deleted');
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
	//var parts = url.parse(req.url, true);
  	//var query = parts.query;

	var new_token = new Token(req.query);
	console.log(new_token.location[0]);
	console.log(new_token.location[1]);
	Token.find({$or:[{location: {$in: [new_token.location[0]]}},{location: {$in: [new_token.location[1]]}}]}, function(err, new_token){
		if(err)
			res.send(err);
		res.send(JSON.stringify(new_token));
		console.log(new_token);
	});
};


exports.notify_driver = function(req,res) {
	var newToken = new Token(req.body);
	var registrationToken = "eH1VjRihORg:APA91bF99ZOuk-i0YoOCgOhxFQXjbaBBic0BqvTDG6g1okVHj5AZjlc7clmuXpNnKph07HZM-CAtaLXbPs1IKXYfU87_fuzhx0YT7PaZrNniwWEcHcTnDVk-yuPmQVQjJadct0o6xakn";
	var payload = {
	  data: {
	    score: "Move to Chat",
	    time: "2:45"
	  }
	};
	// // Send a message to the device corresponding to the provided
	// // registration token.
	admin.messaging().sendToDevice(registrationToken, payload)
	  .then(function(response) {
	    // See the MessagingDevicesResponse reference documentation for
	    // the contents of response.
	    console.log("Successfully sent message:", response);
	  })
	  .catch(function(error) {
	    console.log("Error sending message:", error);
	  });
	res.send('Saved');
}

exports.change_user_status = function(req, res) {
	var new_token = new userSchema(req.body);
	new_token.save(function(err, new_token) {
		if (err) return console.error(err);
		res.send('Status User Online');
	});
};

exports.delete_user_status = function(req, res) {
	var new_token = new userSchema(req.body);
	Token.remove({name : new_token.name}, function(err, new_token) {
		if (err) return console.error(err);
		res.send('Status User Offline')
	});
};

exports.get_user_status = function(req, res) {
	var user_status = new userSchema(req.body);
	Token.find({token: user_status.token}, function(err, user_status) {
		if(err)
			res.send(err);
		res.json(user_status);
	});
};