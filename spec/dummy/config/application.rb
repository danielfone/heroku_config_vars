require File.expand_path('../boot', __FILE__)
require "action_controller/railtie"
require "heroku_config_vars"

module Dummy
  class Application < Rails::Application

    # Dummy secrect token
    config.secret_token = 'x' * 30

    # The test environment is used exclusively to run your application's
    # test suite. You never need to work with it otherwise. Remember that
    # your test database is "scratch space" for the test suite and is wiped
    # and recreated between test runs. Don't rely on the data there!
    config.cache_classes = true

    # Log error messages when you accidentally call methods on nil
    config.whiny_nils = true

    # Show full error reports and disable caching
    config.consider_all_requests_local       = true
    config.action_controller.perform_caching = false

    # Raise exceptions instead of rendering exception templates
    config.action_dispatch.show_exceptions = false

    # Print deprecation notices to the stderr
    config.active_support.deprecation = :stderr

    I18n.enforce_available_locales = false

    HerokuConfigVars.authorization_method = :heroku_config_auth?
  end
end

