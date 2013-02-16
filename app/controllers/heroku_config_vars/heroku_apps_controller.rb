module HerokuConfigVars
  class HerokuAppsController < ApplicationController

    before_filter :require_heroku_app, :only => [:show, :edit, :update]

    private

      def require_heroku_app
        redirect_to new_heroku_app_path unless heroku_app && heroku_app.loaded?
      end

      def heroku_app
        @heroku_app ||= HerokuApp.find
      end

  end
end
