require 'spec_helper'

module HerokuConfigVars
  describe HerokuApp do
    subject(:app) { described_class.new args }

    let(:args) { Hash.new } 

    stub_heroku_responses

    describe '::find' do
      subject { described_class.find }

      context 'without ENV set' do
        before do
          ENV.delete 'HEROKU_APP_NAME'
          ENV.delete 'HEROKU_API_KEY'
        end

        it { should be_a_kind_of HerokuApp }
        its(:app_name) { should be_nil }
        its(:api_key) { should be_nil }

        specify('no request made') do
          expect(a_request :any, "api.heroku.com").not_to have_been_made
        end
      end

      context 'with valid ENV set' do
        setup_app

        it { should be_a_kind_of HerokuApp }
        it { should be_loaded }

        its(:api_key) { should eq valid_api_key }
        its(:app_name) { should eq valid_app_name }        
      end

    end

    context 'with no args' do

      it { should_not be_valid }
      it { should have(1).error_on(:app_name) }
      it { should have(1).error_on(:api_key) }
      it { should_not be_loaded }
      its(:vars) { should be_empty }
    end

    context 'with valid credentials' do
      let(:args) do
        {
          :api_key  => valid_api_key,
          :app_name => valid_app_name,
        }
      end

      it { should be_valid }
      it { should_not be_loaded }
      its(:vars) { should include 'HEROKU_APP_NAME' }
      its(:vars) { should include 'HEROKU_API_KEY' }
    end


    describe '#attributes=' do
      before { app.attributes = {:api_key => 'foo'} }

      its(:api_key) { should eq 'foo' }
    end

    describe '#load_vars' do
      before { app.load_vars }

      context 'with non-existent app name' do
        let(:args) do
          { app_name: 'xxx', api_key: valid_api_key }
        end

        its(:errors) { should have_key :app_name }
      end

      context 'with unauthorized app name' do
        let(:args) do
          { app_name: other_app_name, api_key: valid_api_key }
        end

        its(:errors) { should have_key :app_name }
      end

      context 'with invalid api key' do
        let(:args) do
          { app_name: valid_app_name, api_key: 'xxx' }
        end

        its(:errors) { should have_key :api_key }
      end

      context 'when heroku is down'
    end

    describe '#save'

  end
end
