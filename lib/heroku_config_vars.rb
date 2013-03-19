require 'heroku-api'
require "heroku_config_vars/engine"

module HerokuConfigVars

  def self.authorize(&block)
    self.authorization_block = block
  end

  private

    mattr_accessor :authorization_block

end
