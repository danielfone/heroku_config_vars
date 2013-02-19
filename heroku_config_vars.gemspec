$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "heroku_config_vars/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "heroku_config_vars"
  s.version     = HerokuConfigVars::VERSION
  s.authors     = ["Daniel Fone"]
  s.email       = ["daniel@fone.net.nz"]
  s.homepage    = "https://github.com/danielfone/heroku-config-vars"
  s.summary     = "Engine to manage Heroku configuration variables from within your application"
  s.description = s.summary

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 3.2.0"
  s.add_dependency "heroku-api", "~> 0.3.0"

  s.add_development_dependency "rspec-rails", "~> 2.12.0"
  s.add_development_dependency 'webmock', '~> 1.9.0'
  s.add_development_dependency 'capybara', '~> 2.0.0'
  s.add_development_dependency 'launchy', '~> 2.2.0'
  s.add_development_dependency 'sass-rails', '~> 3.2.0' # TODO: get rid of this
end
