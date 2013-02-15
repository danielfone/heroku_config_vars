require 'spec_helper'

feature "Show full ENV" do

  before do
    ENV['FOO'] = 'bar'
  end

  scenario "Visit env path" do
    visit env_url(protocol: 'https')

    expect(page).to have_text 'ENV'
    expect(page).to have_text 'FOO'
    expect(page).to have_text 'bar'
  end
end
