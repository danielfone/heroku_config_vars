require 'spec_helper'

module HerokuConfigVars
  describe HerokuApp do
    describe '::find' do
      subject { described_class.find }

      context 'without ENV set' do
        before { %w(HEROKU_APP_NAME HEROKU_API_KEY).each { |key| ENV.delete key } }

        it { should be_a_kind_of HerokuApp }
        it { should_not be_loaded }
        it { should_not be_valid }
        it { should have(1).error_on(:app_name) }
        it { should have(1).error_on(:api_key) }
      end

      context 'with a valid ENV' do
        before do
          ENV['HEROKU_APP_NAME'] = 'valid-app-name'
          ENV['HEROKU_API_KEY']  = 'valid-api-key'
        end

        it { should be_a_kind_of HerokuApp }
        it { puts subject.to_yaml; should be_loaded }

        its(:vars) { should be_present }
        its(:api_key) { should eq 'valid-api-key'}
        its(:app_name) { should eq 'valid-app-name'}
        its(:errors) { should be_blank }
      end

      context 'with an invalid ENV' do
        
      end
    end
  end
end
