module HerokuConfigVars
  class HerokuApp
    extend ActiveModel::Naming
    include ActiveModel::Conversion
    include ActiveModel::Validations

    attr_accessor :vars

    attr_reader :loaded
    attr_reader :current_vars

    alias_method :loaded?,    :loaded
    alias_method :persisted?, :loaded

    validates_presence_of :app_name
    validates_presence_of :api_key

    def self.find
      attrs = {
        app_name: ENV['HEROKU_APP_NAME'],
        api_key:  ENV['HEROKU_API_KEY']
      }

      new(attrs) do |app|
        app.load_vars if app.valid?
      end
    end

    def initialize(attrs={})
      @vars = {}
      @current_vars = {}
      @loaded = false

      self.attributes = attrs

      yield self if block_given?
    end

    def attributes=(attrs={})
      attrs.each do |key, value|
        self.send "#{key}=", value
      end
    end

    def app_name
      @app_name ||= @vars['HEROKU_APP_NAME'].presence
    end

    def app_name=(value)
      @app_name = @vars['HEROKU_APP_NAME'] = value
    end

    def api_key
      @api_key ||= @vars['HEROKU_API_KEY'].presence
    end

    def api_key=(value)
      @api_key = @vars['HEROKU_API_KEY'] = value
    end

    def load_vars
      catch_heroku_errors do
        Rails.logger.debug 'Loading config'
        @vars = connection.get_config_vars(app_name).body
        @current_vars = @vars.dup.freeze
        @loaded = true
      end
    end

    def save
      save_to_heroku and save_to_env if valid?
    end

    def removed_vars
      current_vars ? current_vars.except(*vars.keys) : {}
    end

    def added_vars
      vars.except *current_vars.keys
    end

    def kept_vars
      current_vars.slice *vars.keys
    end

    def updated_vars
      changes.slice(*kept_vars.keys)
    end

    def updated_and_added_vars
      changes.slice(*vars.keys)
    end

    def changes
      @changes ||= vars.diff current_vars
    end

    private

      def connection
        Heroku::API.new api_key: api_key
      end

      def catch_heroku_errors
        Rails.logger.debug "Connecting to Heroku"
        begin
          yield
        rescue Heroku::API::Errors::Unauthorized => e
          errors.add :api_key, "is invalid (#{e.class.name})"
        rescue Heroku::API::Errors::Forbidden, Heroku::API::Errors::NotFound => e
          errors.add :app_name, "is invalid (#{e.class.name})"
        rescue Heroku::API::Errors::RequestFailed => e
          errors.add :base, "Request failed: " << e.response.body
        end
        errors.blank?
      end

      def save_to_heroku
        Rails.logger.debug 'Updating config'
        catch_heroku_errors { connection.put_config_vars(app_name, updated_and_added_vars) }
        removed_vars.each do |key, _|
          Rails.logger.debug "deleting #{key}"
          catch_heroku_errors { connection.delete_config_var(app_name, key) }
        end
        errors.blank?
      end

      def save_to_env
        ENV.update vars
        removed_vars.each { |key, _| ENV.delete key }
      end

  end
end
