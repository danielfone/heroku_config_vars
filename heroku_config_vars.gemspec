$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "heroku_config_vars/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "heroku_config_vars"
  s.version     = HerokuConfigVars::VERSION
  s.authors     = ["Daniel Fone"]
  s.email       = ["daniel@fone.net.nz"]
  s.homepage    = "https://github.com/danielfone/heroku_config_vars"
  s.summary     = "Engine to manage Heroku configuration variables from within your application"
  s.description = s.summary

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]

  s.add_runtime_dependency 'rails', '>= 3.1'
  s.add_runtime_dependency 'sass-rails'
  s.add_runtime_dependency 'heroku-api', '~> 0.3'

  s.add_development_dependency 'rspec-rails', '~> 2.14.0'
  s.add_development_dependency 'webmock', '~> 1.17.0'
  s.add_development_dependency 'capybara', '~> 2.2.0'
  s.add_development_dependency 'coveralls', '~> 0.7.0'
  s.add_development_dependency 'appraisal', '~> 0.5.2'
end
