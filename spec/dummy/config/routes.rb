Rails.application.routes.draw do

  resources :widgets

  mount HerokuConfigVars::Engine => "/heroku_config_vars"

end
