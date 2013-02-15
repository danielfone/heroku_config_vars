require 'spec_helper'

feature "Suggests SSL" do

  scenario "Switch to secure connection" do
    visit heroku_config_vars_path protocol: 'http'
    click_link 'Switch to secure connection'

    expect(current_url).to start_with 'https'
    expect(current_path).to start_with heroku_config_vars_path
  end

  scenario 'Remain insecure' do
    visit heroku_config_vars_path protocol: 'http'
    click_link 'Continue insecurely'

    expect(current_url).to start_with 'http'
    expect(current_path).to start_with heroku_config_vars_path

    # Make sure our insecure choice is remembered
    visit heroku_config_vars_path protocol: 'http'

    expect(current_url).to start_with 'http'
    expect(page).not_to have_link 'Continue insecurely'
  end


end
