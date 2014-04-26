require 'active_support/core_ext'
require 'rsqoot/client'
require 'rsqoot/logger'

module RSqoot

  class << self
    attr_accessor :public_api_key,
                  :private_api_key,
                  :base_api_url,
                  :authentication_method,
                  :read_timeout,
                  :expired_in

    # Configure default credentials easily
    #
    # @yield [RSqoot]
    def configure
      load_defaults
      yield self
      fail 'You must add your own public api key to initializer .' if public_api_key.nil?
      fail 'You must add your own private api key to initializer .' if private_api_key.nil?
      fail 'Authentication method must be :header or :parameter .' unless AUTHENTICATION_METHODS.include? authentication_method
      SqootClient.reload!
      true
    end

    def load_defaults
      self.base_api_url ||= 'https://api.sqoot.com'
      self.authentication_method = :header
      self.read_timeout = 60.seconds
      self.expired_in = 1.hour
    end

    private

    AUTHENTICATION_METHODS = [:header, :parameter]
  end
end

begin
  RSqoot.load_defaults
  SqootClient ||= RSqoot::Client.instance
rescue => e
  RSqoot::Logger.logger error: e
end
