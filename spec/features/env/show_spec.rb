require 'spec_helper'

feature "Show ENV" do

  before do
    ENV['FOO'] = 'bar'
  end

  scenario "Visit env path" do
    visit heroku_config_vars.env_url(protocol: 'https')

    expect(page).to have_selector 'h2', text: 'ENV'
    expect(page).to have_selector 'th', text: 'FOO'
    expect(page).to have_selector 'td', text: 'bar'
  end
end
