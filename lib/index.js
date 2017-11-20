(function() {
  var ApiV4;

  ApiV4 = require('./ApiV4').ApiV4;

  module.exports = function(options) {
    return new ApiV4(options);
  };

  module.exports.ApiV4 = ApiV4;

}).call(this);
