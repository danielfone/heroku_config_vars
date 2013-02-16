HerokuConfigVars::Engine.routes.draw do
  resource :heroku_app
  match :env, to: 'application#env'
  root to: 'heroku_apps#show'
end
