TODO

## Setup

1. gem 'heroku_config_vars'
2. mount engine
3. Implement:
  def heroku_config_authorized?
    current_user.admin?
  end
4. Visit /whatever and enter your heroku details