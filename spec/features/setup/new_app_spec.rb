require 'spec_helper'

feature 'New app' do

  stub_heroku_responses

  scenario 'Visit root without ENV set' do
    visit root_url(protocol: 'https')

    expect(current_path).to eq new_heroku_app_path
  end

  scenario 'Visit new heroku app path' do
    visit new_heroku_app_url(protocol: 'https')

    expect(page).to have_selector 'h2', text: 'One Time Setup'
    expect(page).to have_field 'App Name'
    expect(page).to have_field 'API Key'
  end

  scenario 'Submit blank form' do
    visit new_heroku_app_url(protocol: 'https')
    click_button 'Save'

    expect(page).to have_selector 'li', text: "App name can't be blank"
    expect(page).to have_selector 'li', text: "Api key can't be blank"
  end

  scenario 'Submit valid form' do
    visit new_heroku_app_url(protocol: 'https')
    fill_in 'App Name', with: valid_app_name
    fill_in 'API Key', with: valid_api_key
    click_button 'Save'

    expect(page).to have_selector 'h2', text: valid_app_name
    expect(current_path).to eq heroku_app_path
  end

end
