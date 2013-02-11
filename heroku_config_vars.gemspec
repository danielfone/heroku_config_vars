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
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.0"
end
