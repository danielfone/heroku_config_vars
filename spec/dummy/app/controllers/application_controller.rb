class ApplicationController < ActionController::Base
  protect_from_forgery

  def heroku_config_authorized?
    params[:admin] != 'false'
  end

end
