const discord = require('discord.js');

exports.getName = function(channel) {
  return function() {
    return channel.name;
  }
};