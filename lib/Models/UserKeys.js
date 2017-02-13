(function() {
  var BaseModel, UserKeys,
    bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    hasProp = {}.hasOwnProperty;

  BaseModel = require('../BaseModel');

  UserKeys = (function(superClass) {
    extend(UserKeys, superClass);

    function UserKeys() {
      this.deleteKeyForCurrentUser = bind(this.deleteKeyForCurrentUser, this);
      this.deleteKey = bind(this.deleteKey, this);
      this.addKeyForCurrentUser = bind(this.addKeyForCurrentUser, this);
      this.addKey = bind(this.addKey, this);
      this.allForCurrentUser = bind(this.allForCurrentUser, this);
      this.all = bind(this.all, this);
      return UserKeys.__super__.constructor.apply(this, arguments);
    }

    UserKeys.prototype.all = function(userId, fn) {
      if (fn == null) {
        fn = null;
      }
      return this.get("users/" + (parseInt(userId)) + "/keys", fn);
    };

    UserKeys.prototype.allForCurrentUser = function(fn) {
      if (fn == null) {
        fn = null;
      }
      return this.get("/user/keys", fn);
    };

    UserKeys.prototype.addKey = function(userId, title, key, fn) {
      var params;
      if (fn == null) {
        fn = null;
      }
      params = {
        title: title,
        key: key
      };
      return this.post("users/" + userId + "/keys", params, fn);
    };

    UserKeys.prototype.addKeyForCurrentUser = function(title, key, fn) {
      var params;
      if (fn == null) {
        fn = null;
      }
      params = {
        title: title,
        key: key
      };
      return this.post("user/keys", params, fn);
    };

    UserKeys.prototype.deleteKey = function(userId, keyId, fn) {
      if (fn == null) {
        fn = null;
      }
      return this["delete"]("/users/" + userId + "/keys/" + keyId, fn);
    };

    UserKeys.prototype.deleteKeyForCurrentUser = function(keyId, fn) {
      if (fn == null) {
        fn = null;
      }
      return this["delete"]("user/keys/" + keyId, fn);
    };

    return UserKeys;

  })(BaseModel);

  module.exports = function(client) {
    return new UserKeys(client);
  };

}).call(this);
