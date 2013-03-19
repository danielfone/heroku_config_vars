class ApplicationController < ActionController::Base
  protect_from_forgery

  # Don't inherit from ::ApplicationController, we don't control this code
  before_filter :break_inheritance

  private

    def break_inheritance
      raise 'foo'
    end

end
