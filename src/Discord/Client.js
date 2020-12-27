const discord = require('discord.js');

exports.mkClient = function() {
  const client = new discord.Client();
  return client;
};

/**
 * @param {discord.Client} client 
 */
exports.getChannels = function(client) {
  return function() {
    return client.channels;
  };
};

/**
 * @param {discord.Client} client 
 * @param {String} token
 */
exports._login = function(client, token) {
  return function() {
    client.login(token);
  };
};