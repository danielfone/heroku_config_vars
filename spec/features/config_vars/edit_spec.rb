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

  # TODO: move most of this into a view spec
  scenario 'Vist the edit page' do
    visit heroku_config_vars.edit_heroku_app_url(protocol: 'https')

    within 'h2' do
      expect(page).to have_link valid_app_name, href: heroku_config_vars.heroku_app_path
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
    expect(page).to have_link 'Cancel', href: heroku_config_vars.heroku_app_path
  end

## ----

  let(:set_vars) do
    {
      "VAR2" => "value 2 updated",
      "NEW_KEY" => "a new value"
    }
  end

  let(:delete_var) { 'VAR1' }

  def visit_form
    visit heroku_config_vars.heroku_app_url(protocol: 'https')
    click_link 'Edit'
  end

  def cancel
    click_link 'Cancel'
  end

  def fill_out_form
    fill_in 'VAR2', with: 'value 2 updated'
    within 'tr:first' do |variable|
      check 'Delete'
    end
    fill_in 'add[][key]',   with: 'NEW_KEY'
    fill_in 'add[][value]', with: 'a new value'
    click_button 'Prepare...'
    # expect the changes to displayed
  end

  def confirm
    click_button 'Update and restart app'
    # expect the vars to be updated
  end

  scenario 'Cancel update' do
    visit_form
    cancel

    expect(current_path).to eq heroku_config_vars.heroku_app_path
  end

  scenario 'Update vars and confirm' do
    visit_form
    fill_out_form
    confirm

    expect(current_path).to eq heroku_config_vars.edit_heroku_app_path
  end

  scenario 'Update vars and cancel' do
    visit_form
    fill_out_form
    cancel

    expect(current_path).to eq heroku_config_vars.edit_heroku_app_path
  end

end
