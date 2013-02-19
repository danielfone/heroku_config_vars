require 'spec_helper'

feature 'Edit Herkou configuration' do

  stub_heroku_responses
  setup_app

  let(:live_vars) do
    {
      'VAR3' => 'value 3',
      'VAR2' => 'value 2',
      'VAR1' => 'value 1',
      'VAR4' => 'value 4'
    }
  end

  scenario 'Click edit link' do
    visit heroku_app_url(protocol: 'https')
    click_link 'Edit'

    expect(current_path).to eq edit_heroku_app_path
  end

  scenario 'Vist the edit page' do
    visit edit_heroku_app_url(protocol: 'https')

    within 'h2' do
      expect(page).to have_link valid_app_name, href: heroku_app_path
      expect(page).to have_text "Edit Configuration"
    end

    (1..4).each do |i|
      within "tr:nth(#{i})" do
        expect(page).to have_selector 'th', text: "VAR#{i}"
        expect(page).to have_field "VAR#{i}", with: "value #{i}"
        expect(page).to have_unchecked_field 'Delete'
      end      
    end

    within 'tr:last' do
      expect(page).to have_field 'add[][key]'
      expect(page).to have_field 'add[][value]'
    end

    expect(page).to have_button 'Prepare...'
    expect(page).to have_link 'Cancel', href: heroku_app_path
  end

end
