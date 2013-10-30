require "rsqoot/client"

module RSqoot

  class << self
    attr_accessor :public_api_key, :private_api_key, :base_api_url, :authentication_method, :read_timeout

    # Configure default credentials easily
    #
    # @yield [Sqoot]
    def configure
      load_defaults
      yield self
      raise "Authentication method must be :header or :parameter ." if !AUTHENTICATION_METHODS.include? self.authentication_method
      true
    end

    def load_defaults
      self.base_api_url ||= "https://api.sqoot.com"
      self.authentication_method = :header
      self.read_timeout = 60
    end

    private

    AUTHENTICATION_METHODS = [:header, :parameter]

  end

end
