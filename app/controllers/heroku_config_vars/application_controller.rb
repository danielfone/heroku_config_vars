module HerokuConfigVars
  class ApplicationController < ::ApplicationController

    before_filter :require_authenticated
    before_filter :recommend_https, :if => :insecure? 

    layout 'heroku_config_vars/application'

    def env
      @env = ENV
    end

  private

    def require_authenticated
      # raising RoutingError will render 404 in production
      if not respond_to? HerokuConfigVars.authorization_method, true
        raise ActionController::RoutingError.new <<-ERROR.strip_heredoc
          `#{HerokuConfigVars.authorization_method}` must be implemented in ApplicationController and return true for authorized users.
          
           e.g.
           class ApplicationController < ActionController::Base
             ...
             
             def #{HerokuConfigVars.authorization_method}
               current_user.admin?
             end
             
             ...
           end

           You can change the name of this method. e.g.
           
           # config/initializers/heroku_config_vars.rb
           HerokuConfigVars.authorization_method = :my_other_auth?
           
        ERROR
      elsif not send HerokuConfigVars.authorization_method
        raise ActionController::RoutingError.new "Authorisation block returned false"
      end
    end


    def recommend_https
      render :recommend_https
    end

    def insecure?
      not request.ssl? and (session[:insecure] ||= params[:insecure]) != 'ok'
    end
  end
end
