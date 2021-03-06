require 'spec_helper'

feature "Requires admin" do

  scenario 'non-admin user visits' do
    expect {
      visit heroku_config_vars.root_url protocol: 'https', admin: false
    }.to raise_error ActionController::RoutingError
  end

end
