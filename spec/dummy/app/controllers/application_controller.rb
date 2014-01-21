class ApplicationController < ActionController::Base

protected

  def heroku_config_auth?
    params[:admin] != 'false'
  end

end
