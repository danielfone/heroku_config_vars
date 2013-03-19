require 'heroku-api'
require "heroku_config_vars/engine"

module HerokuConfigVars
  mattr_accessor :authorization_method
  self.authorization_method = :heroku_config_vars_authorized?
end
