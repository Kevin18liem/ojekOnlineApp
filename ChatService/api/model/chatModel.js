'use strict';
var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var TokenSchema = new Schema({
  name: {
    type: String
  },
  token: {
    type: String
  }
});

var ChatSchema = new Schema({
  sender: {
    type: String
  },
  receiver : {
    type: String
  },
  chat_date: {
    type: Date,
    default: Date.now
  },
  message: {
    type: String,
    required: 'Message can not be empty'
  }
});

ChatSchema.methods.validate_saved = function(){
  var messageSaved = this.message
    ? this.message + " is saved"
    : "Empty message";
  console.log(messageSaved);
}

var PairSchema = new Schema({
  sender: {
    type: String
  },
  receiver: {
    type: String
  }
});

module.exports = mongoose.model('Token', TokenSchema);
module.exports = mongoose.model('Chat', ChatSchema);
module.exports = mongoose.model('Pair', PairSchema);