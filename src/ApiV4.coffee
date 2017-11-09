debug = require('debug') 'gitlab:ApiV4'
{ApiBaseHTTP} = require './ApiBaseHTTP'

class module.exports.ApiV4 extends ApiBaseHTTP
  handleOptions: =>
    super
    @options.base_url = 'api/v4'
    debug "handleOptions()"
