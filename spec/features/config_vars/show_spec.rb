require 'spec_helper'

feature "Show heroku config vars" do

### TODO: extract into helper
  let(:valid_app_name) { 'valid_app_name' }
  let(:valid_api_key)  { 'valid_api_key' }
  let(:valid_auth)     { 'Basic ' << Base64::strict_encode64(':' << valid_api_key) }
  let(:live_vars)      { Hash.new }


  before do
    stub_request(:get, "https://api.heroku.com/apps/#{valid_app_name}/config_vars").
      with(headers: { 'Authorization' => valid_auth }).
      to_return(body: live_vars.to_json)
  end

###

  before do
    ENV['HEROKU_APP_NAME'] = valid_app_name
    ENV['HEROKU_API_KEY']  = valid_api_key
  end

  after do
    ENV.delete 'HEROKU_APP_NAME'
    ENV.delete 'HEROKU_API_KEY'
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
  end
end
