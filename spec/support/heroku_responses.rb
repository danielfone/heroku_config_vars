module HerokuResponses
  module ClassMethods

    def stub_heroku_responses
      let(:valid_app_name) { 'valid_app_name' }
      let(:valid_api_key)  { 'valid_api_key' }
      let(:valid_auth)     { 'Basic ' << Base64::strict_encode64(':' << valid_api_key) }
      let(:live_vars)      { {"HEROKU_APP_NAME" => valid_app_name, "HEROKU_API_KEY" => valid_api_key } }

      before do
        stub_request(:get, "https://api.heroku.com/apps/#{valid_app_name}/config_vars").
          with(headers: { 'Authorization' => valid_auth }).
          to_return(body: live_vars.to_json)

        stub_request(:put, "https://api.heroku.com/apps/#{valid_app_name}/config_vars").
          with(headers: { 'Authorization' => valid_auth }).
          with(body: live_vars.to_json).
          to_return(:status => 200, :body => "", :headers => {})
      end
    end

    def setup_app
      before do
        ENV['HEROKU_APP_NAME'] = valid_app_name
        ENV['HEROKU_API_KEY']  = valid_api_key
      end
    end
  end
end
