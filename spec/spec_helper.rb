# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

require 'coveralls'
Coveralls.wear! 'rails'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require 'rspec/rails'
require 'webmock/rspec'
require 'capybara/rspec'

Rails.backtrace_cleaner.remove_silencers!

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  config.expect_with :rspec do |c|
    # Disable old-style `should` syntax
    c.syntax = :expect
  end

  config.extend HerokuResponses::ClassMethods

  config.after do
    ENV.delete 'HEROKU_APP_NAME'
    ENV.delete 'HEROKU_API_KEY'
  end
end
