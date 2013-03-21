# HerokuConfigVars

[![Build Status](https://travis-ci.org/danielfone/heroku_config_vars.png?branch=master)](https://travis-ci.org/danielfone/heroku_config_vars)
[![Dependency Status](https://gemnasium.com/danielfone/heroku_config_vars.png)](https://gemnasium.com/danielfone/heroku_config_vars)


This engine allows you to manage Heroku configuration variables from within your application.

## Installation into your application

1. Add `gem 'heroku_config_vars'` to your Gemfile
2. Add `mount HerokuConfigVars::Engine => "/heroku_config_vars"` to your routes.rb
3. Implement the method `:heroku_config_vars_authorized?` on your ApplicationController. (See [Customization](#customization))
4. To make authorization easy, this engine inherits from your ApplicationController.
This means that you may have to change named routes to be more specific. e.g.

```diff
 class ApplicationController < ActionController::Base
     before_filter :authenticate

     def authenticate
-      redirect_to new_session_path unless logged_in?
+      redirect_to main_app.new_session_path unless logged_in?
     end
 end
```

## Setup

1. Deploy your app to Heroku
2. Visit /heroku_config_vars
3. Enter valid Heroku credentials for your application.
   These are stored in the Heroku configuration for this application so you don't need to enter them again.

## Usage

With this engine you can:

* View the complete ruby ENV hash
* View the Heroku configuration
* Update, add and delete Heroku configuration variables


## Customization

You can change the path to the engine by changing the line in your routes.rb

```ruby
# config/routes.rb
mount HerokuConfigVars::Engine => "/whatever_path_you_like"`
```

You can also change the name of the authorization method to call on ApplicationController.
You may wish to do this if you already have an appropriate authorization method defined. e.g.

```ruby
# config/initializers/heroku_config_vars.rb
HerokuConfigVars.authorization_method = :admin_logged_in?
```

A typical implementation of this method might look like:

```ruby
class ApplicationController < ActionController::Base
  ...
  def heroku_config_vars_authorized?
    current_user && current_user.admin?
  end
  ...
end
```
