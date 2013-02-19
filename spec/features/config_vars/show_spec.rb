require 'spec_helper'

feature "Show heroku config vars" do

  stub_heroku_responses

  before do
    ENV['HEROKU_APP_NAME'] = valid_app_name
    ENV['HEROKU_API_KEY']  = valid_api_key
  end

  let(:live_vars) do
    {
      'VAR3' => 'value 3',
      'VAR2' => 'value 2',
      'VAR1' => 'value 1',
      'VAR4' => 'value 4'
    }
  end

  scenario "Visit vars path" do
    visit heroku_app_url(protocol: 'https')

    expect(page).to have_selector 'h2', text: valid_app_name

    expect(page).to have_selector 'tr:nth(1) th', text: 'VAR1'
    expect(page).to have_selector 'tr:nth(1) td', text: 'value 1'

    expect(page).to have_selector 'tr:nth(2) th', text: 'VAR2'
    expect(page).to have_selector 'tr:nth(2) td', text: 'value 2'

    expect(page).to have_selector 'tr:nth(3) th', text: 'VAR3'
    expect(page).to have_selector 'tr:nth(3) td', text: 'value 3'

    expect(page).to have_selector 'tr:nth(4) th', text: 'VAR4'
    expect(page).to have_selector 'tr:nth(4) td', text: 'value 4'

    expect(page).to have_link 'Edit', href: edit_heroku_app_path

    # check for menu
    expect(page).to have_selector 'li', text: 'Heroku Configuration Variables'
  end
end
