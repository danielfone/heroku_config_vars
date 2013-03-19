module HerokuConfigVars
  class ApplicationController < ActionController::Base

    before_filter :recommend_https, :if => :insecure?
    before_filter :require_authenticated

    def env
      @env = ENV
    end

  private

    def require_authenticated
      # raising RoutingError will render 404 in production
      if not HerokuConfigVars.authorization_block.respond_to? :call
        raise ActionController::RoutingError.new <<-ERROR.strip_heredoc
          No authorization block provided. e.g.

          # config/initializers/heroku_config_vars.rb

          # This is evaluated in the context of the controller
          HerokuConfigVars.authorize do
            user = User.find(session[:user_id]) and user.admin?
          end
        ERROR
      elsif not instance_exec &HerokuConfigVars.authorization_block
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
