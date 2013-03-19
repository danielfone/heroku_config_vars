class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :break_inheritance

  protected

    def heroku_config_auth?
      params[:admin] != 'false'
    end

  private

    def break_inheritance
      main_app.widgets_path
    end

end
