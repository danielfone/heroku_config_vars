module HerokuConfigVars
  class HerokuAppsController < HerokuConfigVars::ApplicationController

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

    def update
      vars = params[:heroku_app][:vars]
      vars.merge! hashify_new_vars
      vars.except! *params[:remove].keys if params[:remove]
      heroku_app.vars = vars
      return render :confirmation unless params[:confirmation]
      if heroku_app.save
        redirect_to edit_heroku_app_path, notice: 'Configuration updated'
      else
        heroku_app.load_vars
        render :edit
      end
    end

    private

      def require_heroku_app
        redirect_to new_heroku_app_path unless heroku_app && heroku_app.loaded?
      end

      def heroku_app
        @heroku_app ||= HerokuApp.find
      end

      def hashify_new_vars
        {}.tap do |vars|
          params[:add].each {|h| vars.store h['key'], h['value'] if h['key'].present? } if params[:add]
        end
      end

  end
end
