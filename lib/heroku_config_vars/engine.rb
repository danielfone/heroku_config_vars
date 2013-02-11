module HerokuConfigVars
  class Engine < ::Rails::Engine
    isolate_namespace HerokuConfigVars
  end
end
