const discord = require('discord.js');

exports._fetch = function() {
  /**
   * @param {discord.BaseManager} manager
   * @param {String} id
   */
  return function(manager, id) {
    return function() {
      return manager.fetch(id);
    }
  };
};
exports._cache = function() {
  /**
   * @param {discord.BaseManager} manager 
   */
  return function(manager) {
    return function() {
      return manager.cache;
    };
  };
};