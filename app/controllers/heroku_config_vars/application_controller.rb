module HerokuConfigVars
  class ApplicationController < ActionController::Base

    before_filter :recommend_https, :if => :insecure?

    def env
      @env = ENV
    end

    protected


    private

      def recommend_https
        render :recommend_https
      end

      def insecure?
        not request.ssl? and (session[:insecure] ||= params[:insecure]) != 'ok'
      end

  end
end
