Rails.application.routes.draw do
  mount HerokuConfigVars::Engine => "/heroku_config_vars"
end
