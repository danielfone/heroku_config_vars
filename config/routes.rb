HerokuConfigVars::Engine.routes.draw do
  resource :heroku_app
  get :env, to: 'application#env'
  root to: 'heroku_apps#show'
end
