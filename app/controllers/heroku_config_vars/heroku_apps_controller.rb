module HerokuConfigVars
  class HerokuAppsController < ApplicationController

    before_filter :require_heroku_app, :only => [:show, :edit, :update]

    def new
      @heroku_app = HerokuApp.find
    end

    def create
      @heroku_app = HerokuApp.new params[:heroku_app]
      if @heroku_app.save
        redirect_to heroku_app_path
      else
        render :new
      end
    end

    private

      def require_heroku_app
        redirect_to new_heroku_app_path unless heroku_app && heroku_app.loaded?
      end

      def heroku_app
        @heroku_app ||= HerokuApp.find
      end

  end
end
