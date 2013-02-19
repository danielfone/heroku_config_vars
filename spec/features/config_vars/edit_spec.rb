require 'spec_helper'

feature 'Edit Herkou configuration' do

  stub_heroku_responses
  setup_app

  scenario 'Click edit link' do
    visit heroku_app_url(protocol: 'https')
    click_link 'Edit'

    expect(current_path).to eq edit_heroku_app_path
  end

end
