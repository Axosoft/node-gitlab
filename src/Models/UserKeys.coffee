BaseModel = require '../BaseModel'

class UserKeys extends BaseModel
  all: (userId, fn = null) =>
    @get "users/#{parseInt userId}/keys", fn

  allForCurrentUser: (fn = null) =>
    @get "/user/keys", fn

  addKey: (userId, title, key, fn = null) =>
    params =
      title: title
      key: key

    @post "users/#{userId}/keys", params, fn

  addKeyForCurrentUser: (title, key, fn = null) =>
    params =
      title: title
      key: key

    @post "user/keys", params, fn

  deleteKey: (userId, keyId, fn = null) =>
    @delete "/users/#{userId}/keys/#{keyId}", fn

  deleteKeyForCurrentUser: (keyId, fn = null) =>
    @delete "user/keys/#{keyId}", fn

module.exports = (client) -> new UserKeys client
